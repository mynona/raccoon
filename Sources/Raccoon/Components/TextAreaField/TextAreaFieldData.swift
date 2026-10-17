import HTML

public struct TextAreaFieldData: Sendable {
    public typealias ValidationType = FieldValidationType

    public let id: String
    public let label: LabelData?
    public let rows: UInt
    public let placeholder: String?
    public let value: String?
    public let errorMessages: ErrorMessageData?
    public let helperText: HelperTextData?
    public let validation: ValidationType?
    public let isMonospaced: Bool

    public var validationRegex: String? {
        validation?.regex
    }

    public var validationMessage: String? {
        validation?.errorMessage(labelTitle: label?.title)
    }

    /// Creates a new configuration instance for `TextAreaField`.
    ///
    /// - Parameters:
    ///   - id: Unique DOM identifier and form field name.
    ///   - label: Optional label configuration displayed above textarea.
    ///   - placeholder: Placeholder text shown when textarea is empty.
    ///   - rows: Number of visible text lines in the textarea, defaults to 4.
    ///   - value: Initial string content of the textarea.
    ///   - validation: Optional validation pattern and rule.
    ///   - errorMessages: Error message configuration displayed below textarea.
    ///   - helperText: Guidance or helper text displayed below textarea.
    ///   - isMonospaced: Whether to display text in a monospaced font.
    public init(
        id: String,
        label: LabelData? = nil,
        placeholder: String? = nil,
        rows: UInt = 4,
        value: String? = nil,
        validation: ValidationType? = nil,
        errorMessages: ErrorMessageData? = nil,
        helperText: HelperTextData? = nil,
        isMonospaced: Bool = false
    ) {
        self.id = id
        self.label = label
        self.rows = rows
        self.placeholder = placeholder
        self.value = value
        self.errorMessages = errorMessages
        self.helperText = helperText
        self.validation = validation
        self.isMonospaced = isMonospaced
    }
}
