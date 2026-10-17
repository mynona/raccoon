/// Configuration data for the `Notification` alert component.
public struct NotificationData: Sendable {

    public enum NotificationType: Sendable {
        case success
        case info
        case warning
        case error
    }

    public let title: String
    public let text: String?
    public let type: NotificationType

    /// Creates a new configuration instance for `Notification`.
    ///
    /// - Parameters:
    ///   - title: Main title or header text of notification.
    ///   - text: Optional descriptive detail body text.
    ///   - type: Notification severity type (`success`, `info`, `warning`, `error`).
    public init(
        title: String,
        text: String?,
        type: NotificationType
    ) {
        self.title = title
        self.text = text
        self.type = type
    }
}
