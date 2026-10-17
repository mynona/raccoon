/// Configuration data for the `Logo` component.
public struct LogoData: Sendable {

    public let destination: String
    public let matomoStatus: MatomoStatus

    /// Creates a new configuration instance for `Logo`.
    ///
    /// - Parameters:
    ///   - destination: Navigation target URL when clicking the logo, defaults to `"/home"`.
    ///   - matomoStatus: Matomo tracking consent status.
    public init(
        destination: String = "/home",
        matomoStatus: MatomoStatus = .DECLINED
    ) {
        self.destination = destination
        self.matomoStatus = matomoStatus
    }
}
