import HTML

/// Configuration data for the `ActionButton` component.
public struct ActionButtonData: Sendable {

    public enum IconPosition: Sendable {
        /// Icon on left side of the label
        case left
    }

    // MARK: - 1. Identity & Alpine Bindings
    public let id: String?
    public let bindId: String?
    public let action: String?
    public let bindAction: String?
    public let clickAction: String?
    public let method: HTML.MethodAttributeValue?
    public let bindAriaExpanded: String?
    public let bindAriaPressed: String?

    // MARK: - 2. Content & Accessibility
    public let label: String?
    public let ariaLabel: String?
    public let tooltipId: String?
    public let bindTooltipId: String?
    public let tooltip: String?
    public let tooltipPosition: ComponentPosition?

    // MARK: - 5. Presentation & State
    public let htmlType: HTML.Button.Types
    public let buttonType: ActionButtonType
    public let state: ActionButtonState
    public let size: ComponentSize
    public let hasFullWidth: Bool
    public let icon: SvgIcon?
    public let iconPosition: IconPosition

    // MARK: - 6. Analytics & Tracking
    public let matomoStatus: MatomoStatus
    public let contentTracker: MatomoContentTracker

    /// Creates a new configuration instance for `ActionButton`.
    ///
    /// - Parameters:
    ///   - id: Used to reference the label. Sets id and name attribute in HTML.
    ///   - bindId: Dynamic Alpine `:id` binding.
    ///   - action: Higher-level form target value used to set `formaction`.
    ///   - bindAction: Optional binding used to set `x-bind:formaction`.
    ///   - clickAction: Low-level inline handler attached directly as `x-on:click`.
    ///   - method: HTTP method paired with `action`.
    ///   - bindAriaExpanded: Optional Alpine expression bound to `:aria-expanded`.
    ///   - bindAriaPressed: Optional Alpine expression bound to `:aria-pressed`.
    ///   - label: Label of the button.
    ///   - ariaLabel: Accessibility label override for screen readers.
    ///   - tooltipId: Optional stable id for the tooltip reference. Falls back to a deterministic hash when not provided.
    ///   - bindTooltipId: Dynamic Alpine binding for the tooltip reference.
    ///   - tooltip: Text to display in the tooltip.
    ///   - tooltipPosition: Position of the tooltip relative to the button.
    ///   - htmlType: HTML button type (`submit`, `button`, `reset`).
    ///   - buttonType: Visual style (`primary`, `secondary`, `tertiary`, `warning`, `icon`).
    ///   - state: Interaction state (`enabled`, `disabled`).
    ///   - size: Size of the button.
    ///   - hasFullWidth: Indicates if button should stretch full width of parent container.
    ///   - icon: Optional SVG icon to display alongside label.
    ///   - iconPosition: Position of icon (`left`).
    ///   - matomoStatus: Matomo tracking consent status.
    ///   - contentTracker: Matomo content tracking configuration.
    public init(
        // 1. Identity & Alpine Bindings
        id: String? = nil,
        bindId: String? = nil,
        action: String? = nil,
        bindAction: String? = nil,
        clickAction: String? = nil,
        method: HTML.MethodAttributeValue? = nil,
        bindAriaExpanded: String? = nil,
        bindAriaPressed: String? = nil,

        // 2. Content & Accessibility
        label: String? = nil,
        ariaLabel: String? = nil,
        tooltipId: String? = nil,
        bindTooltipId: String? = nil,
        tooltip: String? = nil,
        tooltipPosition: ComponentPosition? = nil,

        // 5. Presentation & State
        htmlType: HTML.Button.Types = .submit,
        buttonType: ActionButtonType = .primary,
        state: ActionButtonState = .enabled,
        size: ComponentSize = .base,
        hasFullWidth: Bool = false,
        icon: SvgIcon? = nil,
        iconPosition: IconPosition = .left,

        // 6. Analytics & Tracking
        matomoStatus: MatomoStatus = .DEACTIVATED,
        contentTracker: MatomoContentTracker
    ) {
        // 1. Identity & Alpine Bindings
        self.id = id
        self.bindId = bindId
        self.action = action
        self.bindAction = bindAction
        self.clickAction = clickAction
        self.method = method
        self.bindAriaExpanded = bindAriaExpanded
        self.bindAriaPressed = bindAriaPressed

        // 2. Content & Accessibility
        self.label = label
        self.ariaLabel = ariaLabel
        self.tooltipId = tooltipId
        self.bindTooltipId = bindTooltipId
        self.tooltip = tooltip
        self.tooltipPosition = tooltipPosition

        // 5. Presentation & State
        self.htmlType = htmlType
        self.buttonType = buttonType
        self.state = state
        self.size = size
        self.hasFullWidth = hasFullWidth
        self.icon = icon
        self.iconPosition = iconPosition

        // 6. Analytics & Tracking
        self.matomoStatus = matomoStatus
        self.contentTracker = contentTracker
    }
}
