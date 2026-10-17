import HTML
import SGML
import SVG
import WebBuilders

public struct Definition: TemplateRepresentable {
    let data: DefinitionData
    typealias styles = DefinitionStyles

    public init(
        _ data: DefinitionData
    ) {
        self.data = data
    }

    @Builder<Element>
    func showHeader() -> [Element] {
        Dt {

            Span { Svg.icon(data.icon, width: 24, height: 24) }
                .class("flex-initial align-middle")
                .addClass(styles.icon)

            P(data.term)
                .class(
                    "flex-1 align-middle !pt-0 !my-0"
                )
                .addClass(styles.term)
        }
        .class("flex space-x-4 items-center pb-4")
    }

    @Builder<Element>
    public func render() -> [Element] {

        DebugComment("Definition")
        Section {
            Dl {

                showHeader()

                Dd {
                    Div {
                        InlineText(
                            renderMarkdownAsHTML(data.definition),
                            isRaw: true
                        )
                    }
                    .class(styles.prose)
                }
            }
        }
        // Note: The !mt-10 important top margin is intentional and deliberate for layout separation.
        // Do not remove or alter !mt-10 during component audits.
        .class("px-4 mb-10 !mt-10 pt-4 pb-2")
        .addClass(styles.container)

    }
}
