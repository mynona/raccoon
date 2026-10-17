import HTML
import SGML
import WebBuilders

public struct HelperText: TemplateRepresentable {
    let data: HelperTextData
    typealias styles = HelperTextStyles

    public init(
        _ data: HelperTextData
    ) {
        self.data = data
    }

    @Builder<Element>
    public func render() -> [Element] {
        if let title = data.text,
            !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        {
            DebugComment("Helper text")
            if data.isMarkdown {
                Div { InlineText(renderMarkdownAsHTML(title), isRaw: true) }
                    .id("\(data.id)-helper")
                    .class("mt-2")
                    .addClass(styles.textSizeSmall)
                    .addClass(styles.textColor)
            }
            else {
                P(title)
                    .id("\(data.id)-helper")
                    .class("mt-2")
                    .addClass(styles.textSizeSmall)
                    .addClass(styles.textColor)
            }
        }
    }
}
