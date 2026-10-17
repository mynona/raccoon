
/// Configuration data for the `Glossary` component.
public struct GlossaryData: Sendable {

    // MARK: - 1. Identity & Alpine Bindings
    public let id: String?

    // MARK: - 2. Content & Accessibility
    public let searchPlaceholder: String
    public let searchAriaLabel: String
    public let noResultsText: String

    // MARK: - 3. Value & Options
    public let entries: [GlossaryEntryData]

    // MARK: - 5. Presentation & State
    public let hasSearch: Bool

    // MARK: - 6. Analytics & Tracking
    public let matomoStatus: MatomoStatus

    public var entriesSortedAlphabetically: [GlossaryEntryData] {
        entries.sorted {
            $0.term.localizedCaseInsensitiveCompare($1.term)
                == .orderedAscending
        }
    }

    /// Creates a new configuration instance for `Glossary`.
    ///
    /// - Parameters:
    ///   - id: Optional identifier for the glossary container.
    ///   - searchPlaceholder: Placeholder text for the search filter input.
    ///   - searchAriaLabel: Accessible description for the search filter input.
    ///   - noResultsText: Text to display when no glossary entries match the search filter.
    ///   - entries: Array of glossary entries to present in the glossary list.
    ///   - hasSearch: Whether to render an in-page search filter bar above the entries.
    ///   - matomoStatus: Matomo tracking consent status.
    public init(
        id: String? = nil,
        searchPlaceholder: String = "Search glossary",
        searchAriaLabel: String = "Search glossary",
        noResultsText: String = "No matching glossary entries found",
        entries: [GlossaryEntryData],
        hasSearch: Bool = true,
        matomoStatus: MatomoStatus = .DEACTIVATED
    ) {
        self.id = id
        self.searchPlaceholder = searchPlaceholder
        self.searchAriaLabel = searchAriaLabel
        self.noResultsText = noResultsText
        self.entries = entries
        self.hasSearch = hasSearch
        self.matomoStatus = matomoStatus
    }
}
