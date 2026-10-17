/// Configuration data for the `MarkdownBlock` component.
public struct MarkdownBlockData: Sendable {

    public let markdown: String
    public let isProse: Bool

    public var rendered: String {
        renderMarkdownAsHTML(markdown)
    }

    /// Creates a new configuration instance for `MarkdownBlock`.
    ///
    /// - Parameters:
    ///   - markdown: Raw markdown string to be rendered.
    ///   - isProse: Whether to apply typography prose styles to rendered output.
    public init(
        markdown: String,
        isProse: Bool
    ) {
        self.markdown = markdown
        self.isProse = isProse
    }
}
