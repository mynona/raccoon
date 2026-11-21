/// Configuration data for the `DarkLightModeToggle` component.
public struct DarkLightModeToggleData: Sendable {

    public let id: String?

    /// Creates a new configuration instance for `DarkLightModeToggle`.
    ///
    /// - Parameters:
    ///   - id: Optional unique DOM identifier for the toggle.
    public init(
        id: String? = nil,
    ) {
        self.id = id
    }
}
