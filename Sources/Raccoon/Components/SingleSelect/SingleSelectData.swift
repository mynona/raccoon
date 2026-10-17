
/// Context for the SingleSelect component, providing all data needed to render a single-select dropdown UI.
public struct SingleSelectData: Sendable {
    // MARK: - 1. Identity & Alpine Bindings
    /// Unique identifier for the select input and hidden field.
    public let id: String
    /// Name attribute for the input, used in form submission.
    public let name: String?

    // MARK: - 2. Content & Accessibility
    /// Optional label context for the select input.
    public let label: LabelData?
    /// Placeholder text shown when no value is selected.
    public let placeholder: String?
    public let placeholderText: String?
    public let placeholderAriaLabelText: String?

    // MARK: - 3. Value & Options
    /// The currently selected value (option value).
    public let value: String?
    /// List of selectable options (value/title pairs).
    public let options: [OptionValue]?

    // MARK: - 4. Feedback & Validation
    /// Error messages to display below the select input.
    public let errorMessages: ErrorMessageData?
    /// Helper text to display below the select input.
    public let helperText: HelperTextData?

    // MARK: - 5. Presentation & State
    /// State of the component (e.g., enabled, disabled, loading).
    public let state: ComponentState
    /// Optional background color for the dropdown.
    public let backgroundColor: String?

    /// Creates a new context for the SingleSelect component.
    /// - Parameters:
    ///   - id: Unique identifier for the select input.
    ///   - name: Name attribute for form submission.
    ///   - label: Optional label context.
    ///   - placeholder: Placeholder text when no value is selected.
    ///   - placeholderText: Prompt text displayed in the search box.
    ///   - placeholderAriaLabelText: Accessible instructions for keyboard and screen reader users.
    ///   - value: The currently selected value.
    ///   - options: List of selectable options.
    ///   - errorMessages: Error messages to display.
    ///   - helperText: Helper text to display.
    ///   - state: State of the component (enabled, disabled, etc.).
    ///   - backgroundColor: Optional background color for the dropdown.
    public init(
        id: String,
        name: String? = nil,
        label: LabelData? = nil,
        placeholder: String? = nil,
        placeholderText: String? = "Search or select",
        placeholderAriaLabelText: String? =
            "Search by entering values or select with arrow down",
        value: String? = nil,
        options: [OptionValue]? = nil,
        errorMessages: ErrorMessageData? = nil,
        helperText: HelperTextData? = nil,
        state: ComponentState,
        backgroundColor: String? = nil
    ) {
        self.id = id
        self.name = name
        self.label = label
        self.placeholder = placeholder
        self.placeholderText = placeholderText
        self.placeholderAriaLabelText = placeholderAriaLabelText
        self.value = value
        self.options = options
        self.errorMessages = errorMessages
        self.helperText = helperText
        self.state = state
        self.backgroundColor = backgroundColor
    }
}
