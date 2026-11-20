/// Configuration data for the `MatomoTracker` analytics component.
public struct MatomoTrackerData: Sendable {

    public let status: MatomoStatus
    public let pageType: MatomoPageType
    public let canonicalPath: String?
    public let userState: MatomoUserState?
    public let customDimensions: [Int: String]
    public let events: [MatomoEvent]
    public let resetsUser: Bool
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
    ///   - customDimensions: Additional custom dimensions (ID to value) set before the page view.
    ///   - events: Additional events reported together with the page view.
    ///   - resetsUser: Forget the user ID and start a new visit, for the page shown right after a sign out.
    public init(
        siteId: String,
        trackerUrl: String,
        siteBaseUrl: String,
        status: MatomoStatus = .BANNER,
        pageType: MatomoPageType = .trackPageView,
        canonicalPath: String? = nil,
        userState: MatomoUserState? = nil,
        customDimensions: [Int: String] = [:],
        events: [MatomoEvent] = [],
        resetsUser: Bool = false
    ) {
        self.status = status
        self.pageType = pageType
        self.canonicalPath = canonicalPath
        self.userState = userState
        self.customDimensions = customDimensions
        self.events = events
        self.resetsUser = resetsUser
        self.siteId = siteId
        self.trackerUrl = trackerUrl
        self.siteBaseUrl = siteBaseUrl
    }
}
