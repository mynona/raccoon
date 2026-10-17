
public struct MultiSelectData: Sendable {
    public let id: String
    public let label: LabelData?
    public let name: String
    //public let title: String?
    public let values: [String]?
    public let options: [OptionValue]?
    public let state: ComponentState
    public let placeholder: String?
    public let errorMessages: ErrorMessageData?
    public let helperText: HelperTextData?

    public let backgroundColor: String?

    /// Creates a new configuration instance for `MultiSelect`.
    ///
    /// - Parameters:
    ///   - id: Unique DOM identifier for the multi-select input.
    ///   - name: Form submission field name.
    ///   - label: Optional label context displayed above input.
    ///   - placeholder: Prompt text displayed when no values are selected.
    ///   - values: Pre-selected values array.
    ///   - options: Array of selectable option choices.
    ///   - state: Component state (`enabled`, `disabled`, etc.).
    ///   - errorMessages: Error message configuration displayed below input.
    ///   - helperText: Guidance or helper text displayed below input.
    ///   - backgroundColor: Optional background color class override.
    public init(
        id: String,
        name: String,
        label: LabelData? = nil,
        placeholder: String? = nil,
        values: [String]? = nil,
        options: [OptionValue]? = nil,
        state: ComponentState,
        errorMessages: ErrorMessageData? = nil,
        helperText: HelperTextData? = nil,
        backgroundColor: String? = nil
    ) {
        self.id = id
        self.label = label
        self.name = name
        //self.title = title
        self.values = values
        self.placeholder = placeholder
        self.errorMessages = errorMessages
        self.helperText = helperText
        self.options = options
        self.state = state
        self.backgroundColor = backgroundColor
    }
}
