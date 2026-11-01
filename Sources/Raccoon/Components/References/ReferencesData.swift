/// Configuration data for the `References` component.
public struct ReferencesData: Sendable {

    public let title: LocalizedText
    public let contentAsMarkdown: String

    /// Creates a new configuration instance for `References`.
    ///
    /// - Parameters:
    ///   - title: Title heading for the references list. A blank title shows the built-in, translated "References and further reading".
    ///   - contentAsMarkdown: Markdown formatted reference links and citations.
    public init(
        title: LocalizedText,
        contentAsMarkdown: String
    ) {
        self.title = title
        self.contentAsMarkdown = contentAsMarkdown
    }
}
