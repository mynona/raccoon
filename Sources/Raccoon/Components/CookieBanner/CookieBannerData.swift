/// Configuration data for the `CookieBanner` component.
public struct CookieBannerData: Sendable {

    /// The current page URL, appended to the opt-in/opt-out redirect paths.
    public let url: String

    /// Creates a new configuration instance for `CookieBanner`.
    ///
    /// - Parameters:
    ///   - url: The current page URL, appended to the opt-in/opt-out redirect paths.
    public init(
        url: String,
    ) {
        self.url = url
    }
}
