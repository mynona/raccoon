/// Which user dimension the tracker reports.
/// Use `nil` on pages that must not report an authentication state at all.
public enum MatomoUserState: Sendable, Equatable {
    case signedIn(userID: String)
    case signedOut
}
