/// Configuration data for the `HelperText` component.
public struct HelperTextData: Sendable {

    public let id: String
    public let text: String?
    public let isMarkdown: Bool

    /// Creates a new configuration instance for `HelperText`.
    ///
    /// - Parameters:
    ///   - id: Unique DOM identifier for the helper text element.
    ///   - text: Guidance text to display.
    ///   - isMarkdown: Whether to render the text as formatted markdown.
    public init(
        id: String,
        text: String? = nil,
        isMarkdown: Bool = false
    ) {
        self.id = id
        self.text = text
        self.isMarkdown = isMarkdown
    }
}
