/// When filter changes are sent to the backend.
public enum DataTableFilterTrigger: Sendable {
    /// Text and number controls wait for "Apply" or Enter; dropdowns and checkboxes apply immediately.
    case mixed
    /// Every control waits for "Apply" or Enter.
    case apply
    /// Every control applies immediately (text and number controls debounced).
    case immediate
}

/// Configuration of `DataTable`. Serves as the public API contract.
public struct DataTableData: Sendable {

    // MARK: - 1. Identity & Alpine Bindings
    /// Unique table id. Also the local storage key and prefix of DOM ids.
    public let id: String

    /// Data source and request/response mapping.
    public let endpoint: DataTableEndpoint

    // MARK: - 2. Content & Accessibility
    /// Table caption. Shown above the table and used as accessible table name.
    public let caption: String

    /// Built-in strings.
    public let labels: DataTableLabels

    // MARK: - 3. Value & Options
    /// Columns in default order.
    public let columns: [DataTableColumn]

    /// Parameters sent with every request and not shown to the user (scope filters, `q`, ...).
    public let fixedQuery: [String: String]

    /// Selectable page sizes.
    public let pageSizeOptions: [Int]

    /// Initially selected page size.
    public let defaultPageSize: Int

    /// Initial sort state.
    public let defaultSort: DataTableSort?

    /// Free-text search above the table. Without it no search field is shown.
    public let search: DataTableSearch?

    // MARK: - 5. Presentation & State
    /// Whether a `#` column with continuous row numbers is shown.
    public let hasRowNumbers: Bool

    /// Whether data is paginated with `TablePaginator`. Without pagination no page parameters are sent.
    public let hasPagination: Bool

    /// Whether users can show, hide and reorder columns.
    public let hasColumnConfigurator: Bool

    /// Whether users can choose between "all filters" and "any filter".
    public let hasFilterMode: Bool

    /// Whether page, size, sort and filters are mirrored in the URL. Use for one table per page.
    public let hasUrlState: Bool

    /// When filter changes are sent to the backend.
    public let filterTrigger: DataTableFilterTrigger

    // MARK: - 6. Analytics & Tracking
    /// Tracking consent for row action buttons.
    public let matomoStatus: MatomoStatus

    /// Creates a configuration for `DataTable`.
    ///
    /// - Parameters:
    ///   - id: Unique table id, also local storage key.
    ///   - endpoint: Data source and request/response mapping.
    ///   - caption: Table caption.
    ///   - labels: Built-in strings.
    ///   - columns: Columns in default order.
    ///   - fixedQuery: Parameters sent with every request.
    ///   - pageSizeOptions: Selectable page sizes.
    ///   - defaultPageSize: Initially selected page size.
    ///   - defaultSort: Initial sort state.
    ///   - search: Free-text search above the table.
    ///   - hasRowNumbers: Whether a `#` column is shown.
    ///   - hasPagination: Whether data is paginated.
    ///   - hasColumnConfigurator: Whether users can show, hide and reorder columns.
    ///   - hasFilterMode: Whether users can choose between "all filters" and "any filter".
    ///   - hasUrlState: Whether page, size, sort and filters are mirrored in the URL.
    ///   - filterTrigger: When filter changes are sent to the backend.
    ///   - matomoStatus: Tracking consent for row action buttons.
    public init(
        // 1. Identity & Alpine Bindings
        id: String,
        endpoint: DataTableEndpoint,

        // 2. Content & Accessibility
        caption: String,
        labels: DataTableLabels = DataTableLabels(),

        // 3. Value & Options
        columns: [DataTableColumn],
        fixedQuery: [String: String] = [:],
        pageSizeOptions: [Int] = [5, 10, 20, 50, 100],
        defaultPageSize: Int = 20,
        defaultSort: DataTableSort? = nil,
        search: DataTableSearch? = nil,

        // 5. Presentation & State
        hasRowNumbers: Bool = true,
        hasPagination: Bool = true,
        hasColumnConfigurator: Bool = true,
        hasFilterMode: Bool = false,
        hasUrlState: Bool = true,
        filterTrigger: DataTableFilterTrigger = .mixed,

        // 6. Analytics & Tracking
        matomoStatus: MatomoStatus = .DECLINED
    ) {
        // 1. Identity & Alpine Bindings
        self.id = id
        self.endpoint = endpoint

        // 2. Content & Accessibility
        self.caption = caption
        self.labels = labels

        // 3. Value & Options
        self.columns = columns
        self.fixedQuery = fixedQuery
        self.pageSizeOptions = pageSizeOptions
        self.defaultPageSize = defaultPageSize
        self.defaultSort = defaultSort
        self.search = search

        // 5. Presentation & State
        self.hasRowNumbers = hasRowNumbers
        self.hasPagination = hasPagination
        self.hasColumnConfigurator = hasColumnConfigurator
        self.hasFilterMode = hasFilterMode
        self.hasUrlState = hasUrlState
        self.filterTrigger = filterTrigger

        // 6. Analytics & Tracking
        self.matomoStatus = matomoStatus
    }
}
