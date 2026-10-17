/// Configuration data for the `Stepper` component. Serves as the public API contract.
public struct StepperData: Sendable {

    // MARK: - 1. Identity & Alpine Bindings

    /// Unique DOM identifier for the stepper `<nav>` element.
    public let id: String?

    /// Dynamic Alpine `:id` expression.
    public let bindId: String?

    // MARK: - 2. Content & Accessibility

    /// Accessible label for the `<nav>` landmark (defaults to `"Progress"`).
    public let ariaLabel: String

    // MARK: - 3. Value & Options

    /// Ordered sequence of steps displayed by the stepper.
    public let steps: [StepperStepData]

    // MARK: - 5. Presentation & State

    /// Layout orientation of the stepper (`.horizontal` or `.vertical`).
    public let orientation: StepperOrientation

    /// Overall interaction state of the stepper component.
    public let state: ComponentState

    /// Whether the horizontal stepper stretches across the full width of its parent container.
    public let hasFullWidth: Bool

    /// Whether tooltips are displayed on step icons on hover and focus.
    public let hasTooltip: Bool

    /// Whether to display 1-based step numbers on steps that have no custom icon.
    public let hasStepNumbers: Bool

    // MARK: - 6. Analytics & Tracking

    /// Matomo tracking consent status.
    public let matomoStatus: MatomoStatus

    /// Optional Matomo content tracking configuration.
    public let contentTracker: MatomoContentTracker?

    /// Creates a new configuration instance for `Stepper`.
    ///
    /// - Parameters:
    ///   - id: Unique DOM identifier for the stepper `<nav>`.
    ///   - bindId: Dynamic Alpine `:id` expression.
    ///   - ariaLabel: Accessible name for the navigation landmark.
    ///   - steps: Array of step configuration data instances.
    ///   - orientation: Layout orientation (`.horizontal` or `.vertical`).
    ///   - state: Overall interaction state of the component.
    ///   - hasFullWidth: Whether the stepper expands to fill its parent container width.
    ///   - hasTooltip: Whether tooltips are displayed on step icons on hover and focus.
    ///   - hasStepNumbers: Whether to display 1-based step numbers on steps that have no custom icon.
    ///   - matomoStatus: Matomo tracking consent status.
    ///   - contentTracker: Optional Matomo content tracking configuration.
    public init(
        // 1. Identity & Alpine Bindings
        id: String? = nil,
        bindId: String? = nil,

        // 2. Content & Accessibility
        ariaLabel: String = "Progress",

        // 3. Value & Options
        steps: [StepperStepData] = [],

        // 5. Presentation & State
        orientation: StepperOrientation = .horizontal,
        state: ComponentState = .enabled,
        hasFullWidth: Bool = false,
        hasTooltip: Bool = true,
        hasStepNumbers: Bool = false,

        // 6. Analytics & Tracking
        matomoStatus: MatomoStatus = .DECLINED,
        contentTracker: MatomoContentTracker? = nil
    ) {
        // 1. Identity & Alpine Bindings
        self.id = id
        self.bindId = bindId

        // 2. Content & Accessibility
        self.ariaLabel = ariaLabel

        // 3. Value & Options
        self.steps = steps

        // 5. Presentation & State
        self.orientation = orientation
        self.state = state
        self.hasFullWidth = hasFullWidth
        self.hasTooltip = hasTooltip
        self.hasStepNumbers = hasStepNumbers

        // 6. Analytics & Tracking
        self.matomoStatus = matomoStatus
        self.contentTracker = contentTracker
    }
}
