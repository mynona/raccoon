/// Configuration data for the `Definition` component.
public struct DefinitionData: Sendable {

    // MARK: - 2. Content & Accessibility
    public let term: LocalizedText
    public let definition: LocalizedText

    // MARK: - 5. Presentation & State
    public let icon: SvgIcon

    /// Creates a new configuration instance for `Definition`.
    ///
    /// - Parameters:
    ///   - term: Term or word being defined (a `LocalizedText`, shown in the page language).
    ///   - definition: Definition description as markdown (a `LocalizedText`, page language, no live-switch marker).
    ///   - icon: Icon displayed next to the term, defaults to `.book`.
    public init(
        term: LocalizedText,
        definition: LocalizedText,
        icon: SvgIcon = .book
    ) {
        self.term = term
        self.definition = definition
        self.icon = icon
    }
}
