/// Configuration data for the `Toast` notification container component.
/// Serves as the public API contract for toast presentation and accessibility options.
public struct ToastData: Sendable {

    // MARK: - 1. Identity & Alpine Bindings
    /// Unique DOM identifier for the toast container element.
    public let id: String?
    /// Dynamic Alpine `:id` binding expression.
    public let bindId: String?

    // MARK: - 2. Content & Accessibility
    /// Accessible label for the notification landmark region (`aria-label`).
    public let ariaLabel: LocalizedText?
    /// Keyboard shortcut key (e.g. "t" for Alt+T / Option+T) to jump focus to active toasts.
    public let shortcutKey: String?

    // MARK: - 3. Value & Options
    /// Default display duration in milliseconds before auto-dismissal (0 = sticky/persistent).
    public let durationMs: Int
    /// Initial toast items rendered into the DOM upon page load (e.g. from server flash sessions).
    public let initialToasts: [ToastItemData]

    // MARK: - 4. Feedback & Validation
    /// Optional default severity type filter or fallback.
    public let type: ToastType?

    // MARK: - 5. Presentation & State
    /// Screen anchor position of the toast viewport container.
    public let position: ToastPosition
    /// Whether toasts render an accessible manual dismiss button.
    public let isDismissible: Bool
    /// Whether toast cards display a severity icon.
    public let hasIcon: Bool
    /// Whether the auto-dismiss timer automatically pauses when hovered with a mouse pointer.
    public let hasPauseOnHover: Bool
    /// Whether the auto-dismiss timer automatically pauses when keyboard focus enters the toast.
    public let hasPauseOnFocus: Bool

    // MARK: - 6. Analytics & Tracking
    /// Consent tracking status for Matomo analytics.
    public let matomoStatus: MatomoStatus
    /// Optional Matomo content tracking configuration.
    public let contentTracker: MatomoContentTracker?

    /// Creates a new configuration instance for `Toast`.
    ///
    /// - Parameters:
    ///   - id: Unique DOM identifier for the toast container element.
    ///   - bindId: Dynamic Alpine `:id` binding expression.
    ///   - ariaLabel: Accessible label for the notification landmark region (`aria-label`).
    ///   - shortcutKey: Keyboard shortcut key (e.g. "t" for Alt+T / Option+T) to jump focus to active toasts.
    ///   - durationMs: Default display duration in milliseconds before auto-dismissal (default 5000ms; 0 = sticky).
    ///   - initialToasts: Initial toast items rendered into the DOM upon page load.
    ///   - type: Optional default severity type filter or fallback.
    ///   - position: Screen anchor position of the toast viewport container.
    ///   - isDismissible: Whether toasts render an accessible manual dismiss button.
    ///   - hasIcon: Whether toast cards display a severity icon.
    ///   - hasPauseOnHover: Whether the auto-dismiss timer automatically pauses when hovered with a mouse pointer.
    ///   - hasPauseOnFocus: Whether the auto-dismiss timer automatically pauses when keyboard focus enters the toast.
    ///   - matomoStatus: Consent tracking status for Matomo analytics.
    ///   - contentTracker: Optional Matomo content tracking configuration.
    public init(
        // 1. Identity & Alpine Bindings
        id: String? = nil,
        bindId: String? = nil,

        // 2. Content & Accessibility
        ariaLabel: LocalizedText? = nil,
        shortcutKey: String? = "t",

        // 3. Value & Options
        durationMs: Int = 5000,
        initialToasts: [ToastItemData] = [],

        // 4. Feedback & Validation
        type: ToastType? = nil,

        // 5. Presentation & State
        position: ToastPosition = .bottomEnd,
        isDismissible: Bool = true,
        hasIcon: Bool = true,
        hasPauseOnHover: Bool = true,
        hasPauseOnFocus: Bool = true,

        // 6. Analytics & Tracking
        matomoStatus: MatomoStatus = .DECLINED,
        contentTracker: MatomoContentTracker? = nil
    ) {
        // 1. Identity & Alpine Bindings
        self.id = id
        self.bindId = bindId

        // 2. Content & Accessibility
        self.ariaLabel = ariaLabel
        self.shortcutKey = shortcutKey

        // 3. Value & Options
        self.durationMs = durationMs
        self.initialToasts = initialToasts

        // 4. Feedback & Validation
        self.type = type

        // 5. Presentation & State
        self.position = position
        self.isDismissible = isDismissible
        self.hasIcon = hasIcon
        self.hasPauseOnHover = hasPauseOnHover
        self.hasPauseOnFocus = hasPauseOnFocus

        // 6. Analytics & Tracking
        self.matomoStatus = matomoStatus
        self.contentTracker = contentTracker
    }
}
