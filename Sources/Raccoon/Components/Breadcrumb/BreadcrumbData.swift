/// Represents a single path segment in a breadcrumb trail.
public struct BreadcrumbPath: Sendable {
    public let title: String
    public let href: String
    public let hreflang: String
    public let isCurrentPathSegment: Bool

    /// Creates a new `BreadcrumbPath` segment.
    ///
    /// - Parameters:
    ///   - title: Label text for the path segment.
    ///   - href: Target destination URL.
    ///   - hreflang: Language tag for the target URL.
    ///   - isCurrentPathSegment: Whether this segment represents the currently active page.
    public init(
        title: String,
        href: String,
        hreflang: String,
        isCurrentPathSegment: Bool = false
    ) {
        self.title = title
        self.href = href
        self.hreflang = hreflang
        self.isCurrentPathSegment = isCurrentPathSegment
    }
}

/// Configuration data for the `Breadcrumb` component.
public struct BreadcrumbData: Sendable {
    public let paths: [BreadcrumbPath]?
    public let hasHome: Bool
    public let homeUrl: String
    public let homeHreflang: String
    public let matomoStatus: MatomoStatus

    /// Creates a new configuration instance for `Breadcrumb`.
    ///
    /// - Parameters:
    ///   - paths: Array of breadcrumb path segments.
    ///   - homeUrl: Destination URL for the root/home link.
    ///   - homeHreflang: Language tag for the home link.
    ///   - hasHome: Whether to prepend a home link to the breadcrumb trail.
    ///   - matomoStatus: Matomo tracking consent status.
    public init(
        paths: [BreadcrumbPath]?,
        homeUrl: String = "/home/",
        homeHreflang: String = AppValues.lang,
        hasHome: Bool = false,
        matomoStatus: MatomoStatus = .DECLINED
    ) {
        self.paths = paths
        self.hasHome = hasHome
        self.homeUrl = homeUrl
        self.homeHreflang = homeHreflang
        self.matomoStatus = matomoStatus
    }
}
