import HTML
import SGML
import WebBuilders

public struct Label: TemplateRepresentable {
    let data: LabelData
    typealias styles = LabelStyles

    public init(
        _ data: LabelData
    ) {
        self.data = data
    }

    private static let required = LocalizedText(
        "label.required",
        "(required)"
    )

    private static func requiredMarkup(_ text: String) -> String {
        #"<span class="sr-only" data-i18n="label.required">"#
            + JavaScriptEscaper.htmlAttributeEscape(text) + "</span>"
    }

    /// Constant markup per language, built once. A language without translation uses English.
    private static let requiredMarkupByLanguage: [String: String] = {
        var result = ["en": requiredMarkup(required.english)]
        for (language, text) in Translations.label["required"] ?? [:] {
            result[language] = requiredMarkup(text)
        }
        return result
    }()

    /// Markup for the language of the page that is rendered.
    private static func requiredMarkupForPage() -> String {
        let context = I18n.context
        context.record(required.key)
        return requiredMarkupByLanguage[context.language]
            ?? requiredMarkupByLanguage["en"]!
    }

    @Builder<Element>
    func showRequired() -> [Element] {
        if data.isRequired {
            Span { Svg.icon(.asterisk, width: 8, height: 8) }
                .setAttribute(
                    name: "aria-hidden",
                    value: "true"
                )
            InlineText(Self.requiredMarkupForPage(), isRaw: true)
        }
    }

    @Builder<Element>
    public func render() -> [Element] {

        let title = data.title ?? LocalizedText(verbatim: data.id.capitalized)

        DebugComment("Label")
        Div {

            HTML.Label {

                // An x-html span is controlled by Alpine, so it gets no translation marker
                Span(title.resolved)
                    .if(data.xhtml != nil) {
                        $0.setAttribute(
                            name: "x-html",
                            value: "\(data.xhtml!)"
                        )
                    } else: {
                        $0.localized(title)
                    }

                showRequired()
            }
            .id("label-\(data.id)")
            .class("flex space-x-1 items-center")
            .addClass(styles.font)
            .if(data.isDisabled) {

                $0
                    .addClass(styles.textColorDisabled)
                    .addClass(styles.cursorNotAllowed)

            } else: {
                $0.addClass(styles.textColorDefault)
            }
            .if(data.size == .sm) {
                $0.addClass(styles.textSizeTiny)
            }
            .if(data.size == .base) {
                $0.addClass(styles.textSizeBase)
            }
            .if(data.size == .xl) {
                $0.addClass(styles.textSizeLarge)
            }
            .for(data.id)

        }
        .class("w-full flex")
        .if(data.position == .right) {
            $0.addClass("justify-end")
        }
        .if(data.position == .left) {
            $0.addClass("justify-start")
        }

    }
}
