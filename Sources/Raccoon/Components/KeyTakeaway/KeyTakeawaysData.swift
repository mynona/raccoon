/// Configuration data for the `KeyTakeaways` component.
public struct KeyTakeawaysData: Sendable {

    // MARK: - 2. Content & Accessibility
    public let title: String
    public let contentAsMarkdown: String

    // MARK: - 5. Presentation & State
    public let icon: SvgIcon

    /// Creates a new configuration instance for `KeyTakeaways`.
    ///
    /// - Parameters:
    ///   - title: Title heading for the takeaways callout.
    ///   - contentAsMarkdown: Markdown content of key takeaways.
    ///   - icon: Decorative icon displayed in header, defaults to `.lightbulb`.
    public init(
        title: String,
        contentAsMarkdown: String,
        icon: SvgIcon = .lightbulb
    ) {
        self.title = title
        self.contentAsMarkdown = contentAsMarkdown
        self.icon = icon
    }
}
