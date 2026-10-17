/// Configuration data for the `References` component.
public struct ReferencesData: Sendable {

    public let title: String
    public let contentAsMarkdown: String

    /// Creates a new configuration instance for `References`.
    ///
    /// - Parameters:
    ///   - title: Title heading for the references list.
    ///   - contentAsMarkdown: Markdown formatted reference links and citations.
    public init(
        title: String,
        contentAsMarkdown: String
    ) {
        self.title = title
        self.contentAsMarkdown = contentAsMarkdown
    }
}
