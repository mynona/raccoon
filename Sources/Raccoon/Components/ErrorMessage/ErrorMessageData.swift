/// Configuration data for the `ErrorMessage` component.
public struct ErrorMessageData: Sendable {

    public let id: String?
    public let errorMessages: [LocalizedText]?
    public let hasIcon: Bool

    /// Creates a new configuration instance for `ErrorMessage`.
    ///
    /// - Parameters:
    ///   - id: Optional DOM identifier for the error container.
    ///   - errorMessages: Error texts to display. String literals are shown as given in every language;
    ///     pass `LocalizedText(en:translations:)` to provide translations.
    ///   - hasIcon: Whether to show a warning/error icon alongside the messages.
    public init(
        id: String? = nil,
        errorMessages: [LocalizedText]? = nil,
        hasIcon: Bool = false
    ) {
        self.id = id
        self.errorMessages = errorMessages
        self.hasIcon = hasIcon
    }
}
