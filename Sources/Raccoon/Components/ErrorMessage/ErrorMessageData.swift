/// Configuration data for the `ErrorMessage` component.
public struct ErrorMessageData: Sendable {

    public let id: String?
    public let errorMessages: [String]?
    public let hasIcon: Bool

    /// Creates a new configuration instance for `ErrorMessage`.
    ///
    /// - Parameters:
    ///   - id: Optional DOM identifier for the error container.
    ///   - errorMessages: Array of error strings to display.
    ///   - hasIcon: Whether to show a warning/error icon alongside the messages.
    public init(
        id: String? = nil,
        errorMessages: [String]? = nil,
        hasIcon: Bool = false
    ) {
        self.id = id
        self.errorMessages = errorMessages
        self.hasIcon = hasIcon
    }
}
