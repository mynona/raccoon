import SVG

/// Configuration data for the `LinkList` component.
public struct LinkListData: Sendable {

    public let icon: SvgIcon?
    public let links: [String: String?]
    public let matomoStatus: MatomoStatus
    public let contentTracker: MatomoContentTracker

    /// Creates a new configuration instance for `LinkList`.
    ///
    /// - Parameters:
    ///   - links: Dictionary mapping link titles to their destination URLs.
    ///   - icon: Bullet icon displayed next to each link, defaults to `.arrow_right_circle`.
    ///   - matomoStatus: Matomo tracking consent status.
    ///   - contentTracker: Matomo content tracking configuration.
    public init(
        links: [String: String?],
        icon: SvgIcon? = .arrow_right_circle,
        matomoStatus: MatomoStatus = .DECLINED,
        contentTracker: MatomoContentTracker
    ) {
        self.icon = icon
        self.links = links
        self.matomoStatus = matomoStatus
        self.contentTracker = contentTracker
    }
}
