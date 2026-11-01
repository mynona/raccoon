import HTML
import SVG

public struct HyperLinkData: Sendable {

    public enum Alignment: Sendable {
        case center
        case left
    }

    // MARK: - 2. Content & Accessibility
    public let label: LocalizedText?
    public let ariaLabel: LocalizedText?
    public let tooltip: LocalizedText?
    public let tooltipId: String?
    public let href: String
    public let target: TargetAttributeValue?
    public let rel: RelAttributeValue?

    // MARK: - 5. Presentation & State
    public let icon: SvgIcon?
    public let iconSize: Int?
    public let align: Alignment?
    public let isFocusable: Bool
    public let isUnderlined: Bool

    // MARK: - 6. Analytics & Tracking
    public let matomoStatus: MatomoStatus
    public let contentTracker: MatomoContentTracker

    /// Creates a new configuration instance for `HyperLink`.
    ///
    /// - Parameters:
    ///   - label: Visible anchor text.
    ///   - ariaLabel: Accessible name override for screen readers.
    ///   - href: Destination URL for the hyperlink.
    ///   - target: Anchor `target` attribute (e.g. `_blank`).
    ///   - rel: Anchor `rel` attribute (e.g. `noopener noreferrer`).
    ///   - tooltipId: Optional identifier for tooltip integration.
    ///   - tooltip: Text to display in the tooltip.
    ///   - icon: Optional SVG icon to display alongside label.
    ///   - iconSize: Pixel size of the icon.
    ///   - align: Inline alignment (`left` or `center`).
    ///   - isFocusable: Whether the link can receive keyboard focus.
    ///   - isUnderlined: Whether the link displays an underline.
    ///   - matomoStatus: Matomo tracking consent status.
    ///   - contentTracker: Matomo content tracking configuration.
    public init(
        // 2. Content & Accessibility
        label: LocalizedText? = nil,
        ariaLabel: LocalizedText? = nil,
        href: String,
        target: TargetAttributeValue? = nil,
        rel: RelAttributeValue? = nil,
        tooltipId: String? = nil,
        tooltip: LocalizedText? = nil,

        // 5. Presentation & State
        icon: SvgIcon? = nil,
        iconSize: Int? = 16,
        align: Alignment? = .left,
        isFocusable: Bool,
        isUnderlined: Bool,

        // 6. Analytics & Tracking
        matomoStatus: MatomoStatus = .DECLINED,
        contentTracker: MatomoContentTracker,
    ) {
        // 2. Content & Accessibility
        self.label = label
        self.ariaLabel = ariaLabel
        self.href = href
        self.target = target
        self.rel = rel
        self.tooltipId = tooltipId
        self.tooltip = tooltip

        // 5. Presentation & State
        self.icon = icon
        self.iconSize = iconSize
        self.align = align
        self.isFocusable = isFocusable
        self.isUnderlined = isUnderlined

        // 6. Analytics & Tracking
        self.matomoStatus = matomoStatus
        self.contentTracker = contentTracker
    }

}
