/// Configuration data for the `Mermaid` diagram component.
public struct MermaidData: Sendable {
    public let diagram: String
    public let widthInPercent: UInt8
    public let isCentered: Bool

    /// Creates a new configuration instance for `Mermaid`.
    ///
    /// - Parameters:
    ///   - diagram: Mermaid chart definition source text.
    ///   - widthInPercent: Rendered width as percentage (0–100), defaults to 100.
    ///   - isCentered: Whether the diagram should be horizontally centered.
    public init(
        diagram: String,
        widthInPercent: UInt8 = 100,
        isCentered: Bool = false
    ) {
        self.isCentered = isCentered
        self.diagram = diagram
        self.widthInPercent = widthInPercent
    }
}
