import HTML
import SGML
import SVG
import WebBuilders

public struct LinkList: TemplateRepresentable {
    let data: LinkListData
    typealias styles = LinkListStyles

    public init(
        _ data: LinkListData
    ) {
        self.data = data
    }

    @Builder<Element>
    func showLink(key: String, value: String) -> [Element] {
        LinkButton(
            LinkButtonData(
                label: key,
                ariaLabel: key,
                href: value,
                hreflang: AppValues.lang,
                buttonType: .tertiary,
                icon: data.icon,
                iconSize: 20,
                hasFullWidth: false,
                matomoStatus: data.matomoStatus,
                contentTracker: MatomoContentTracker(
                    name: data.contentTracker.name,
                    piece: key,
                    target: value
                )
            )
        )
        .render()
    }

    @Builder<Element>
    public func render() -> [Element] {

        DebugComment("Link List")
        Ul {
            for link in data.links {
                // List is non-deterministic (unordered dictionary). This is intentional.
                if let href = link.value, !href.isEmpty {
                    Li { showLink(key: link.key, value: href) }
                        .class("py-2 max-w-full")
                }
            }
        }
        .class("py-2")
        .addClass(styles.list)
    }

}
