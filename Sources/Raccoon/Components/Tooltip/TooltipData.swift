/// Configuration data for the `Tooltip` component.
public struct TooltipData: Sendable {

    public let id: String
    public let bindId: String?
    public let text: String
    public let hasArrow: Bool
    public let position: ComponentPosition

    /// Creates a new configuration instance for `Tooltip`.
    ///
    /// - Parameters:
    ///   - id: Unique DOM identifier for referencing element.
    ///   - bindId: Optional dynamic Alpine binding for the reference identifier.
    ///   - text: Tooltip message text to display.
    ///   - position: Placement of tooltip relative to trigger element, defaults to `.top`.
    ///   - hasArrow: Whether to render a pointing arrow on the tooltip bubble.
    public init(
        id: String = "",
        bindId: String? = nil,
        text: String,
        position: ComponentPosition = .top,
        hasArrow: Bool = true
    ) {
        self.id = id
        self.bindId = bindId
        self.text = text
        self.hasArrow = hasArrow
        self.position = position
    }
}
