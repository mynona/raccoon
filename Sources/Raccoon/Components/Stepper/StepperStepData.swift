import SVG

/// Configuration data for a single step within a `Stepper`.
/// Serves as the public API contract for individual steps.
public struct StepperStepData: Sendable {

    // MARK: - 1. Identity & Alpine Bindings

    /// Unique DOM identifier for the step.
    public let id: String?

    /// Dynamic Alpine `:id` expression.
    public let bindId: String?

    // MARK: - 2. Content & Accessibility

    /// Visible title of the step in vertical orientation, or accessible label in horizontal orientation.
    public let title: String

    /// Optional descriptive subtitle or explanation text displayed below the title in vertical orientation.
    public let description: String?

    /// Accessible name override for screen readers.
    public let ariaLabel: String?

    /// Optional tooltip text displayed on hover or focus. If omitted and tooltips are enabled, the step's `title` is displayed.
    public let tooltip: String?

    /// Optional stable identifier for the tooltip element.
    public let tooltipId: String?

    /// Optional tooltip placement relative to the step icon (defaults to `.top`).
    public let tooltipPosition: ComponentPosition?

    /// Whether to display a tooltip on hover and focus for this step.
    public let hasTooltip: Bool

    /// Optional target URL making the step an interactive hyperlink. If `nil`, the step is rendered as a non-interactive element.
    public let href: String?

    /// Optional language tag for the target URL.
    public let hreflang: String?

    /// Optional browsing context target (e.g. `"_blank"`) for the step link.
    public let target: String?

    /// Optional link relationship attribute (e.g. `"noopener noreferrer"`).
    public let rel: String?

    // MARK: - 5. Presentation & State

    /// Current progress and completion status of this step (`complete`, `current`, or `upcoming`).
    public let status: StepperStepStatus

    /// Optional SVG icon displayed when the step is current or upcoming. When the step is complete, the tick checkmark is always displayed.
    public let icon: SvgIcon?

    /// Optional step number displayed inside the indicator when current or upcoming.
    public let stepNumber: Int?

    /// Interaction state of the step (`enabled` or `disabled`).
    public let state: ComponentState

    // MARK: - 6. Analytics & Tracking

    /// Matomo tracking consent status.
    public let matomoStatus: MatomoStatus

    /// Optional Matomo content tracking configuration.
    public let contentTracker: MatomoContentTracker?

    /// Creates a new configuration instance for `StepperStepData`.
    ///
    /// - Parameters:
    ///   - id: Unique DOM identifier for the step.
    ///   - bindId: Dynamic Alpine `:id` expression.
    ///   - title: Visible title of the step or accessible label.
    ///   - description: Optional descriptive subtitle or explanation text.
    ///   - ariaLabel: Accessible name override for screen readers.
    ///   - tooltip: Optional tooltip text shown on hover or focus (defaults to `title`).
    ///   - tooltipId: Optional stable identifier for the tooltip element.
    ///   - tooltipPosition: Optional placement of the tooltip relative to the step icon.
    ///   - hasTooltip: Whether to display a tooltip on hover and focus for this step.
    ///   - href: Optional destination URL for interactive navigation.
    ///   - hreflang: Optional language tag for the link destination.
    ///   - target: Optional browsing context target attribute.
    ///   - rel: Optional relationship attribute for the link.
    ///   - status: Current progress status of this step.
    ///   - icon: Optional SVG icon displayed when current or upcoming. Once complete, the tick is always shown.
    ///   - stepNumber: Optional step number displayed inside the indicator when current or upcoming.
    ///   - state: Interaction state of the step.
    ///   - matomoStatus: Matomo tracking consent status.
    ///   - contentTracker: Optional Matomo content tracking configuration.
    public init(
        // 1. Identity & Alpine Bindings
        id: String? = nil,
        bindId: String? = nil,

        // 2. Content & Accessibility
        title: String,
        description: String? = nil,
        ariaLabel: String? = nil,
        tooltip: String? = nil,
        tooltipId: String? = nil,
        tooltipPosition: ComponentPosition? = nil,
        hasTooltip: Bool = true,
        href: String? = nil,
        hreflang: String? = nil,
        target: String? = nil,
        rel: String? = nil,

        // 5. Presentation & State
        status: StepperStepStatus = .upcoming,
        icon: SvgIcon? = nil,
        stepNumber: Int? = nil,
        state: ComponentState = .enabled,

        // 6. Analytics & Tracking
        matomoStatus: MatomoStatus = .DECLINED,
        contentTracker: MatomoContentTracker? = nil
    ) {
        // 1. Identity & Alpine Bindings
        self.id = id
        self.bindId = bindId

        // 2. Content & Accessibility
        self.title = title
        self.description = description
        self.ariaLabel = ariaLabel
        self.tooltip = tooltip
        self.tooltipId = tooltipId
        self.tooltipPosition = tooltipPosition
        self.hasTooltip = hasTooltip
        self.href = href
        self.hreflang = hreflang
        self.target = target
        self.rel = rel

        // 5. Presentation & State
        self.status = status
        self.icon = icon
        self.stepNumber = stepNumber
        self.state = state

        // 6. Analytics & Tracking
        self.matomoStatus = matomoStatus
        self.contentTracker = contentTracker
    }
}
