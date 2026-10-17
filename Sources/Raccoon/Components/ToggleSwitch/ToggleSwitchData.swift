/// Configuration data for the `ToggleSwitch` component.
public struct ToggleSwitchData: Sendable {
    public let id: String
    public let label: LabelData?
    public let isSelected: Bool
    public let size: ComponentSize?
    public let state: ComponentState
    public let apiURL: String?

    /// Creates a new configuration instance for `ToggleSwitch`.
    ///
    /// - Parameters:
    ///   - id: Unique DOM identifier for the toggle switch input.
    ///   - label: Optional label context displayed beside the switch.
    ///   - isSelected: Whether the switch is in the active/on position.
    ///   - size: Visual size of the switch (`ComponentSize`).
    ///   - state: Interaction state of the switch (`enabled` or `disabled`).
    ///   - apiURL: Optional API endpoint URL to invoke when toggle changes state.
    public init(
        id: String,
        label: LabelData? = nil,
        isSelected: Bool,
        size: ComponentSize? = .base,
        state: ComponentState,
        apiURL: String? = nil
    ) {
        self.id = id
        self.label = label
        self.isSelected = isSelected
        self.size = size
        self.state = state
        self.apiURL = apiURL
    }
}
