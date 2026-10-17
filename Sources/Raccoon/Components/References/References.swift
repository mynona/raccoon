import HTML
import SGML
import SVG
import WebBuilders

public struct References: TemplateRepresentable {
    let data: ReferencesData
    typealias styles = ReferencesStyles

    public init(
        _ data: ReferencesData
    ) {
        self.data = data
    }

    @Builder<Element>
    public func render() -> [Element] {

        let headingTitle =
            data.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            ? "References and further reading"
            : data.title

        DebugComment("References")
        Div {

            P(headingTitle)
                .class(styles.fontWeightBold)

            Div {
                InlineText(
                    renderMarkdownAsHTML(data.contentAsMarkdown),
                    isRaw: true
                )
            }
            .class(styles.references)

        }
        .class("px-6 pt-4 pb-4 mt-16")
        .addClass(styles.prose)
        .addClass(styles.referencesContainer)

    }
}
