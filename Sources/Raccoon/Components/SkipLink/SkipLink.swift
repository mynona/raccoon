import HTML
import SGML
import WebBuilders

public struct SkipLink: TemplateRepresentable {
    let data: SkipLinkData
    typealias styles = SkipLinkStyles

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
        A(data.text)
            .href(targetHref)
            .if(data.hreflang != nil) {
                $0.hrefLang(data.hreflang!)
            }
            .class(styles.skipLink)
    }
}
