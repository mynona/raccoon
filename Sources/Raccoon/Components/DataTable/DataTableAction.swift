/// A row action rendered as a button or link inside an `actions` cell.
///
/// Alpine expressions have the current row in scope as `row`.
public struct DataTableAction: Sendable {

    // MARK: - 1. Identity & Alpine Bindings
    /// Identifier of the action, unique within its column.
    public let id: String

    /// Alpine click expression, e.g. `alert(row.name + ' clicked')`.
    public let clickAction: String?

    // MARK: - 2. Content & Accessibility
    /// Visible label. Icon-only actions need `ariaLabel` or `bindAriaLabel`.
    public let label: String?

    /// Static accessible name.
    public let ariaLabel: String?

    /// Alpine expression for a row specific accessible name, e.g. `'Details for ' + row.name`.
    public let bindAriaLabel: String?

    /// Link target. `{field}` placeholders are replaced by the URL encoded row value.
    public let href: String?

    // MARK: - 5. Presentation & State
    /// Optional icon.
    public let icon: SvgIcon?

    /// Visual button variant.
    public let buttonType: ActionButtonType

    /// Alpine expression deciding if the action is shown for a row, e.g. `row.actions.canEdit`.
    public let visibleWhen: String?

    // MARK: - 6. Analytics & Tracking
    /// Matomo content tracking. `{field}` placeholders in the target are replaced by row values.
    public let contentTracker: MatomoContentTracker?

    /// Creates a row action.
    ///
    /// - Parameters:
    ///   - id: Identifier of the action, unique within its column.
    ///   - clickAction: Alpine click expression.
    ///   - label: Visible label.
    ///   - ariaLabel: Static accessible name.
    ///   - bindAriaLabel: Alpine expression for a row specific accessible name.
    ///   - href: Link target with `{field}` placeholders.
    ///   - icon: Optional icon.
    ///   - buttonType: Visual button variant.
    ///   - visibleWhen: Alpine expression deciding if the action is shown.
    ///   - contentTracker: Matomo content tracking.
    public init(
        // 1. Identity & Alpine Bindings
        id: String,
        clickAction: String? = nil,

        // 2. Content & Accessibility
        label: String? = nil,
        ariaLabel: String? = nil,
        bindAriaLabel: String? = nil,
        href: String? = nil,

        // 5. Presentation & State
        icon: SvgIcon? = nil,
        buttonType: ActionButtonType = .tertiary,
        visibleWhen: String? = nil,

        // 6. Analytics & Tracking
        contentTracker: MatomoContentTracker? = nil
    ) {
        // 1. Identity & Alpine Bindings
        self.id = id
        self.clickAction = clickAction

        // 2. Content & Accessibility
        self.label = label
        self.ariaLabel = ariaLabel
        self.bindAriaLabel = bindAriaLabel
        self.href = href

        // 5. Presentation & State
        self.icon = icon
        self.buttonType = buttonType
        self.visibleWhen = visibleWhen

        // 6. Analytics & Tracking
        self.contentTracker = contentTracker
    }
}
