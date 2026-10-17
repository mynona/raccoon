import Foundation

/// Visual color variant of the `Pill` component.
public enum PillVariant: String, Sendable {
    /// Subtle neutral background with default on-surface text.
    case neutral
    /// Brand theme accent background and text.
    case theme
    /// Positive feedback or success status.
    case success
    /// Danger or error status.
    case error
}

/// Configuration data for `Pill`. Serves as the public API contract for standalone or embedded pills.
public struct PillData: Sendable {

    // MARK: - 1. Identity & Alpine Bindings
    /// Unique DOM identifier for the pill.
    public let id: String?
    /// Dynamic Alpine `:id` expression.
    public let bindId: String?
    /// Dynamic Alpine `:class` expression for reactive state styling.
    public let bindClass: String?

    // MARK: - 2. Content & Accessibility
    /// Text label displayed inside the pill.
    public let text: String?
    /// Accessible name override for screen readers.
    public let ariaLabel: String?

    // MARK: - 3. Value & Options
    /// Numeric counter value displayed inside the pill.
    public let count: Int?

    // MARK: - 5. Presentation & State
    /// Visual color variant of the pill.
    public let variant: PillVariant
    /// Sizing of the pill.
    public let size: ComponentSize

    // MARK: - 6. Analytics & Tracking
    /// Matomo tracking consent status.
    public let matomoStatus: MatomoStatus
    /// Matomo content tracking configuration.
    public let contentTracker: MatomoContentTracker?

    /// Creates a new configuration instance for `Pill`.
    ///
    /// - Parameters:
    ///   - id: Unique DOM identifier for the pill.
    ///   - bindId: Dynamic Alpine `:id` expression.
    ///   - bindClass: Dynamic Alpine `:class` expression for reactive styling.
    ///   - text: Text label displayed inside the pill.
    ///   - ariaLabel: Accessible name override for screen readers.
    ///   - count: Numeric counter value displayed inside the pill.
    ///   - variant: Visual color variant of the pill.
    ///   - size: Sizing of the pill.
    ///   - matomoStatus: Matomo tracking consent status.
    ///   - contentTracker: Optional Matomo content tracking configuration.
    public init(
        // 1. Identity & Alpine Bindings
        id: String? = nil,
        bindId: String? = nil,
        bindClass: String? = nil,

        // 2. Content & Accessibility
        text: String? = nil,
        ariaLabel: String? = nil,

        // 3. Value & Options
        count: Int? = nil,

        // 5. Presentation & State
        variant: PillVariant = .neutral,
        size: ComponentSize = .base,

        // 6. Analytics & Tracking
        matomoStatus: MatomoStatus = .DECLINED,
        contentTracker: MatomoContentTracker? = nil
    ) {
        // 1. Identity & Alpine Bindings
        self.id = id
        self.bindId = bindId
        self.bindClass = bindClass

        // 2. Content & Accessibility
        self.text = text
        self.ariaLabel = ariaLabel

        // 3. Value & Options
        self.count = count

        // 5. Presentation & State
        self.variant = variant
        self.size = size

        // 6. Analytics & Tracking
        self.matomoStatus = matomoStatus
        self.contentTracker = contentTracker
    }

    /// Convenience initializer for a numeric counter pill.
    ///
    /// - Parameters:
    ///   - count: Numeric counter value displayed inside the pill.
    ///   - variant: Visual color variant of the pill.
    ///   - size: Sizing of the pill.
    public init(
        _ count: Int,
        variant: PillVariant = .neutral,
        size: ComponentSize = .base
    ) {
        self.init(count: count, variant: variant, size: size)
    }

    /// Convenience initializer for a text pill.
    ///
    /// - Parameters:
    ///   - text: Text label displayed inside the pill.
    ///   - variant: Visual color variant of the pill.
    ///   - size: Sizing of the pill.
    public init(
        _ text: String,
        variant: PillVariant = .neutral,
        size: ComponentSize = .base
    ) {
        self.init(text: text, variant: variant, size: size)
    }
}
