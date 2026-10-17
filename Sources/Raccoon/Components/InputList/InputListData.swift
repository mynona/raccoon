/// A data model for configuring and rendering an `InputList` component.
/// Holds metadata such as the field key, label, initial values, and validation rules.
public struct InputListData: Sendable {

    /// Defines the type of validation applied to the input values.
    public enum ValidationType: Sendable {
        /// A URL value. Must include `http://` or `https://` and a valid domain.
        case url
        /// An email address value.
        case email
        /// A numeric amount (integer or decimal with up to 2 decimal places).
        case amount
        /// A custom validation with a regex pattern and error message.
        case custom(pattern: String, message: String)

        /// The regex string used to validate the input value.
        public var regex: String {
            switch self {
            case .url:
                // Enforces http(s):// + domain labels (1–63 chars) + TLD (2–63 chars), max 253 chars total
                return
                    #"^(?=.{1,253}$)https?:\/\/([A-Za-z0-9-]{1,63}\.)+[A-Za-z]{2,63}(\/\S*)?$"#
            case .email:
                // Practical email regex
                return #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,63}$"#
            case .amount:
                // Integers or decimals with up to 2 decimal places
                return #"^\d+(\.\d{1,2})?$"#
            case .custom(let pattern, _):
                return pattern
            }
        }

        /// The default error message shown when validation fails.
        public var errorMessage: String {
            switch self {
            case .url:
                return "Please enter a valid http:// or https:// URL."
            case .email:
                return "Please enter a valid email address."
            case .amount:
                return "Please enter a valid amount (e.g. 10 or 10.50)."
            case .custom(_, let message):
                return message
            }
        }
    }

    /// The key used for form submission (name attribute of hidden inputs).
    public let id: String

    /// Optional label context for rendering a label alongside the input list.
    public let label: LabelData?

    /// Optional initial values to pre‑populate the list.
    public let values: [String]?

    /// The validation type applied to the list values.
    public let validationType: ValidationType

    /// The regex string derived from the `validationType`.
    public var validationRegEx: String {
        validationType.regex
    }

    /// The error message derived from the `validationType`.
    public var validationMessage: String {
        validationType.errorMessage
    }

    /// Optional error message context.
    /// If present, the error message will be displayed below the component.
    public let errorMessages: ErrorMessageData?

    /// Optional helper text context.
    /// If present, the helper text will be displayed below the component to guide the user.
    public let helperText: HelperTextData?

    /// Creates a new `InputListData` configuration.
    ///
    /// - Parameters:
    ///   - id: The form field key (used as the input name).
    ///   - label: An optional label context for rendering a label.
    ///   - values: Optional initial values for the list.
    ///   - validationType: The validation type to apply.
    ///   - errorMessages: Optional error message context displayed below the component.
    ///   - helperText: Optional helper text context displayed below the component.
    public init(
        id: String,
        label: LabelData?,
        values: [String]?,
        validationType: ValidationType,
        errorMessages: ErrorMessageData? = nil,
        helperText: HelperTextData? = nil
    ) {
        self.id = id
        self.label = label
        self.values = values
        self.validationType = validationType
        self.errorMessages = errorMessages
        self.helperText = helperText
    }
}
