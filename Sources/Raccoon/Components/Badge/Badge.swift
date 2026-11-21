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

    /// The title with the hyphen formatting applied in every language.
    func title() -> LocalizedText {
        guard data.hasHyphenFormatting else { return data.title }
        let title = data.title
        if title.key.isEmpty {
            return LocalizedText(
                en: title.template.replacingOccurrences(of: "-", with: " "),
                translations: title.translations.mapValues {
                    $0.replacingOccurrences(of: "-", with: " ")
                },
                variables: title.variables
            )
        }
        return LocalizedText(
            verbatim: title.resolved.replacingOccurrences(of: "-", with: " ")
        )
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
                .localized(
                    .ariaLabel,
                    LocalizedText(
                        "badge.counter",
                        "Articles tagged '{{title}}': {{count}}",
                        variables: [
                            "title": title().resolved, "count": "\(counter)",
                        ]
                    )
                )
        }
    }

    /// Text and background colors of the filled status variants.
    private var statusColors: String {
        switch data.variant {
        case .tag: ""
        case .neutral: styles.neutral
        case .success: styles.success
        case .error: styles.error
        }
    }

    @Builder<Element>
    func showIconWithTitle() -> [Element] {
        let isTag = data.variant == .tag
        Span {
            if let icon = data.icon {
                Svg.icon(icon, width: 16, height: 16)
            }
            Span(title().resolved)
                .localized(title())
                .if(data.bindTitle != nil) {
                    $0.setAttribute(name: "x-text", value: data.bindTitle!)
                }
        }
        .class(
            isTag
                ? "flex flex-row gap-1 items-center py-1 px-4"
                : "flex flex-row gap-1 items-center py-0.5 px-3"
        )
        .addClass(styles.focusReset)
        .if(isTag) { $0.addClass(styles.iconBorder) }
        .addClass(styles.font)
        .addClass(styles.textSize)
        .addClass(isTag ? styles.labelText : statusColors)
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
                let urlTag = data.title.english
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
                .localized(
                    .ariaLabel,
                    LocalizedText(
                        "badge.viewAll",
                        "View all articles tagged as '{{title}}'",
                        variables: ["title": title().resolved]
                    )
                )
                .href(buildTagUrl(urlTag: urlTag))
                // Matomo
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
        .if(data.id != nil) {
            $0.id(data.id!)
        }
        .role("group")
        .if(data.bindAriaLabel != nil) {
            $0.setAttribute(
                name: ":aria-label",
                value: data.bindAriaLabel!
            )
        }
        .if(!data.isLink && data.bindAriaLabel == nil) {
            $0.localized(
                .ariaLabel,
                data.ariaLabel
                    ?? LocalizedText(
                        "badge.group",
                        "Articles tagged as '{{title}}'",
                        variables: ["title": title().resolved]
                    )
            )
        }
        .class(styles.fontSans)
        .addClass(
            "inline-flex items-center whitespace-nowrap cursor-default flex flex-row"
        )

    }
}
