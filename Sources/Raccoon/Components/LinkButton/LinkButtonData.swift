import SVG

/// Configuration for rendering a link styled as a button.
/// Used with `LinkButton` to create accessible, styled `<a>` elements that behave like buttons.
///
/// ### Usage Example:
/// ```swift
/// LinkButton(
///   LinkButtonData(
///     label: "Already registered?",
///     ariaLabel: "Already registered?",
///     href: "/url",
///     buttonType: .tertiary,
///     fullWidth: true
///   )
/// ).render()
/// ```
public struct LinkButtonData: Sendable {

    /// Optional visible label for the button. If `nil`, only the icon is shown.
    public let label: String?
    /// Optional accessibility label override. Only used when there is no visible `label`
    /// (falls back to `tooltip`, then the icon name); ignored otherwise so the visible text
    /// stays the accessible name (WCAG 2.5.3 Label in Name).
    public let ariaLabel: String?
    /// Optional stable id used for the tooltip reference. Falls back to a deterministic
    /// hash of the tooltip/label/href when not provided.
    public let tooltipId: String?
    /// Destination URL for the link. This becomes the `href` attribute.
    public let href: String
    /// Optional language hint for the link destination.
    /// Defaults to `"en-US"` if not provided.
    public let hreflang: String?
    /// Optional icon to display alongside the label.
    public let icon: SvgIcon?
    /// Optional icon size in pixels. Defaults to `16`.
    public let iconSize: Int?
    /// Determines the button's visual style. See `ActionButtonType` for options.
    public let buttonType: ActionButtonType
    /// If `true`, the button spans the full width of its container.
    public let hasFullWidth: Bool
    /// If `true`, the button label text is truncated with an ellipsis.
    public let hasTruncation: Bool
    public let matomoStatus: MatomoStatus
    public let contentTracker: MatomoContentTracker
    public let tooltip: String?
    public let tooltipPosition: ComponentPosition?

    /// Creates a new configuration instance for `LinkButton`.
    ///
    /// - Parameters:
    ///   - label: Optional visible label for the button.
    ///   - ariaLabel: Optional accessibility label override.
    ///   - tooltipId: Optional stable id used for the tooltip reference.
    ///   - tooltip: Text to display in the tooltip.
    ///   - tooltipPosition: Position of the tooltip relative to the button.
    ///   - href: Destination URL for the link.
    ///   - hreflang: Optional language hint for the link destination.
    ///   - buttonType: Determines the button visual style.
    ///   - icon: Optional SVG icon to display alongside label.
    ///   - iconSize: Optional icon size in pixels.
    ///   - hasFullWidth: If `true`, the button spans the full width of its container.
    ///   - hasTruncation: If `true`, the button label text is truncated with an ellipsis.
    ///   - matomoStatus: Matomo tracking consent status.
    ///   - contentTracker: Matomo content tracking configuration.
    public init(
        label: String? = nil,
        ariaLabel: String? = nil,
        tooltipId: String? = nil,
        tooltip: String? = nil,
        tooltipPosition: ComponentPosition? = nil,
        href: String,
        hreflang: String? = AppValues.lang,
        buttonType: ActionButtonType,
        icon: SvgIcon? = nil,
        iconSize: Int? = 16,
        hasFullWidth: Bool = false,
        hasTruncation: Bool = false,
        matomoStatus: MatomoStatus = .DECLINED,
        contentTracker: MatomoContentTracker
    ) {
        self.label = label
        self.ariaLabel = ariaLabel
        self.tooltip = tooltip
        self.tooltipPosition = tooltipPosition
        self.tooltipId = tooltipId
        self.href = href
        self.hreflang = hreflang
        self.icon = icon
        self.iconSize = iconSize
        self.buttonType = buttonType
        self.hasFullWidth = hasFullWidth
        self.hasTruncation = hasTruncation
        self.matomoStatus = matomoStatus
        self.contentTracker = contentTracker
    }

}
