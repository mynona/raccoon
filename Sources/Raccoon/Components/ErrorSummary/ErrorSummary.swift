import HTML
import SGML
import WebBuilders

/// Summary of the problems of a form: how many fields are wrong and a link to each of them.
///
/// It is rendered above the first field of a `FormBuilder` and receives focus when the page
/// loads with problems, so a screen reader announces the whole list at once. It is not a live
/// region: focusing the container announces its content.
public struct ErrorSummary: TemplateRepresentable {
    let data: ErrorSummaryData
    typealias styles = ErrorSummaryStyles

    private static let headingOne = LocalizedText(
        "errorsummary.one",
        "There is 1 problem with your submission"
    )
    private static let headingOther = LocalizedText(
        "errorsummary.other",
        "There are {{count}} problems with your submission"
    )
    /// Label of the entry for form-level errors.
    static let formLabel = LocalizedText("errorsummary.form", "Form")

    public init(
        _ data: ErrorSummaryData
    ) {
        self.data = data
    }

    /// The count is the number of fields with a problem, not the number of messages.
    /// The plural form is chosen here: `LocalizedText` has no automatic plural.
    var heading: LocalizedText {
        let count = data.entries.count
        return count == 1
            ? Self.headingOne
            : Self.headingOther.with(variables: ["count": "\(count)"])
    }

    @Builder<Element>
    func showEntry(_ entry: FormErrorEntry) -> [Element] {
        Li {
            // The link text names the field and the problem
            A {
                Span(entry.label.resolved).localized(entry.label)
                Span(": ")
                for (index, message) in entry.messages.enumerated() {
                    if index > 0 { Span(" ") }
                    Span(message.resolved).localized(message)
                }
            }
            .href("#\(entry.fieldId)")
            // Without JavaScript the plain `href` still jumps to the control
            .setAttribute(
                name: "@click.prevent",
                value: "focusField($el.hash.slice(1))"
            )
            .class(styles.link)
        }
        .class(styles.item)
    }

    @Builder<Element>
    public func render() -> [Element] {

        DebugComment("Error summary")
        Script()
            .src("/js/error-summary.js")
            .setAttribute(name: "type", value: "text/javascript")

        let heading = self.heading
        Div {
            H2(heading.resolved)
                .localized(heading)
                .id("\(data.id)-heading")
                .class(styles.heading)

            Ul {
                for entry in data.entries {
                    showEntry(entry)
                }
            }
            .class(styles.list)
        }
        .id(data.id)
        .setAttribute(name: "tabindex", value: "-1")
        .setAttribute(name: "aria-labelledby", value: "\(data.id)-heading")
        .setAttribute(name: "x-data", value: "errorSummary()")
        .setAttribute(name: "data-error-summary", value: "")
        // Texts and classes the script needs to rebuild the summary on the client
        .setAttribute(
            name: "data-heading-one",
            value: JavaScriptEscaper.htmlAttributeEscape(Self.headingOne.resolved)
        )
        .setAttribute(
            name: "data-heading-other",
            value: JavaScriptEscaper.htmlAttributeEscape(Self.headingOther.resolved)
        )
        .setAttribute(
            name: "data-item-class",
            value: styles.item
        )
        .setAttribute(
            name: "data-link-class",
            value: styles.link
        )
        .if(data.entries.isEmpty) {
            $0.flagAttribute("hidden")
        }
        .class(styles.summary)
    }
}
