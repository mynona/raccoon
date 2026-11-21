import SVG

/// Configuration data for the `LinkList` component.
public struct LinkListData: Sendable {

    public let icon: SvgIcon?
    public let links: [LocalizedText: String?]
    public let contentTracker: MatomoContentTracker?

    /// Creates a new configuration instance for `LinkList`.
    ///
    /// - Parameters:
    ///   - links: Dictionary mapping link titles (translatable) to their destination URLs.
    ///   - icon: Bullet icon displayed next to each link, defaults to `.arrow_right_circle`.
    ///   - contentTracker: Matomo content tracking configuration.
    public init(
        links: [LocalizedText: String?],
        icon: SvgIcon? = .arrow_right_circle,
        contentTracker: MatomoContentTracker? = nil
    ) {
        self.icon = icon
        self.links = links
        self.contentTracker = contentTracker
    }
}
