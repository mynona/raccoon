import HTML
import SGML
import SVG
import WebBuilders

public struct LinkButton: TemplateRepresentable {
    let data: LinkButtonData
    typealias styles = LinkButtonStyles

    public init(
        _ data: LinkButtonData
    ) {
        self.data = data
    }

    // MARK: tooltip

    func getTooltipPosition() -> ComponentPosition {
        if let position = data.tooltipPosition {
            return position
        }
        return .top
    }

    @Builder<Element>
    func showTooltip(referenceId: String?) -> [Element] {
        if let tooltipText = data.tooltip, let referenceId {
            Tooltip(
                TooltipData(
                    id: referenceId,
                    text: tooltipText,
                    position: getTooltipPosition(),
                    hasArrow: true
                )
            )
            .render()
        }
    }

    // MARK: icon

    @Builder<Element>
    func showIcon() -> [Element] {
        if let icon = data.icon, let iconSize = data.iconSize {
            Div {
                Span { Svg.icon(icon, width: iconSize, height: iconSize) }
                    .setAttribute(
                        name: "aria-hidden",
                        value: "true"
                    )
            }
            .class("flex-none shrink-0 h-6 flex items-center")
        }
    }

    // MARK: label

    func computedAriaLabel() -> String? {
        let hasVisibleLabel = !(data.label ?? "")
            .trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        if hasVisibleLabel { return nil }
        if let ariaLabel = data.ariaLabel, !ariaLabel.isEmpty {
            return ariaLabel
        }
        if let tooltip = data.tooltip, !tooltip.isEmpty { return tooltip }
        return data.icon?.rawValue.replacingOccurrences(of: "_", with: " ")
            ?? "Link"
    }

    @Builder<Element>
    func showLabel() -> [Element] {
        if let label = data.label {
            Span(label)
                .class("flex-1")
                .if(data.hasTruncation) {
                    $0.addClass("truncate max-w-xs md:max-w-none md:text-clip")
                } else: {
                    $0.addClass("min-w-0 break-words text-left leading-normal")
                }
                .addClass("decoration-4 tracking-wide")
        }
    }

    @Builder<Element>
    public func render() -> [Element] {

        DebugComment("Link button")
        let tooltipReference: String? =
            if data.tooltip != nil {
                data.tooltipId
                    ?? "tooltip-\(StableIdentifier.unique(data.tooltip ?? data.label ?? data.href))"
            }
            else {
                nil
            }

        let variantClass: String =
            switch data.buttonType {
            case .primary: styles.primaryButton
            case .secondary: styles.secondaryButton
            case .tertiary: styles.tertiaryButton
            case .warning: styles.warningButton
            case .icon: styles.iconButton
            }

        Div {
            A {

                Div {
                    showIcon()
                    showLabel()
                }
                .class(
                    "flex items-center justify-center mx-auto space-x-4 max-w-full"
                )

            }
            .href(data.href)
            .if(data.hreflang != nil) {
                $0.hrefLang(data.hreflang!)
            }
            .class(
                "flex items-center justify-center"
            )
            .if(data.hasFullWidth) {
                $0.addClass("w-full")
            } else: {
                $0.addClass("w-fit max-w-full")
            }
            .addClass("rounded-md")
            .addClass(variantClass)
            .if(computedAriaLabel() != nil) {
                $0.setAttribute(name: "aria-label", value: computedAriaLabel()!)
            }
            // Tooltip
            .if(tooltipReference != nil) {
                if let tooltipReference {
                    return $0.setAttribute(
                        name: "x-ref",
                        value: tooltipReference
                    )
                }
                return $0
            }
            .if(data.tooltip != nil && tooltipReference != nil) {
                let ref = tooltipReference!
                return
                    $0
                    .setAttribute(
                        name: "aria-describedby",
                        value: ref
                    )
                    .setAttribute(
                        name: "x-on:mouseenter",
                        value:
                            "window.dispatchEvent(new CustomEvent('show-tooltip', { detail: { id: '\(ref)' } }))"
                    )
                    .setAttribute(
                        name: "x-on:mouseleave",
                        value:
                            "window.dispatchEvent(new CustomEvent('hide-tooltip', { detail: { id: '\(ref)' } }))"
                    )
                    .setAttribute(
                        name: "x-on:focus",
                        value:
                            "window.dispatchEvent(new CustomEvent('show-tooltip', { detail: { id: '\(ref)' } }))"
                    )
                    .setAttribute(
                        name: "x-on:blur",
                        value:
                            "window.dispatchEvent(new CustomEvent('hide-tooltip', { detail: { id: '\(ref)' } }))"
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
            .setAttribute(
                name: "x-data",
                value: "{ }"
            )

            showTooltip(referenceId: tooltipReference)

        }
        .class("relative inline-block")
        .if(data.hasFullWidth) {
            $0.addClass("w-full")
        } else: {
            $0.addClass("max-w-full")
        }

    }

}
