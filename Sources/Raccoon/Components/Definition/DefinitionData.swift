/// Configuration data for the `Definition` component.
public struct DefinitionData: Sendable {

    // MARK: - 2. Content & Accessibility
    public let term: String
    public let definition: String

    // MARK: - 5. Presentation & State
    public let icon: SvgIcon

    /// Creates a new configuration instance for `Definition`.
    ///
    /// - Parameters:
    ///   - term: Term or word being defined.
    ///   - definition: Definition description text.
    ///   - icon: Icon displayed next to the term, defaults to `.book`.
    public init(
        term: String,
        definition: String,
        icon: SvgIcon = .book
    ) {
        self.term = term
        self.definition = definition
        self.icon = icon
    }
}
