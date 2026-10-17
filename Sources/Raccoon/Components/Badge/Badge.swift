import HTML
import SGML
import SVG
import WebBuilders

public struct Badge: TemplateRepresentable {
    let data: BadgeData
    typealias styles = BadgeStyles

    public init(
        _ data: BadgeData
    ) {
        self.data = data
    }

    func title() -> String {
        if data.hasHyphenFormatting {
            return data.title.replacingOccurrences(of: "-", with: " ")
        }
        return data.title
    }

    func buildTagUrl(urlTag: String) -> String {
        let prefix = data.tagUrlPrefix
        guard prefix.hasSuffix("/") else {
            return "\(prefix)/\(urlTag)/"
        }
        return "\(prefix)\(urlTag)/"
    }

    func buildMatomoTarget(urlTag: String) -> String {
        let prefix = data.tagUrlPrefix
        guard prefix.hasSuffix("/") else {
            return "\(prefix)/\(urlTag)"
        }
        return "\(prefix)\(urlTag)"
    }

    @Builder<Element>
    func showCounter() -> [Element] {
        if let counter = data.counter {
            Span("\(counter)")
                .class("py-1 px-2")
                .addClass("rounded-r-lg border-r border-y")
                .addClass(styles.counterBorderColor)
                .addClass(styles.font)
                .addClass(styles.textSize)
                .addClass(styles.counterTextColor)
                .ariaLabel("\(counter) articles tagged with '\(title())'")
        }
    }

    @Builder<Element>
    func showIconWithTitle() -> [Element] {
        Span {
            Svg.icon(.hash, width: 16, height: 16)
            Span("\(title())")
        }
        .class("flex flex-row gap-1 items-center py-1 px-4")
        .addClass(styles.focusReset)
        .addClass(styles.iconBorder)
        .addClass(styles.font)
        .addClass(styles.textSize)
        .addClass(styles.labelText)
        .if(data.counter != nil) {
            $0.addClass("rounded-l-lg")
        } else: {
            $0.addClass("rounded-lg")
        }
    }

    @Builder<Element>
    public func render() -> [Element] {

        DebugComment("Tag")
        Div {
            if data.isLink,
                let urlTag = data.title
                    .lowercased()
                    .addingPercentEncoding(
                        withAllowedCharacters: .urlPathAllowed
                    )
            {

                A {

                    Div {
                        showIconWithTitle()
                        showCounter()
                    }
                    .class("flex flex-row items-center")

                }
                .ariaLabel("View all articles tagged as '\(title())'")
                .href(buildTagUrl(urlTag: urlTag))
                .hrefLang(AppValues.lang)
                // Matomo
                .if(
                    data.matomoStatus == .ACCEPTED
                        || data.matomoStatus == .BANNER
                ) {

                    $0
                        .flagAttribute("data-track-content")
                        .setAttribute(
                            name: "data-content-name",
                            value: "badge"
                        )
                        .setAttribute(
                            name: "data-content-piece",
                            value: "link.tag"
                        )
                        .setAttribute(
                            name: "data-content-target",
                            value: buildMatomoTarget(urlTag: urlTag)
                        )

                }
                .addClass(styles.cursorPointer)
                .addClass(styles.focusDefault)
                .addClass(styles.hoverDefault)

            }
            else {
                // covers both isLink == false and a failed percent-encoding
                showIconWithTitle()
                showCounter()
            }

        }
        .id(data.id)
        .role("group")
        .if(!data.isLink) {
            $0.ariaLabel("Articles tagged as '\(title())'")
        }
        .class(styles.fontSans)
        .addClass(
            "inline-flex items-center whitespace-nowrap cursor-default flex flex-row"
        )

    }
}
