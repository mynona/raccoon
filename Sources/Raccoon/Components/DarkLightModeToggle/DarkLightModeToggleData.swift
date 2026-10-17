/// Configuration data for the `DarkLightModeToggle` component.
public struct DarkLightModeToggleData: Sendable {

    public let id: String?
    public let matomoStatus: MatomoStatus

    /// Creates a new configuration instance for `DarkLightModeToggle`.
    ///
    /// - Parameters:
    ///   - id: Optional unique DOM identifier for the toggle.
    ///   - matomoStatus: Matomo tracking consent status.
    public init(
        id: String? = nil,
        matomoStatus: MatomoStatus = .DECLINED
    ) {
        self.id = id
        self.matomoStatus = matomoStatus
    }
}
