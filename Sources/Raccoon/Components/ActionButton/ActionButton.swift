import HTML
import SGML
import SVG
import WebBuilders

public struct ActionButton: TemplateRepresentable {
    let data: ActionButtonData
    typealias styles = ActionButtonStyles

    public init(
        _ data: ActionButtonData
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
        if data.state != .disabled, let tooltipText = data.tooltip,
            let referenceId
        {
            Tooltip(
                TooltipData(
                    id: referenceId,
                    bindId: data.bindTooltipId,
                    text: tooltipText,
                    position: getTooltipPosition(),
                    hasArrow: true
                )
            )
            .render()
        }
    }

    // MARK: icon

    func getIconSize() -> Int {
        switch data.size {
        case .sm:
            return 14
        case .base:
            return 16
        case .xl:
            return 20
        }
    }

    @Builder<Element>
    func showIcon() -> [Element] {
        if let icon = data.icon {
            let iconSize = getIconSize()
            let isDecorative =
                (data.label?.trimmingCharacters(in: .whitespacesAndNewlines)
                    .isEmpty == false)
            Div {
                Svg.icon(icon, width: iconSize, height: iconSize)
            }
            .class("flex-none shrink-0 align-middle")
            .if(isDecorative) {
                $0.setAttribute(name: "aria-hidden", value: "true")
            }
        }
    }

    // MARK: label

    func computedAriaLabel() -> String? {
        if let ariaLabel = data.ariaLabel {
            return ariaLabel
        }
        if data.label == nil
            || data.label?.trimmingCharacters(in: .whitespacesAndNewlines)
                .isEmpty == true
        {
            if let tooltip = data.tooltip, !tooltip.isEmpty {
                return tooltip
            }
            else if let icon = data.icon {
                return icon.rawValue.replacingOccurrences(of: "_", with: " ")
            }
            else {
                return "Action"
            }
        }
        return nil
    }

    @Builder<Element>
    func showLabel() -> [Element] {
        if let label = data.label {
            let sizeClass: String =
                switch data.size {
                case .sm: styles.textSizeSmall
                case .base: styles.textSizeBase
                case .xl: styles.textSizeLarge
                }
            Span(label)
                .class(
                    "flex-1 min-w-0 break-words text-left leading-normal tracking-wide"
                )
                .addClass(sizeClass)
        }
    }

    @Builder<Element>
    public func render() -> [Element] {

        DebugComment("Button")
        let tooltipReference: String? =
            if data.tooltip != nil {
                data.tooltipId
                    ?? "tooltip-\(StableIdentifier.unique(data.tooltip ?? data.label ?? data.icon?.rawValue ?? data.id ?? "button"))"
            }
            else {
                nil
            }
        let ariaLabelText = computedAriaLabel()

        let variantClass: String =
            if data.state == .disabled {
                styles.disabledButton
            }
            else {
                switch data.buttonType {
                case .primary: styles.primaryButton
                case .secondary: styles.secondaryButton
                case .tertiary: styles.tertiaryButton
                case .icon: styles.iconButton
                case .warning: styles.warningButton
                }
            }

        Div {

            Button {

                Div {
                    showIcon()
                    showLabel()
                }
                .class(
                    "flex items-center justify-center mx-auto space-x-4 max-w-full"
                )

            }
            .if(data.bindTooltipId != nil) {
                if let bindTooltipId = data.bindTooltipId {
                    return $0.setAttribute(
                        name: ":x-ref",
                        value: bindTooltipId
                    )
                }
                return $0
            } else: {
                if let tooltipReference {
                    return $0.setAttribute(
                        name: "x-ref",
                        value: tooltipReference
                    )
                }
                return $0
            }
            .type(data.htmlType)
            .if(data.bindId != nil) {
                if let bindId = data.bindId {
                    return $0.setAttribute(
                        name: ":id",
                        value: bindId
                    )
                }
                return $0
            } else: {
                if let id = data.id {
                    return $0.id(id)
                }
                return $0
            }
            .if(data.clickAction != nil) {
                if let clickAction = data.clickAction {
                    return $0.setAttribute(
                        name: "x-on:click",
                        value: "\(clickAction)"
                    )
                }
                return $0
            }
            .if(data.action != nil) {
                if let action = data.action {
                    return $0.formAction(action)
                }
                return $0
            }
            .if(data.method != nil) {
                if let method = data.method {
                    return $0.formMethod(method)
                }
                return $0
            }
            .if(data.bindAction != nil) {
                if let bindAction = data.bindAction {
                    return $0.setAttribute(
                        name: "x-bind:formaction",
                        value: "\(bindAction)"
                    )
                }
                return $0
            }
            .if(ariaLabelText != nil) {
                if let ariaLabelText {
                    return $0.ariaLabel(ariaLabelText)
                }
                return $0
            }
            .if(data.bindAriaExpanded != nil) {
                if let bindAriaExpanded = data.bindAriaExpanded {
                    return $0.setAttribute(
                        name: ":aria-expanded",
                        value: bindAriaExpanded
                    )
                }
                return $0
            }
            .if(data.bindAriaPressed != nil) {
                if let bindAriaPressed = data.bindAriaPressed {
                    return $0.setAttribute(
                        name: ":aria-pressed",
                        value: bindAriaPressed
                    )
                }
                return $0
            }
            .class("flex items-center justify-center")
            .if(data.hasFullWidth) {
                $0.addClass("w-full")
            } else: {
                $0.addClass("w-fit max-w-full")
            }
            .addClass("rounded-md")
            .addClass(variantClass)
            .if(data.state == .disabled) {
                $0.disabled()
            }

            // Tooltip
            .if(data.tooltip != nil) {
                if let bindTooltipId = data.bindTooltipId {
                    return
                        $0
                        .setAttribute(
                            name: ":aria-describedby",
                            value: bindTooltipId
                        )
                        .setAttribute(
                            name: "x-on:mouseenter",
                            value:
                                "window.dispatchEvent(new CustomEvent('show-tooltip', { detail: { id: \(bindTooltipId) } }))"
                        )
                        .setAttribute(
                            name: "x-on:mouseleave",
                            value:
                                "window.dispatchEvent(new CustomEvent('hide-tooltip', { detail: { id: \(bindTooltipId) } }))"
                        )
                        .setAttribute(
                            name: "x-on:focus",
                            value:
                                "window.dispatchEvent(new CustomEvent('show-tooltip', { detail: { id: \(bindTooltipId) } }))"
                        )
                        .setAttribute(
                            name: "x-on:blur",
                            value:
                                "window.dispatchEvent(new CustomEvent('hide-tooltip', { detail: { id: \(bindTooltipId) } }))"
                        )
                }
                else if let tooltipReference {
                    return
                        $0
                        .setAttribute(
                            name: "aria-describedby",
                            value: tooltipReference
                        )
                        .setAttribute(
                            name: "x-on:mouseenter",
                            value:
                                "window.dispatchEvent(new CustomEvent('show-tooltip', { detail: { id: '\(tooltipReference)' } }))"
                        )
                        .setAttribute(
                            name: "x-on:mouseleave",
                            value:
                                "window.dispatchEvent(new CustomEvent('hide-tooltip', { detail: { id: '\(tooltipReference)' } }))"
                        )
                        .setAttribute(
                            name: "x-on:focus",
                            value:
                                "window.dispatchEvent(new CustomEvent('show-tooltip', { detail: { id: '\(tooltipReference)' } }))"
                        )
                        .setAttribute(
                            name: "x-on:blur",
                            value:
                                "window.dispatchEvent(new CustomEvent('hide-tooltip', { detail: { id: '\(tooltipReference)' } }))"
                        )
                }
                return $0
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

            showTooltip(referenceId: tooltipReference)

        }
        .setAttribute(
            name: "x-data",
            value: "{ }"
        )
        .class("relative")
        .if(data.hasFullWidth) {
            $0.addClass("w-full")
        } else: {
            $0.addClass("max-w-full")
        }

    }
}
