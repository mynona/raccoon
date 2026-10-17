public enum ActionButtonType: Sendable {
    /// Primary button: main action
    case primary
    /// Secondary button: not main action
    case secondary
    /// Tertiary button: not main action
    case tertiary
    /// Warning button: warn user (example: delete)
    case warning
    /// Icon button: no label
    case icon
}
