/// Configuration data for the `Radio` component. Serves as the public API contract.
public struct RadioData: Sendable {

    // MARK: - 1. Identity & Alpine Bindings

    /// Unique DOM identifier for the radio input. Also used for the label `for` attribute.
    public let id: String

    /// Form submission name. Radios sharing the same name form one group. Falls back to `id`.
    public let name: String?

    // MARK: - 2. Content & Accessibility

    /// Visible label text displayed next to the radio.
    public let label: String?

    // MARK: - 3. Value & Options

    /// Value submitted when this radio is selected. Falls back to `id`.
    public let value: String?

    // MARK: - 4. Feedback & Validation

    /// Error messages displayed below the label.
    public let errorMessages: ErrorMessageData?

    /// Helper text displayed below the label.
    public let helperText: HelperTextData?

    /// Marks the input as invalid for assistive technologies without rendering an error message,
    /// e.g. when the error is shown once for the whole `RadioGroup`.
    public let isInvalid: Bool

    // MARK: - 5. Presentation & State

    /// Interaction state of the radio (`enabled` or `disabled`).
    public let state: ComponentState

    /// Whether the radio is currently selected.
    public let isSelected: Bool

    /// Creates a new configuration instance for `Radio`.
    ///
    /// - Parameters:
    ///   - id: Unique DOM identifier for the radio input.
    ///   - name: Form submission name. Falls back to `id`.
    ///   - label: Visible label text displayed next to the radio.
    ///   - value: Value submitted when selected. Falls back to `id`.
    ///   - errorMessages: Error messages displayed below the label.
    ///   - helperText: Helper text displayed below the label.
    ///   - isInvalid: Marks the input as invalid without rendering an error message.
    ///   - state: Interaction state of the radio (`enabled` or `disabled`).
    ///   - isSelected: Whether the radio is currently selected.
    public init(
        // 1. Identity & Alpine Bindings
        id: String,
        name: String? = nil,

        // 2. Content & Accessibility
        label: String? = nil,

        // 3. Value & Options
        value: String? = nil,

        // 4. Feedback & Validation
        errorMessages: ErrorMessageData? = nil,
        helperText: HelperTextData? = nil,
        isInvalid: Bool = false,

        // 5. Presentation & State
        state: ComponentState = .enabled,
        isSelected: Bool = false
    ) {
        // 1. Identity & Alpine Bindings
        self.id = id
        self.name = name

        // 2. Content & Accessibility
        self.label = label

        // 3. Value & Options
        self.value = value

        // 4. Feedback & Validation
        self.errorMessages = errorMessages
        self.helperText = helperText
        self.isInvalid = isInvalid

        // 5. Presentation & State
        self.state = state
        self.isSelected = isSelected
    }
}
