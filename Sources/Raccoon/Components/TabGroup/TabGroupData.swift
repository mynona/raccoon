import Foundation
import HTML
import SGML
import SVG
import WebBuilders

/// Content payload for an individual tab panel in `TabGroup`.
public enum TabContent: Sendable {
    /// Raw HTML string rendered directly.
    case html(String)
    /// Markdown string rendered as HTML through the markdown parser.
    case markdown(String)
    /// Array of SGML/HTML element nodes.
    case element([any SGML.Element])

    /// Convenience builder for element content.
    public static func element(
        @Builder<SGML.Element> _ content: () -> [any SGML.Element]
    ) -> TabContent {
        .element(content())
    }

    /// Whether the content payload is empty.
    public var isEmpty: Bool {
        switch self {
        case .html(let html): html.isEmpty
        case .markdown(let markdown): markdown.isEmpty
        case .element(let elements): elements.isEmpty
        }
    }
}

/// Visual styling variants for the tab group navigation bar.
public enum TabVariant: String, Sendable {
    /// Active tab highlighted with a bottom indicator border.
    case underline
    /// Joined segments in a rounded container, with an underline on the active tab.
    case pills
}

/// Layout orientation of the tab group.
public enum TabOrientation: String, Sendable {
    /// Tabs arranged in a horizontal row above the panels.
    case horizontal
    /// Tabs arranged in a vertical column to the left of the panels.
    case vertical
}

/// Configuration data for a single tab within a `TabGroup`. Serves as the public API contract for individual tabs.
public struct TabItemData: Sendable {

    /// Icon positioning relative to the tab label.
    public enum IconPosition: Sendable {
        /// Icon displayed on the left side of the label.
        case left
        /// Icon displayed on the right side of the label.
        case right
    }

    // MARK: - 1. Identity & Alpine Bindings
    /// Unique DOM identifier for the tab. Used to associate the tab button with its panel.
    public let id: String
    /// Dynamic Alpine `:id` expression.
    public let bindId: String?

    // MARK: - 2. Content & Accessibility
    /// Visible tab button title.
    public let label: String
    /// Accessible name override for screen readers.
    public let ariaLabel: String?
    /// Optional tooltip text shown on hover/focus.
    public let tooltip: String?
    /// Position of the tooltip relative to the tab button.
    public let tooltipPosition: ComponentPosition?

    // MARK: - 3. Value & Options
    /// Tab panel content payload (`html`, `markdown`, or `element`).
    public let content: TabContent

    // MARK: - 5. Presentation & State
    /// Interaction state of the tab (`enabled`, `disabled`, `hidden`).
    public let state: ComponentState
    /// Whether this tab is initially selected when the group renders.
    public let isDefaultSelected: Bool
    /// Optional SVG icon displayed alongside the label.
    public let icon: SvgIcon?
    /// Placement of the icon relative to the label.
    public let iconPosition: IconPosition
    /// Optional pill badge displayed inside the tab.
    public let pill: PillData?
    /// Optional numeric counter badge displayed inside the tab.
    public let badgeCount: Int?
    /// Optional text badge displayed inside the tab.
    public let badgeText: String?

    // MARK: - 6. Analytics & Tracking
    /// Matomo tracking consent status.
    public let matomoStatus: MatomoStatus
    /// Matomo content tracking configuration.
    public let contentTracker: MatomoContentTracker?

    /// Creates a new configuration instance for `TabItemData`.
    ///
    /// - Parameters:
    ///   - id: Unique DOM identifier for the tab. Used to associate tab and panel.
    ///   - bindId: Dynamic Alpine `:id` expression.
    ///   - label: Visible tab button title.
    ///   - ariaLabel: Accessible name override for screen readers.
    ///   - tooltip: Optional tooltip text shown on hover/focus.
    ///   - tooltipPosition: Position of the tooltip relative to the tab button.
    ///   - content: Tab panel content (`html`, `markdown`, or `element`).
    ///   - state: Current interaction state (`enabled`, `disabled`, `hidden`).
    ///   - isDefaultSelected: Whether this tab is initially active when the group loads.
    ///   - icon: Optional SVG icon displayed alongside the label.
    ///   - iconPosition: Placement of the icon relative to the label.
    ///   - pill: Optional pill component data displayed inside the tab.
    ///   - badgeCount: Optional numeric counter badge displayed inside the tab.
    ///   - badgeText: Optional text badge displayed inside the tab.
    ///   - matomoStatus: Matomo tracking consent status.
    ///   - contentTracker: Optional Matomo content tracking configuration.
    public init(
        // 1. Identity & Alpine Bindings
        id: String,
        bindId: String? = nil,

        // 2. Content & Accessibility
        label: String,
        ariaLabel: String? = nil,
        tooltip: String? = nil,
        tooltipPosition: ComponentPosition? = nil,

        // 3. Value & Options
        content: TabContent,

        // 5. Presentation & State
        state: ComponentState = .enabled,
        isDefaultSelected: Bool = false,
        icon: SvgIcon? = nil,
        iconPosition: IconPosition = .left,
        pill: PillData? = nil,
        badgeCount: Int? = nil,
        badgeText: String? = nil,

        // 6. Analytics & Tracking
        matomoStatus: MatomoStatus = .DECLINED,
        contentTracker: MatomoContentTracker? = nil
    ) {
        // 1. Identity & Alpine Bindings
        self.id = id
        self.bindId = bindId

        // 2. Content & Accessibility
        self.label = label
        self.ariaLabel = ariaLabel
        self.tooltip = tooltip
        self.tooltipPosition = tooltipPosition

        // 3. Value & Options
        self.content = content

        // 5. Presentation & State
        self.state = state
        self.isDefaultSelected = isDefaultSelected
        self.icon = icon
        self.iconPosition = iconPosition
        self.pill = pill
        self.badgeCount = badgeCount ?? pill?.count
        self.badgeText = badgeText ?? pill?.text

        // 6. Analytics & Tracking
        self.matomoStatus = matomoStatus
        self.contentTracker = contentTracker
    }

    /// Convenience initializer using a `@Builder` element closure for panel content.
    ///
    /// - Parameters:
    ///   - id: Unique DOM identifier for the tab. Used to associate tab and panel.
    ///   - bindId: Dynamic Alpine `:id` expression.
    ///   - label: Visible tab button title.
    ///   - ariaLabel: Accessible name override for screen readers.
    ///   - tooltip: Optional tooltip text shown on hover/focus.
    ///   - tooltipPosition: Position of the tooltip relative to the tab button.
    ///   - content: Builder closure returning an array of HTML/SGML elements.
    ///   - state: Current interaction state (`enabled`, `disabled`, `hidden`).
    ///   - isDefaultSelected: Whether this tab is initially active when the group loads.
    ///   - icon: Optional SVG icon displayed alongside the label.
    ///   - iconPosition: Placement of the icon relative to the label.
    ///   - pill: Optional pill component data displayed inside the tab.
    ///   - badgeCount: Optional numeric counter badge displayed inside the tab.
    ///   - badgeText: Optional text badge displayed inside the tab.
    ///   - matomoStatus: Matomo tracking consent status.
    ///   - contentTracker: Optional Matomo content tracking configuration.
    public init(
        // 1. Identity & Alpine Bindings
        id: String,
        bindId: String? = nil,

        // 2. Content & Accessibility
        label: String,
        ariaLabel: String? = nil,
        tooltip: String? = nil,
        tooltipPosition: ComponentPosition? = nil,

        // 3. Value & Options
        @Builder<SGML.Element> content: () -> [any SGML.Element],

        // 5. Presentation & State
        state: ComponentState = .enabled,
        isDefaultSelected: Bool = false,
        icon: SvgIcon? = nil,
        iconPosition: IconPosition = .left,
        pill: PillData? = nil,
        badgeCount: Int? = nil,
        badgeText: String? = nil,

        // 6. Analytics & Tracking
        matomoStatus: MatomoStatus = .DECLINED,
        contentTracker: MatomoContentTracker? = nil
    ) {
        self.init(
            id: id,
            bindId: bindId,
            label: label,
            ariaLabel: ariaLabel,
            tooltip: tooltip,
            tooltipPosition: tooltipPosition,
            content: .element(content()),
            state: state,
            isDefaultSelected: isDefaultSelected,
            icon: icon,
            iconPosition: iconPosition,
            pill: pill,
            badgeCount: badgeCount,
            badgeText: badgeText,
            matomoStatus: matomoStatus,
            contentTracker: contentTracker
        )
    }
}

/// Configuration data for the `TabGroup` container component. Serves as the public API contract.
public struct TabGroupData: Sendable {

    // MARK: - 1. Identity & Alpine Bindings
    /// Unique DOM identifier for the component container. If omitted, falls back to a deterministic hash.
    public let id: String?
    /// Dynamic Alpine `:id` expression.
    public let bindId: String?
    /// External Alpine state variable name if binding to an outer Alpine scope.
    public let bindSelectedTab: String?

    // MARK: - 2. Content & Accessibility
    /// Accessible label for the `tablist` element (e.g. "Account Settings Tabs").
    public let ariaLabel: String

    // MARK: - 3. Value & Options
    /// Collection of `TabItemData` instances defining the tabs and their panels.
    public let tabs: [TabItemData]
    /// Optional explicit tab id to select initially.
    public let defaultSelectedTabId: String?

    // MARK: - 4. Feedback & Validation
    /// Error message configuration displayed below the tab group.
    public let errorMessages: ErrorMessageData?
    /// Guidance or helper text displayed below the tab group.
    public let helperText: HelperTextData?

    // MARK: - 5. Presentation & State
    /// Interaction state of the tab group.
    public let state: ComponentState
    /// Visual size of the tab buttons and badges (`sm`, `base`, `xl`).
    public let size: ComponentSize
    /// Whether the tab list stretches to fill the container width.
    public let hasFullWidth: Bool
    /// Visual tab styling variant (`underline`, `pills`, `bordered`).
    public let variant: TabVariant
    /// Tab layout orientation (`horizontal`, `vertical`).
    public let orientation: TabOrientation
    /// Whether the tab group is framed with a container border.
    public let hasBorder: Bool

    // MARK: - 6. Analytics & Tracking
    /// Matomo tracking consent status.
    public let matomoStatus: MatomoStatus
    /// Matomo content tracking configuration.
    public let contentTracker: MatomoContentTracker?

    /// Creates a new configuration instance for `TabGroup`.
    ///
    /// - Parameters:
    ///   - id: Unique DOM identifier for the component container. If omitted, falls back to a deterministic hash.
    ///   - bindId: Dynamic Alpine `:id` expression.
    ///   - bindSelectedTab: External Alpine state variable name if binding to an outer Alpine scope.
    ///   - ariaLabel: Accessible label for the `tablist` element (e.g. "Account Settings Tabs").
    ///   - tabs: Collection of `TabItemData` instances defining the tabs and their panels.
    ///   - defaultSelectedTabId: Optional explicit tab id to select initially. If omitted, uses the tab marked with `isDefaultSelected == true`, or falls back to the first non-disabled tab.
    ///   - errorMessages: Error message configuration displayed below the tab group.
    ///   - helperText: Guidance or helper text displayed below the tab group.
    ///   - state: Interaction state of the tab group.
    ///   - size: Visual size of the tab buttons and badges.
    ///   - hasFullWidth: Whether the tab list stretches to fill the container width.
    ///   - variant: Visual tab styling variant (`underline`, `pills`, `bordered`).
    ///   - orientation: Tab layout orientation (`horizontal`, `vertical`).
    ///   - hasBorder: Whether the tab group is framed with a container border.
    ///   - matomoStatus: Matomo tracking consent status.
    ///   - contentTracker: Optional Matomo content tracking configuration.
    public init(
        // 1. Identity & Alpine Bindings
        id: String? = nil,
        bindId: String? = nil,
        bindSelectedTab: String? = nil,

        // 2. Content & Accessibility
        ariaLabel: String = "Tab options",

        // 3. Value & Options
        tabs: [TabItemData],
        defaultSelectedTabId: String? = nil,

        // 4. Feedback & Validation
        errorMessages: ErrorMessageData? = nil,
        helperText: HelperTextData? = nil,

        // 5. Presentation & State
        state: ComponentState = .enabled,
        size: ComponentSize = .base,
        hasFullWidth: Bool = true,
        variant: TabVariant = .underline,
        orientation: TabOrientation = .horizontal,
        hasBorder: Bool = false,

        // 6. Analytics & Tracking
        matomoStatus: MatomoStatus = .DECLINED,
        contentTracker: MatomoContentTracker? = nil
    ) {
        // 1. Identity & Alpine Bindings
        self.id = id
        self.bindId = bindId
        self.bindSelectedTab = bindSelectedTab

        // 2. Content & Accessibility
        self.ariaLabel = ariaLabel

        // 3. Value & Options
        self.tabs = tabs
        self.defaultSelectedTabId = defaultSelectedTabId

        // 4. Feedback & Validation
        self.errorMessages = errorMessages
        self.helperText = helperText

        // 5. Presentation & State
        self.state = state
        self.size = size
        self.hasFullWidth = hasFullWidth
        self.variant = variant
        self.orientation = orientation
        self.hasBorder = hasBorder

        // 6. Analytics & Tracking
        self.matomoStatus = matomoStatus
        self.contentTracker = contentTracker
    }
}
