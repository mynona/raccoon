import Foundation
import SVG

/// An individual item or selectable action within a `SimpleMenu`.
public struct SimpleMenuOption: Sendable {
    /// Unique identifier for the option.
    public let id: String

    /// Visible display title of the option.
    public let title: String

    /// Whether this option is currently selected (used in SSR mode).
    public let isSelected: Bool

    /// Optional navigation URL for SSR `.link` mode. When set, renders the option as an `<a href="...">`.
    public let href: String?

    /// Optional Alpine.js click action expression. When set, renders the option as a `<button @click="...">`.
    public let clickAction: String?

    /// Optional dynamic Alpine.js expression to evaluate whether this option is selected (e.g. `"size === per"`).
    public let bindSelected: String?

    /// Optional leading or trailing SVG icon.
    public let icon: SvgIcon?

    /// Optional ARIA role override (e.g. `"menuitemradio"`). Defaults to `"menuitem"`.
    public let role: String?

    /// Optional dynamic Alpine.js expression for `:aria-checked`.
    public let bindAriaChecked: String?

    /// Creates a new dropdown menu option.
    ///
    /// - Parameters:
    ///   - id: Unique identifier for the option.
    ///   - title: Visible display title.
    ///   - isSelected: Whether this option is currently selected (SSR).
    ///   - href: Optional navigation URL for SSR mode.
    ///   - clickAction: Optional Alpine.js click handler expression.
    ///   - bindSelected: Optional Alpine.js boolean expression for selection indicator.
    ///   - icon: Optional SVG icon to display.
    ///   - role: Optional ARIA role override.
    ///   - bindAriaChecked: Optional dynamic Alpine.js expression for `:aria-checked`.
    public init(
        id: String,
        title: String,
        isSelected: Bool = false,
        href: String? = nil,
        clickAction: String? = nil,
        bindSelected: String? = nil,
        icon: SvgIcon? = nil,
        role: String? = nil,
        bindAriaChecked: String? = nil
    ) {
        self.id = id
        self.title = title
        self.isSelected = isSelected
        self.href = href
        self.clickAction = clickAction
        self.bindSelected = bindSelected
        self.icon = icon
        self.role = role
        self.bindAriaChecked = bindAriaChecked
    }
}
