/// Represents the types of tracking events supported by Matomo analytics.
/// Conforms to `Codable` and `Sendable`.
public enum MatomoPageType: Codable, Sendable {

    /// Tracks a standard page view event, typically used for generic content pages.
    case trackPageView

    /// Tracks an internal site search event, used when users perform searches within the website.
    case trackSiteSearch
}
