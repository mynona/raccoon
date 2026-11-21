/// Configuration data for the `Logo` component.
public struct LogoData: Sendable {

    public let destination: String

    /// Creates a new configuration instance for `Logo`.
    ///
    /// - Parameters:
    ///   - destination: Navigation target URL when clicking the logo, defaults to `"/home"`.
    public init(
        destination: String = "/home",
    ) {
        self.destination = destination
    }
}
