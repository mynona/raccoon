/// Configuration data for the `CookieBanner` component.
public struct CookieBannerData: Sendable {

    /// The current page URL, appended to the opt-in/opt-out redirect paths.
    public let url: String
    public let matomoStatus: MatomoStatus

    /// Creates a new configuration instance for `CookieBanner`.
    ///
    /// - Parameters:
    ///   - url: The current page URL, appended to the opt-in/opt-out redirect paths.
    ///   - matomoStatus: Current Matomo consent status, defaults to `.BANNER`.
    public init(
        url: String,
        matomoStatus: MatomoStatus = .BANNER,
    ) {
        self.url = url
        self.matomoStatus = matomoStatus
    }
}
