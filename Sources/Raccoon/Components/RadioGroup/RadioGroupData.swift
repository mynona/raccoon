/// Configuration data for the `RadioGroup` component. Serves as the public API contract.
public struct RadioGroupData: Sendable {

    // MARK: - 1. Identity & Alpine Bindings

    /// Unique DOM identifier of the group. Used for the `<id>-helper` and `<id>-error` ids.
    public let id: String

    /// Form submission name shared by all radios of the group.
    public let name: String

    // MARK: - 2. Content & Accessibility

    /// Legend of the group. Rendered as `<legend>`, including the required marker.
    public let label: LabelData?

    // MARK: - 3. Value & Options

    /// Value of the selected option. Single source of truth: `RadioData.isSelected` of the
    /// options is ignored. When no option matches, nothing is selected.
    public let selectedValue: String?

    /// Radios of the group. Per-option error messages are not rendered, use `errorMessages` instead.
    public let options: [RadioData]

    // MARK: - 4. Feedback & Validation

    /// Error messages displayed once for the whole group.
    public let errorMessages: ErrorMessageData?

    /// Helper text displayed once for the whole group.
    public let helperText: HelperTextData?

    // MARK: - 5. Presentation & State

    /// Interaction state of the group. Anything other than `enabled` disables every option.
    public let state: ComponentState

    /// Creates a new configuration instance for `RadioGroup`.
    ///
    /// - Parameters:
    ///   - id: Unique DOM identifier of the group.
    ///   - name: Form submission name shared by all radios of the group.
    ///   - label: Legend of the group.
    ///   - selectedValue: Value of the selected option (`RadioData.value`, falls back to its `id`).
    ///   - options: Radios of the group.
    ///   - errorMessages: Error messages displayed once for the whole group.
    ///   - helperText: Helper text displayed once for the whole group.
    ///   - state: Interaction state of the group.
    public init(
        // 1. Identity & Alpine Bindings
        id: String,
        name: String,

        // 2. Content & Accessibility
        label: LabelData? = nil,

        // 3. Value & Options
        selectedValue: String? = nil,
        options: [RadioData],

        // 4. Feedback & Validation
        errorMessages: ErrorMessageData? = nil,
        helperText: HelperTextData? = nil,

        // 5. Presentation & State
        state: ComponentState = .enabled
    ) {
        // 1. Identity & Alpine Bindings
        self.id = id
        self.name = name

        // 2. Content & Accessibility
        self.label = label

        // 3. Value & Options
        self.selectedValue = selectedValue
        self.options = options

        // 4. Feedback & Validation
        self.errorMessages = errorMessages
        self.helperText = helperText

        // 5. Presentation & State
        self.state = state
    }
}
