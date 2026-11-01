/// Configuration data for the `HelperText` component.
public struct HelperTextData: Sendable {

    public let id: String
    public let text: LocalizedText?
    public let isMarkdown: Bool

    /// Creates a new configuration instance for `HelperText`.
    ///
    /// - Parameters:
    ///   - id: Unique DOM identifier for the helper text element.
    ///   - text: Guidance text to display (a `LocalizedText`). Markdown text is resolved in the page language and has no live-switch marker.
    ///   - isMarkdown: Whether to render the text as formatted markdown.
    public init(
        id: String,
        text: LocalizedText? = nil,
        isMarkdown: Bool = false
    ) {
        self.id = id
        self.text = text
        self.isMarkdown = isMarkdown
    }
}
