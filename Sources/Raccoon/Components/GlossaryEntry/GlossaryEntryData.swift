/// Configuration data for a single `GlossaryEntry`.
public struct GlossaryEntryData: Sendable {

    // MARK: - 1. Identity & Alpine Bindings
    public let id: String?

    // MARK: - 2. Content & Accessibility
    public let term: LocalizedText
    public let definition: LocalizedText

    // MARK: - 5. Presentation & State
    public let icon: SvgIcon?
    public let hasInitial: Bool

    // MARK: - 6. Analytics & Tracking
    public let matomoStatus: MatomoStatus

    /// Creates a new configuration instance for `GlossaryEntry`.
    ///
    /// - Parameters:
    ///   - id: Optional identifier used for anchor links.
    ///   - term: The term or concept title (page language). The first letter of the shown term is the initial.
    ///   - definition: Markdown or text explanation of the term (page language, no live-switch marker).
    ///   - icon: Optional SVG icon displayed with the term.
    ///   - hasInitial: Whether to display a large initial letter heading.
    ///   - matomoStatus: Matomo tracking consent status.
    public init(
        id: String? = nil,
        term: LocalizedText,
        definition: LocalizedText,
        icon: SvgIcon? = .question_circle,
        hasInitial: Bool = false,
        matomoStatus: MatomoStatus = .DECLINED
    ) {
        self.id = id
        self.term = term
        self.definition = definition
        self.icon = icon
        self.hasInitial = hasInitial
        self.matomoStatus = matomoStatus
    }
}
