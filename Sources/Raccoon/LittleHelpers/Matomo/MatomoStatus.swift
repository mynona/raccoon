/// Represents the GDPR consent status for data tracking using Matomo analytics.
/// Conforms to `String`, `Codable` and `Sendable`.
public enum MatomoStatus: String, Codable, Sendable {

    /// Consent has been explicitly given by the user to allow tracking.
    case ACCEPTED

    /// Consent has been explicitly declined by the user; tracking must be disabled.
    case DECLINED

    /// Consent decision is pending; a consent banner should be displayed to the user.
    case BANNER

    /// Tracking is deactivated regardless of user consent; Matomo should be ignored.
    case DEACTIVATED
}
