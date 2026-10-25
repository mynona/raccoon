/// Configuration data for the `MatomoTracker` analytics component.
public struct MatomoTrackerData: Sendable {

    public let status: MatomoStatus
    public let pageType: MatomoPageType
    /// `Seo.url` — the canonical path, used for the no-JavaScript fallback pixel.
    public let canonicalPath: String?
    public let userState: MatomoUserState?
    public let siteId: String
    public let trackerUrl: String
    public let siteBaseUrl: String

    /// Creates a new configuration instance for `MatomoTracker`.
    ///
    /// - Parameters:
    ///   - siteId: Matomo site ID string, defaults to `"1"`.
    ///   - trackerUrl: URL endpoint for the Matomo tracking server.
    ///   - siteBaseUrl: Canonical base URL of the site being tracked.
    ///   - status: Current user consent status.
    ///   - pageType: Type of page tracking event (`trackPageView`, etc.).
    ///   - canonicalPath: Canonical path used for no-JavaScript pixel fallback.
    ///   - userState: User authorization and role state for custom dimensions.
    public init(
        siteId: String = "1",
        trackerUrl: String,
        siteBaseUrl: String,
        status: MatomoStatus = .BANNER,
        pageType: MatomoPageType = .trackPageView,
        canonicalPath: String? = nil,
        userState: MatomoUserState? = nil,
    ) {
        self.status = status
        self.pageType = pageType
        self.canonicalPath = canonicalPath
        self.userState = userState
        self.siteId = siteId
        self.trackerUrl = trackerUrl
        self.siteBaseUrl = siteBaseUrl
    }
}
