import HTML

/// Configuration data for the `HiddenField` component.
public struct HiddenFieldData: Sendable {

    public let id: String
    public let value: String?
    public let state: ComponentState

    /// Creates a new configuration instance for `HiddenField`.
    ///
    /// - Parameters:
    ///   - id: Unique identifier and name attribute for the hidden input.
    ///   - value: Raw string value submitted with the form.
    ///   - state: Component state (`enabled` or `disabled`).
    public init(
        id: String,
        value: String? = nil,
        state: ComponentState = .enabled
    ) {
        self.id = id
        self.value = value
        self.state = state
    }
}
