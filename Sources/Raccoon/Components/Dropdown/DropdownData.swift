import Foundation

/// Configuration data for the `Dropdown` component, providing all data needed to render a form dropdown UI.
/// Matches the data attributes of `SingleSelectData` 1:1 so users can easily switch between both components.
public struct DropdownData: Sendable {

    // MARK: - 1. Identity & Alpine Bindings

    /// Unique identifier for the dropdown input and hidden form field.
    public let id: String

    /// Form field name attribute, used in form submission (defaults to `id` if nil).
    public let name: String?

    // MARK: - 2. Content & Accessibility

    /// Optional label context for the dropdown.
    public let label: LabelData?

    /// Placeholder text shown when no value is selected.
    public let placeholder: String?

    /// Prompt text displayed when empty.
    public let placeholderText: String?

    /// Accessible instructions for screen readers.
    public let placeholderAriaLabelText: String?

    // MARK: - 3. Value & Options

    /// The currently selected value.
    public let value: String?

    /// List of selectable options (value/title pairs).
    public let options: [OptionValue]?

    // MARK: - 4. Feedback & Validation

    /// Error messages to display below the dropdown.
    public let errorMessages: ErrorMessageData?

    /// Helper text to display below the dropdown.
    public let helperText: HelperTextData?

    // MARK: - 5. Presentation & State

    /// State of the component (e.g. enabled, disabled, hidden, info).
    public let state: ComponentState

    /// Optional background color for the dropdown container.
    public let backgroundColor: String?

    /// Creates a configuration instance for `Dropdown`.
    ///
    /// - Parameters:
    ///   - id: Unique identifier for the dropdown input and hidden form field.
    ///   - name: Form field name attribute, used in form submission.
    ///   - label: Optional label context for the dropdown.
    ///   - placeholder: Placeholder text shown when no value is selected.
    ///   - placeholderText: Prompt text displayed when empty.
    ///   - placeholderAriaLabelText: Accessible instructions for screen readers.
    ///   - value: The currently selected value.
    ///   - options: List of selectable options.
    ///   - errorMessages: Error messages to display below the dropdown.
    ///   - helperText: Helper text to display below the dropdown.
    ///   - state: State of the component (enabled, disabled, hidden, info).
    ///   - backgroundColor: Optional background color for the dropdown container.
    public init(
        id: String,
        name: String? = nil,
        label: LabelData? = nil,
        placeholder: String? = nil,
        placeholderText: String? = "Select an option",
        placeholderAriaLabelText: String? = "Select an option",
        value: String? = nil,
        options: [OptionValue]? = nil,
        errorMessages: ErrorMessageData? = nil,
        helperText: HelperTextData? = nil,
        state: ComponentState = .enabled,
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

    /// Creates a configuration instance from an existing `SingleSelectData` for seamless interchangeability.
    ///
    /// - Parameter data: Source `SingleSelectData` instance.
    public init(_ data: SingleSelectData) {
        self.init(
            id: data.id,
            name: data.name,
            label: data.label,
            placeholder: data.placeholder,
            placeholderText: data.placeholderText,
            placeholderAriaLabelText: data.placeholderAriaLabelText,
            value: data.value,
            options: data.options,
            errorMessages: data.errorMessages,
            helperText: data.helperText,
            state: data.state,
            backgroundColor: data.backgroundColor
        )
    }
}
