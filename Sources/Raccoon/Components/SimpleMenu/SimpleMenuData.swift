import Foundation
import SVG

/// Configuration data for `SimpleMenu`. Serves as the public API contract.
public struct SimpleMenuData: Sendable {

    // MARK: - 1. Identity & Alpine Bindings

    /// Unique DOM identifier for the component container.
    public let id: String?

    /// Dynamic Alpine `:id` expression.
    public let bindId: String?

    /// Identifier token used for Alpine `:id` / `:aria-controls` bindings.
    public let alpineId: String

    /// Alpine.js boolean property expression tracking the open state.
    public let bindOpen: String

    /// Optional custom Alpine.js expression for `x-data`.
    public let bindAlpineData: String?

    /// Optional Alpine.js expression to dynamically display the trigger button label (e.g. `"per"`).
    public let bindTriggerText: String?

    /// Optional custom Alpine.js expression when toggling the menu.
    public let onToggle: String?

    /// Optional custom Alpine.js expression when closing the menu.
    public let onClose: String?

    // MARK: - 2. Content & Accessibility

    /// Optional visible label rendered beside the dropdown trigger.
    public let label: String?

    /// Accessible name for the dropdown menu region.
    public let ariaLabel: String

    /// Static label text displayed on the trigger button.
    public let triggerText: String

    /// Accessible label for the trigger button.
    public let triggerAriaLabel: String?

    // MARK: - 3. Value & Options

    /// List of options displayed in the dropdown menu.
    public let options: [SimpleMenuOption]

    // MARK: - 5. Presentation & State

    /// Alignment of the floating dropdown panel relative to the trigger (`.left` or `.right`).
    public let align: ComponentPosition

    /// Visual size variant of the dropdown trigger.
    public let size: ComponentSize

    /// Tailwind width class for the floating menu panel (e.g. `"w-28"`, `"w-48"`).
    public let width: String

    /// Optional SVG icon rendered in the trigger button.
    public let triggerIcon: SvgIcon?

    /// Whether to render a trailing chevron icon on the trigger button.
    public let hasTriggerChevron: Bool

    /// Optional custom CSS class override for the trigger button.
    public let triggerClass: String?

    // MARK: - 6. Analytics & Tracking

    /// Matomo tracking consent status.
    public let matomoStatus: MatomoStatus

    /// Optional Matomo content tracking configuration.
    public let contentTracker: MatomoContentTracker?

    /// Creates a configuration instance for `DropdownMenu`.
    ///
    /// - Parameters:
    ///   - id: Unique DOM identifier for the component container.
    ///   - bindId: Dynamic Alpine `:id` expression.
    ///   - alpineId: Identifier token used for Alpine `:id` / `:aria-controls` bindings.
    ///   - bindOpen: Alpine.js boolean property expression tracking open state.
    ///   - bindAlpineData: Optional custom Alpine.js expression for `x-data`.
    ///   - bindTriggerText: Optional Alpine.js expression for trigger button text.
    ///   - onToggle: Optional custom Alpine.js expression when toggling the menu.
    ///   - onClose: Optional custom Alpine.js expression when closing the menu.
    ///   - label: Optional visible label rendered beside the dropdown trigger.
    ///   - ariaLabel: Accessible name for the dropdown menu region.
    ///   - triggerText: Static label text displayed on the trigger button.
    ///   - triggerAriaLabel: Accessible label for the trigger button.
    ///   - options: List of options displayed in the dropdown menu.
    ///   - align: Alignment of the floating dropdown panel relative to the trigger.
    ///   - size: Visual size variant of the dropdown trigger.
    ///   - width: Tailwind width class for the floating menu panel.
    ///   - triggerIcon: Optional SVG icon rendered in the trigger button.
    ///   - hasTriggerChevron: Whether to render a trailing chevron icon on the trigger button.
    ///   - triggerClass: Optional custom CSS class override for the trigger button.
    ///   - matomoStatus: Tracking consent status for Matomo analytics.
    ///   - contentTracker: Optional Matomo content tracking configuration.
    public init(
        // 1. Identity & Alpine Bindings
        id: String? = nil,
        bindId: String? = nil,
        alpineId: String = "dropdown-button",
        bindOpen: String = "open",
        bindAlpineData: String? = nil,
        bindTriggerText: String? = nil,
        onToggle: String? = nil,
        onClose: String? = nil,

        // 2. Content & Accessibility
        label: String? = nil,
        ariaLabel: String = "Dropdown menu",
        triggerText: String = "",
        triggerAriaLabel: String? = nil,

        // 3. Value & Options
        options: [SimpleMenuOption] = [],

        // 5. Presentation & State
        align: ComponentPosition = .left,
        size: ComponentSize = .base,
        width: String = "w-48",
        triggerIcon: SvgIcon? = nil,
        hasTriggerChevron: Bool = true,
        triggerClass: String? = nil,

        // 6. Analytics & Tracking
        matomoStatus: MatomoStatus = .DECLINED,
        contentTracker: MatomoContentTracker? = nil
    ) {
        // 1. Identity & Alpine Bindings
        self.id = id
        self.bindId = bindId
        self.alpineId = alpineId
        self.bindOpen = bindOpen
        self.bindAlpineData = bindAlpineData
        self.bindTriggerText = bindTriggerText
        self.onToggle = onToggle
        self.onClose = onClose

        // 2. Content & Accessibility
        self.label = label
        self.ariaLabel = ariaLabel
        self.triggerText = triggerText
        self.triggerAriaLabel = triggerAriaLabel

        // 3. Value & Options
        self.options = options

        // 5. Presentation & State
        self.align = align
        self.size = size
        self.width = width
        self.triggerIcon = triggerIcon
        self.hasTriggerChevron = hasTriggerChevron
        self.triggerClass = triggerClass

        // 6. Analytics & Tracking
        self.matomoStatus = matomoStatus
        self.contentTracker = contentTracker
    }
}
