
/// Data model for the `CheckboxSelect` component.
///
/// Represents all the information required to render a checkbox selection UI,
/// including the field key, label, available options, and optional helper or error messages.
public struct CheckboxSelectData: Sendable {

    /// The form field key (used as the `name` attribute of the hidden input).
    /// This is the identifier under which the selected values will be submitted.
    public let id: String

    /// Optional label context for the component.
    /// If provided, the label will be displayed above the checkbox list.
    public let label: LabelData?

    /// The list of available options to render as checkboxes.
    /// Each option is represented by an `OptionValue` containing a `value` and `title`.
    public let values: [OptionValue]

    /// Optional error message context.
    /// If present, the error message will be displayed below the component.
    public let errorMessages: ErrorMessageData?

    /// Optional helper text context.
    /// If present, the helper text will be displayed below the component to guide the user.
    public let helperText: HelperTextData?

    /// Determines whether a search field should be shown above the checkbox list.
    /// Defaults to `true`.
    public let hasSearch: Bool

    public let hasSelectAll: Bool

    /// Creates a new `CheckboxSelectData` instance.
    ///
    /// - Parameters:
    ///   - id: The form field key (used for the hidden input).
    ///   - label: Optional label context to display above the component.
    ///   - values: The list of options to render as checkboxes.
    ///   - errorMessages: Optional error message context.
    ///   - helperText: Optional helper text context.
    ///   - hasSearch: Whether to display a search field above the checkbox list.
    ///   - hasSelectAll: Whether to display a select-all action above the list.
    public init(
        id: String,
        label: LabelData?,
        values: [OptionValue],
        errorMessages: ErrorMessageData? = nil,
        helperText: HelperTextData? = nil,
        hasSearch: Bool = true,
        hasSelectAll: Bool = true
    ) {
        self.id = id
        self.label = label
        self.values = values
        self.errorMessages = errorMessages
        self.helperText = helperText
        self.hasSearch = hasSearch
        self.hasSelectAll = hasSelectAll
    }
}
