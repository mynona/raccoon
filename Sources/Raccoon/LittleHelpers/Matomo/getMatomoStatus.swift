/// Get Matomo (cookie) status:
/// - DEACTIVATED: tracking disabled by configuration
/// - ACCEPTED: cookie value is "accepted"
/// - DECLINED: cookie exists with any other value
/// - BANNER: no cookie yet, ask for consent
public func getMatomoStatus(
    cookie: String?,
    isTrackerDisabled: Bool
) -> MatomoStatus {

    if isTrackerDisabled {
        return .DEACTIVATED
    }

    guard let cookie else {
        return .BANNER
    }

    return cookie == "accepted" ? .ACCEPTED : .DECLINED
}
