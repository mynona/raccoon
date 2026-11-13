/// Configuration data for a single toast notification item.
public struct ToastItemData: Sendable {
    /// Unique identifier for the toast item.
    public let id: String
    /// Severity type of the toast item (`.info`, `.success`, `.warning`, `.error`).
    public let type: ToastType
    /// Main headline or summary of the toast notification.
    public let title: LocalizedText?
    /// Optional detailed description or message body.
    public let text: LocalizedText?
    /// Display duration in milliseconds before auto-dismissal (0 = sticky/persistent, nil = use container default).
    public let durationMs: Int?

    /// Creates a new configuration instance for a toast item.
    ///
    /// - Parameters:
    ///   - id: Unique identifier for the toast item.
    ///   - type: Severity type of the toast item (`.info`, `.success`, `.warning`, `.error`).
    ///   - title: Main headline or summary of the toast notification.
    ///   - text: Optional detailed description or message body.
    ///   - durationMs: Display duration in milliseconds before auto-dismissal (0 = sticky/persistent, nil = use container default).
    public init(
        id: String = "",
        type: ToastType = .info,
        title: LocalizedText? = nil,
        text: LocalizedText? = nil,
        durationMs: Int? = nil
    ) {
        self.id = id
        self.type = type
        self.title = title
        self.text = text
        self.durationMs = durationMs
    }
}
