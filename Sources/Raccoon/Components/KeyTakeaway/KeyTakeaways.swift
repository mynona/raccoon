import HTML
import SGML
import SVG
import WebBuilders

public struct KeyTakeaways: TemplateRepresentable {
    let data: KeyTakeawaysData
    typealias styles = KeyTakeawaysStyles

    public init(
        _ data: KeyTakeawaysData
    ) {
        self.data = data
    }

    @Builder<Element>
    func showHeader() -> [Element] {
        Header {
            Svg.icon(data.icon, width: 24, height: 24)
                .class("flex-initial align-middle")
                .addClass(styles.iconColor)

            H3(data.title)
                .class("flex-1 align-middle !pt-0 !my-0")
                .addClass(styles.textLabel)

        }
        .class("flex space-x-4 items-center")
    }

    @Builder<Element>
    public func render() -> [Element] {

        DebugComment("KeyTakeaways")
        Section {

            Div {

                showHeader()

                Div {
                    InlineText(
                        renderMarkdownAsHTML(data.contentAsMarkdown),
                        isRaw: true
                    )
                }
                .class("mt-8")
                .addClass(styles.prose)

            }
            .class("p-4")

        }
        .class("my-10")
        .addClass(styles.container)

    }
}
