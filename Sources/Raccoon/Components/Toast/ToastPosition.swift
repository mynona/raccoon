/// Fixed viewport anchor position for the `Toast` notification container.
public enum ToastPosition: String, Sendable, CaseIterable {
    /// Bottom right of the viewport.
    case bottomEnd = "bottom-end"
    /// Bottom left of the viewport.
    case bottomStart = "bottom-start"
    /// Bottom center of the viewport.
    case bottomCenter = "bottom-center"
    /// Top right of the viewport.
    case topEnd = "top-end"
    /// Top left of the viewport.
    case topStart = "top-start"
    /// Top center of the viewport.
    case topCenter = "top-center"
}
