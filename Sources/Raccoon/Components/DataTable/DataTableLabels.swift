/// All built-in strings of `DataTable`, so consumers can translate or reword them.
///
/// `{count}` and `{filter}` are placeholders replaced at runtime.
public struct DataTableLabels: Sendable, Encodable {

    // MARK: - 2. Content & Accessibility
    /// Header of the row number column.
    public let rowNumberHeader: String
    /// Text of the filter toggle button.
    public let filters: String
    /// Accessible name of the filter toggle while filters are active (`{count}`).
    public let filtersActive: String
    /// Text of the button that removes all filters.
    public let clearAll: String
    /// Text of the button that applies pending filters.
    public let apply: String
    /// Label of the filter combination selector.
    public let filterMode: String
    /// Option "all filters must match".
    public let filterModeAnd: String
    /// Option "any filter may match".
    public let filterModeOr: String
    /// Option that disables an enumeration filter.
    public let all: String
    /// Boolean option "true".
    public let yes: String
    /// Boolean option "false".
    public let no: String
    /// Accessible name of a filter chip remove button (`{filter}`).
    public let removeFilter: String
    /// Text announced while loading.
    public let loading: String
    /// Text announced after loading (`{count}`).
    public let results: String
    /// Empty state with active filters.
    public let noResults: String
    /// Empty state without filters.
    public let noData: String
    /// Error message.
    public let error: String
    /// Retry button text.
    public let retry: String
    /// Screen reader text for missing cell values.
    public let emptyValue: String
    /// Announcement when saving a toggle cell failed and the change was reverted.
    public let toggleFailed: String

    /// Creates the label set. All parameters default to English.
    ///
    /// - Parameters:
    ///   - rowNumberHeader: Header of the row number column.
    ///   - filters: Text of the filter toggle button.
    ///   - filtersActive: Accessible name of the filter toggle while filters are active.
    ///   - clearAll: Text of the button that removes all filters.
    ///   - apply: Text of the button that applies pending filters.
    ///   - filterMode: Label of the filter combination selector.
    ///   - filterModeAnd: Option "all filters must match".
    ///   - filterModeOr: Option "any filter may match".
    ///   - all: Option that disables an enumeration filter.
    ///   - yes: Boolean option "true".
    ///   - no: Boolean option "false".
    ///   - removeFilter: Accessible name of a filter chip remove button.
    ///   - loading: Text announced while loading.
    ///   - results: Text announced after loading.
    ///   - noResults: Empty state with active filters.
    ///   - noData: Empty state without filters.
    ///   - error: Error message.
    ///   - retry: Retry button text.
    ///   - emptyValue: Screen reader text for missing cell values.
    ///   - toggleFailed: Announcement when saving a toggle cell failed.
    public init(
        rowNumberHeader: String = "#",
        filters: String = "Filters",
        filtersActive: String = "Filters, {count} active",
        clearAll: String = "Clear all",
        apply: String = "Apply filters",
        filterMode: String = "Match",
        filterModeAnd: String = "All filters",
        filterModeOr: String = "Any filter",
        all: String = "All",
        yes: String = "Yes",
        no: String = "No",
        removeFilter: String = "Remove filter: {filter}",
        loading: String = "Loading data…",
        results: String = "{count} results",
        noResults: String = "No results found",
        noData: String = "No data available",
        error: String = "The data could not be loaded.",
        retry: String = "Try again",
        emptyValue: String = "No data",
        toggleFailed: String = "The change could not be saved."
    ) {
        self.rowNumberHeader = rowNumberHeader
        self.filters = filters
        self.filtersActive = filtersActive
        self.clearAll = clearAll
        self.apply = apply
        self.filterMode = filterMode
        self.filterModeAnd = filterModeAnd
        self.filterModeOr = filterModeOr
        self.all = all
        self.yes = yes
        self.no = no
        self.removeFilter = removeFilter
        self.loading = loading
        self.results = results
        self.noResults = noResults
        self.noData = noData
        self.error = error
        self.retry = retry
        self.emptyValue = emptyValue
        self.toggleFailed = toggleFailed
    }
}
