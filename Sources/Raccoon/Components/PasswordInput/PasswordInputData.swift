import HTML

/// A data model that encapsulates all configuration and context
/// needed to render a password + confirm password input component.
public struct PasswordInputData: Sendable {

    // MARK: - Password field configuration

    /// Label context for the password field (id, title, required flag).
    public let passwordLabel: LabelData

    /// The key/name attribute for the password input.
    public let passwordId: String

    /// Optional error messages associated with the password field.
    public let passwordErrorMessages: ErrorMessageData?

    /// Optional helper text displayed below the password field.
    public let passwordHelperText: HelperTextData?

    // MARK: - Confirm password field configuration

    /// Whether to render a confirm password field at all.
    public let hasConfirmPassword: Bool

    /// Label context for the confirm password field.
    public let confirmLabel: LabelData?

    /// The key/name attribute for the confirm password input.
    public let confirmId: String?

    /// Optional error messages associated with the confirm password field.
    public let confirmErrorMessages: ErrorMessageData?

    /// Optional helper text displayed below the confirm password field.
    public let confirmHelperText: HelperTextData?

    // MARK: - General configuration

    /// A list of common words that should be disallowed in the password.
    public let commonWords: [String]

    // MARK: - Initializer

    /// Creates a new `PasswordInputData` with sensible defaults.
    ///
    /// - Parameters:
    ///   - passwordId: Key/name for the password input.
    ///   - passwordLabel: Label context for the password field.
    ///   - passwordErrorMessages: Optional error messages for the password field.
    ///   - passwordHelperText: Optional helper text for the password field.
    ///   - hasConfirmPassword: Whether to render a confirm password field.
    ///   - confirmId: Key/name for the confirm password input.
    ///   - confirmLabel: Label context for the confirm password field.
    ///   - confirmErrorMessages: Optional error messages for the confirm field.
    ///   - confirmHelperText: Optional helper text for the confirm field.
    ///   - commonWords: List of disallowed common words.
    public init(
        passwordId: String = "password",
        passwordLabel: LabelData = LabelData(
            id: "password",
            title: "Password",
            isRequired: true
        ),
        passwordErrorMessages: ErrorMessageData? = nil,
        passwordHelperText: HelperTextData? = nil,
        hasConfirmPassword: Bool = true,
        confirmId: String? = "confirmPassword",
        confirmLabel: LabelData = LabelData(
            id: "confirmPassword",
            title: "Confirm password",
            isRequired: true
        ),
        confirmErrorMessages: ErrorMessageData? = nil,
        confirmHelperText: HelperTextData? = nil,
        commonWords: [String] = [
            "123456", "qwerty", "abc123", "letmein", "welcome", "test",
            "password",
        ]
    ) {
        self.passwordLabel = passwordLabel
        self.passwordId = passwordId
        self.passwordErrorMessages = passwordErrorMessages
        self.passwordHelperText = passwordHelperText
        self.hasConfirmPassword = hasConfirmPassword
        self.confirmLabel = confirmLabel
        self.confirmId = confirmId
        self.confirmErrorMessages = confirmErrorMessages
        self.confirmHelperText = confirmHelperText
        self.commonWords = commonWords
    }
}
