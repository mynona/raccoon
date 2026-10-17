import HTML
import SGML
import SVG
import WebBuilders

public struct MarkdownBlock: TemplateRepresentable {
    let data: MarkdownBlockData
    typealias styles = MarkdownBlockStyles

    public init(
        _ data: MarkdownBlockData
    ) {
        self.data = data
    }

    @Builder<Element>
    public func render() -> [Element] {

        DebugComment("Markdown")
        Section(data.rendered)
            .class("max-w-none")
            .if(data.isProse) {
                $0.addClass(styles.prose)
            }

    }
}
