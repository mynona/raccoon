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

    func computedAriaLabel() -> LocalizedText? {
        let hasVisibleLabel = !(data.label?.english ?? "")
            .trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        if hasVisibleLabel { return nil }
        if let ariaLabel = data.ariaLabel, !ariaLabel.english.isEmpty {
            return ariaLabel
        }
        if let tooltip = data.tooltip, !tooltip.english.isEmpty {
            return tooltip
        }
        if let icon = data.icon {
            // The icon name is an identifier, not a translatable text
            return LocalizedText(
                verbatim: icon.rawValue.replacingOccurrences(of: "_", with: " ")
            )
        }
        return LocalizedText("linkbutton.link", "Link")
    }

    @Builder<Element>
    func showLabel() -> [Element] {
        if let label = data.label {
            Span(label.resolved)
                .localized(label)
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
                    ?? "tooltip-\(StableIdentifier.unique(data.tooltip?.english ?? data.label?.english ?? data.href))"
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
                $0.localized(.ariaLabel, computedAriaLabel()!)
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
                            "$dispatch('show-tooltip', { id: '\(ref)' })"
                    )
                    .setAttribute(
                        name: "x-on:mouseleave",
                        value:
                            "$dispatch('hide-tooltip', { id: '\(ref)' })"
                    )
                    .setAttribute(
                        name: "x-on:focus",
                        value:
                            "$dispatch('show-tooltip', { id: '\(ref)' })"
                    )
                    .setAttribute(
                        name: "x-on:blur",
                        value:
                            "$dispatch('hide-tooltip', { id: '\(ref)' })"
                    )

            }
            // Matomo
            .if(
                data.contentTracker != nil
                    && (data.matomoStatus == .ACCEPTED
                        || data.matomoStatus == .BANNER)
            ) {
                guard let tracker = data.contentTracker else { return $0 }
                return
                    $0
                    .flagAttribute("data-track-content")
                    .setAttribute(
                        name: "data-content-name",
                        value: tracker.name
                    )
                    .setAttribute(
                        name: "data-content-piece",
                        value: tracker.piece
                    )
                    .setAttribute(
                        name: "data-content-target",
                        value: tracker.target
                    )
            }
            .if(
                data.contentTracker?.impression == true
                    && (data.matomoStatus == .ACCEPTED
                        || data.matomoStatus == .BANNER)
            ) {
                $0.flagAttribute("data-track-impression")
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
