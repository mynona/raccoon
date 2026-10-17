import HTML

public struct InputFieldData: Sendable {
    public typealias ValidationType = FieldValidationType

    // MARK: - 1. Identity & Alpine Bindings
    public let id: String

    // MARK: - 2. Content & Accessibility
    public let label: LabelData?
    public let placeholder: String?

    // MARK: - 3. Value & Options
    public let value: String?

    // MARK: - 4. Feedback & Validation
    public let errorMessages: ErrorMessageData?
    public let helperText: HelperTextData?
    public let validation: ValidationType?

    // MARK: - 5. Presentation & State
    public let type: HTML.Input.Types
    public let autocomplete: String
    public let backgroundColor: String?

    // MARK: - 6. Analytics & Tracking
    public let isMaskedInMatomo: Bool

    public var validationRegex: String? {
        validation?.regex
    }

    public var validationMessage: String? {
        validation?.errorMessage(labelTitle: label?.title)
    }

    /// Creates a new configuration instance for `InputField`.
    ///
    /// - Parameters:
    ///   - id: Unique DOM identifier and form name.
    ///   - label: Optional label configuration displayed above input.
    ///   - placeholder: Ghost text displayed when input is empty.
    ///   - value: Current string value of the input.
    ///   - errorMessages: Error message configuration displayed below input.
    ///   - helperText: Guidance or helper text displayed below input.
    ///   - validation: Client-side validation pattern and rule.
    ///   - type: HTML input type (`text`, `email`, `tel`, etc.).
    ///   - autocomplete: Browser autocomplete attribute value.
    ///   - backgroundColor: Optional background color class override.
    ///   - isMaskedInMatomo: Whether input value should be masked in Matomo tracking.
    public init(
        // 1. Identity & Alpine Bindings
        id: String,

        // 2. Content & Accessibility
        label: LabelData? = nil,
        placeholder: String? = nil,

        // 3. Value & Options
        value: String? = nil,

        // 4. Feedback & Validation
        errorMessages: ErrorMessageData? = nil,
        helperText: HelperTextData? = nil,
        validation: ValidationType? = nil,

        // 5. Presentation & State
        type: HTML.Input.Types = .text,
        autocomplete: String = "off",
        backgroundColor: String? = nil,

        // 6. Analytics & Tracking
        isMaskedInMatomo: Bool = false
    ) {
        // 1. Identity & Alpine Bindings
        self.id = id

        // 2. Content & Accessibility
        self.label = label
        self.placeholder = placeholder

        // 3. Value & Options
        self.value = value

        // 4. Feedback & Validation
        self.errorMessages = errorMessages
        self.helperText = helperText
        self.validation = validation

        // 5. Presentation & State
        self.type = type
        self.autocomplete = autocomplete
        self.backgroundColor = backgroundColor

        // 6. Analytics & Tracking
        self.isMaskedInMatomo = isMaskedInMatomo
    }
}
