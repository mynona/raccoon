/// Severity type for a `Toast` notification.
public enum ToastType: String, Sendable, CaseIterable {
    /// Informational advisory message.
    case info
    /// Success confirmation message.
    case success
    /// Warning message indicating a potential issue or caution.
    case warning
    /// Error message indicating a failure or problem.
    case error
}
