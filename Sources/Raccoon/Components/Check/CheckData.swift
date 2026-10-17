import HTML

/// Configuration data for the `Check` (checkbox) component.
public struct CheckData: Sendable {
    public let id: String
    public let label: String?
    public let name: String?
    public let isSelected: Bool
    public let errorMessages: ErrorMessageData?
    public let helperText: HelperTextData?
    public let state: ComponentState

    /// Creates a new configuration instance for `Check`.
    ///
    /// - Parameters:
    ///   - id: Unique DOM identifier for the checkbox input.
    ///   - label: Optional text label displayed next to the checkbox.
    ///   - name: Optional form submission name attribute.
    ///   - isSelected: Whether the checkbox is currently checked.
    ///   - state: Interaction state of the checkbox (`enabled`, `disabled`).
    ///   - errorMessages: Optional error message context displayed below the checkbox.
    ///   - helperText: Optional helper text context displayed below the checkbox.
    public init(
        id: String,
        label: String? = nil,
        name: String? = nil,
        isSelected: Bool = false,
        state: ComponentState = .enabled,
        errorMessages: ErrorMessageData? = nil,
        helperText: HelperTextData? = nil,
    ) {
        self.id = id
        self.label = label
        self.name = name
        self.isSelected = isSelected
        self.errorMessages = errorMessages
        self.helperText = helperText
        self.state = state
    }
}
