import HTML
import SGML
import WebBuilders

public struct SkipLink: TemplateRepresentable {
    let data: SkipLinkData
    typealias styles = SkipLinkStyles

    private static let jump = LocalizedText(
        "skiplink.jump",
        "Jump directly to the main content"
    )

    public init(
        _ data: SkipLinkData = .init()
    ) {
        self.data = data
    }

    @Builder<Element>
    public func render() -> [Element] {
        DebugComment("Skip link")
        let targetHref =
            data.targetId.hasPrefix("#") ? data.targetId : "#\(data.targetId)"
        let text = data.text ?? Self.jump
        A(text.resolved)
            .localized(text)
            .href(targetHref)
            .class(styles.skipLink)
    }
}
