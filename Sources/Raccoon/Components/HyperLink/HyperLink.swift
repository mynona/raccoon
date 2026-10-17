import HTML
import SGML
import SVG
import WebBuilders

public struct HyperLink: TemplateRepresentable {
    let data: HyperLinkData
    typealias styles = HyperLinkStyles

    public init(
        _ data: HyperLinkData
    ) {
        self.data = data
    }

    @Builder<Element>
    func showTooltip(_ contentId: String?) -> [Element] {
        if let tooltip = data.tooltip, let contentId {
            Tooltip(
                TooltipData(
                    id: "content\(contentId)",
                    text: tooltip
                )
            )
            .render()
        }
    }

    @Builder<Element>
    func showIcon() -> [Element] {
        if let icon = data.icon, let iconSize = data.iconSize {
            Div { Svg.icon(icon, width: iconSize, height: iconSize) }
                .class("flex-none")
        }
    }

    @Builder<Element>
    func showLabel() -> [Element] {
        if let label = data.label {
            Span(label)
                .class("min-w-0 break-words leading-normal")
                .if(isCentered()) {
                    $0.addClass("text-center")
                } else: {
                    $0.addClass("text-left")
                }
                .if(data.isUnderlined) {
                    $0.addClass(styles.underlinedLabel)
                }
        }
    }

    func isCentered() -> Bool {
        if let alignment = data.align,
            alignment == .center
        {
            return true
        }
        return false
    }

    @Builder<Element>
    public func render() -> [Element] {
        let contentId: String? =
            if data.tooltip != nil {
                data.tooltipId
                    ?? StableIdentifier.unique(
                        data.tooltip ?? data.label ?? data.href
                    )
            }
            else {
                nil
            }

        DebugComment("Link")
        Div {

            A {
                showIcon()
                showLabel()
            }
            .href(data.href)
            .if(data.hreflang != nil) {
                $0.hrefLang(data.hreflang!)
            }
            .if(data.target != nil) {
                $0.target(data.target!)
            }
            .if(data.rel != nil) {
                $0.rel(data.rel!)
            }
            // alpine add x-ref if tooltip is present
            .if(contentId != nil) {
                $0.setAttribute(
                    name: "x-ref",
                    value: "content\(contentId!)"
                )
            }
            .class("inline-flex items-center space-x-2 p-1 max-w-full")

            // isUnderlined == true
            .if(data.isUnderlined) {
                $0.addClass(styles.underlined)
            } else: {
                // isUnderlined == false
                $0.addClass("!no-underline")
            }
            // styling
            .addClass(styles.link)
            .if(data.isFocusable) {
                $0.addClass("\(styles.focus)")
            } else: {
                $0.addClass(styles.focusNon)
                    .tabIndex(-1)
            }
            // aria
            .if(data.ariaLabel != nil) {
                $0.setAttribute(
                    name: "aria-label",
                    value: data.ariaLabel!
                )
            }
            // alignment
            .if(isCentered()) {
                $0.addClass("justify-center")
            }
            // tooltip
            .if(contentId != nil) {
                let id = contentId!
                return
                    $0
                    .setAttribute(
                        name: "aria-describedby",
                        value: "content\(id)"
                    )
                    .setAttribute(
                        name: "x-on:mouseenter",
                        value:
                            "window.dispatchEvent(new CustomEvent('show-tooltip', { detail: { id: 'content\(id)' } }))"
                    )
                    .setAttribute(
                        name: "x-on:mouseleave",
                        value:
                            "window.dispatchEvent(new CustomEvent('hide-tooltip', { detail: { id: 'content\(id)' } }))"
                    )
                    .setAttribute(
                        name: "x-on:focus",
                        value:
                            "window.dispatchEvent(new CustomEvent('show-tooltip', { detail: { id: 'content\(id)' } }))"
                    )
                    .setAttribute(
                        name: "x-on:blur",
                        value:
                            "window.dispatchEvent(new CustomEvent('hide-tooltip', { detail: { id: 'content\(id)' } }))"
                    )

            }
            // Matomo
            .if(data.matomoStatus == .ACCEPTED || data.matomoStatus == .BANNER)
            {

                $0
                    .flagAttribute("data-track-content")
                    .setAttribute(
                        name: "data-content-name",
                        value: data.contentTracker.name
                    )
                    .setAttribute(
                        name: "data-content-piece",
                        value: data.contentTracker.piece
                    )
                    .setAttribute(
                        name: "data-content-target",
                        value: data.contentTracker.target
                    )

            }

            showTooltip(contentId)

        }
        .class("relative inline-block max-w-full")
        .if(data.tooltip != nil) {
            $0.setAttribute(
                name: "x-data",
                value: ""
            )
        }

    }

}
