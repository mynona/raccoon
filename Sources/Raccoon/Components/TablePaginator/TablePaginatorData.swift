import Foundation

/// Configuration data for `TablePaginator`. Serves as the public API contract.
public struct TablePaginatorData: Sendable {

    // MARK: - 1. Identity & Alpine Bindings

    /// DOM identifier for the items-per-page select element.
    public let selectId: String

    /// Form field name attribute for the items-per-page select element.
    public let selectName: String

    /// Alpine.js expression or variable name for current page.
    public let bindPage: String

    /// Alpine.js expression or variable name for items per page.
    public let bindPer: String

    /// Alpine.js expression or variable name for total items count.
    public let bindTotal: String

    /// Alpine.js expression or variable name for total pages count.
    public let bindTotalPages: String

    /// Alpine.js expression or variable name for the formatted range label (e.g. `"1 – 20 of 100"`).
    public let bindRangeLabel: String

    /// Alpine.js expression or variable name for the available page size options array.
    public let bindPageSizeOptions: String

    /// Alpine.js boolean expression indicating if there is a previous page.
    public let bindHasPrevious: String

    /// Alpine.js boolean expression indicating if there is a next page.
    public let bindHasNext: String

    /// Alpine.js boolean expression indicating loading/busy state.
    public let bindIsLoading: String

    /// Alpine.js visibility expression (`x-show`) for the paginator container.
    public let bindShow: String?

    /// Alpine.js handler expression when page size changes.
    public let onPageSizeChange: String?

    /// Alpine.js handler expression to navigate to first page.
    public let onFirstPage: String?

    /// Alpine.js handler expression to navigate to previous page.
    public let onPreviousPage: String?

    /// Alpine.js handler expression to navigate to next page.
    public let onNextPage: String?

    /// Alpine.js handler expression to navigate to last page.
    public let onLastPage: String?

    // MARK: - 2. Content & Accessibility

    /// Accessible label for the `<nav>` region.
    public let ariaLabel: String

    /// Label displayed next to the page size select element.
    public let itemsPerPageLabel: String

    /// Accessible label for the first page button.
    public let firstPageAriaLabel: String

    /// Accessible label for the previous page button.
    public let previousPageAriaLabel: String

    /// Accessible label for the next page button.
    public let nextPageAriaLabel: String

    /// Accessible label for the last page button.
    public let lastPageAriaLabel: String

    // MARK: - 3. Value & Options

    /// Interaction mode: `.alpine` for client-side/AJAX state or `.link` for SSR standard navigation.
    public let mode: TablePaginatorMode

    /// Static pagination information used in `.link` (SSR) mode.
    public let info: TablePaginationInfo?

    /// Available page size options (e.g. `[5, 10, 20, 50, 100]`).
    public let pageSizeOptions: [Int]

    // MARK: - 6. Analytics & Tracking

    /// Matomo tracking consent status.
    public let matomoStatus: MatomoStatus

    /// Optional Matomo content tracking configuration.
    public let contentTracker: MatomoContentTracker?

    /// Creates a configuration instance for `TablePaginator`.
    ///
    /// - Parameters:
    ///   - selectId: DOM identifier for the items-per-page select element.
    ///   - selectName: Form field name attribute for the items-per-page select element.
    ///   - bindPage: Alpine.js expression or variable name for current page.
    ///   - bindPer: Alpine.js expression or variable name for items per page.
    ///   - bindTotal: Alpine.js expression or variable name for total items count.
    ///   - bindTotalPages: Alpine.js expression or variable name for total pages count.
    ///   - bindRangeLabel: Alpine.js expression or variable name for formatted range label.
    ///   - bindPageSizeOptions: Alpine.js expression or variable name for page size options array.
    ///   - bindHasPrevious: Alpine.js boolean expression indicating if there is a previous page.
    ///   - bindHasNext: Alpine.js boolean expression indicating if there is a next page.
    ///   - bindIsLoading: Alpine.js boolean expression indicating loading/busy state.
    ///   - bindShow: Alpine.js visibility expression (`x-show`) for the paginator container.
    ///   - onPageSizeChange: Alpine.js handler expression when page size changes.
    ///   - onFirstPage: Alpine.js handler expression to navigate to first page.
    ///   - onPreviousPage: Alpine.js handler expression to navigate to previous page.
    ///   - onNextPage: Alpine.js handler expression to navigate to next page.
    ///   - onLastPage: Alpine.js handler expression to navigate to last page.
    ///   - ariaLabel: Accessible label for the `<nav>` landmark region.
    ///   - itemsPerPageLabel: Label displayed next to the page size select element.
    ///   - firstPageAriaLabel: Accessible label for the first page button.
    ///   - previousPageAriaLabel: Accessible label for the previous page button.
    ///   - nextPageAriaLabel: Accessible label for the next page button.
    ///   - lastPageAriaLabel: Accessible label for the last page button.
    ///   - mode: Interaction mode (`.alpine` or `.link`).
    ///   - info: Static pagination information used in `.link` (SSR) mode.
    ///   - pageSizeOptions: Available page size options (e.g. `[5, 10, 20, 50, 100]`).
    ///   - matomoStatus: Tracking consent status for Matomo analytics.
    ///   - contentTracker: Optional Matomo content tracking configuration.
    public init(
        // 1. Identity & Alpine Bindings
        selectId: String = "itemsPerPage",
        selectName: String = "itemsPerPage",
        bindPage: String = "page",
        bindPer: String = "per",
        bindTotal: String = "total",
        bindTotalPages: String = "totalPages",
        bindRangeLabel: String = "rangeLabel",
        bindPageSizeOptions: String = "pageSizeOptions",
        bindHasPrevious: String = "hasPrevious",
        bindHasNext: String = "hasNext",
        bindIsLoading: String = "isLoading",
        bindShow: String? = nil,
        onPageSizeChange: String? = "changePageSize($event.target.value)",
        onFirstPage: String? = "goToPage(1)",
        onPreviousPage: String? = "previousPage()",
        onNextPage: String? = "nextPage()",
        onLastPage: String? = "goToPage(totalPages)",

        // 2. Content & Accessibility
        ariaLabel: String = "Pagination",
        itemsPerPageLabel: String = "Items per page:",
        firstPageAriaLabel: String = "First page",
        previousPageAriaLabel: String = "Previous page",
        nextPageAriaLabel: String = "Next page",
        lastPageAriaLabel: String = "Last page",

        // 3. Value & Options
        mode: TablePaginatorMode = .alpine,
        info: TablePaginationInfo? = nil,
        pageSizeOptions: [Int] = [5, 10, 20, 50, 100],

        // 6. Analytics & Tracking
        matomoStatus: MatomoStatus = .DECLINED,
        contentTracker: MatomoContentTracker? = nil
    ) {
        // 1. Identity & Alpine Bindings
        self.selectId = selectId
        self.selectName = selectName
        self.bindPage = bindPage
        self.bindPer = bindPer
        self.bindTotal = bindTotal
        self.bindTotalPages = bindTotalPages
        self.bindRangeLabel = bindRangeLabel
        self.bindPageSizeOptions = bindPageSizeOptions
        self.bindHasPrevious = bindHasPrevious
        self.bindHasNext = bindHasNext
        self.bindIsLoading = bindIsLoading
        switch mode {
        case .alpine:
            self.bindShow = bindShow ?? "hasSearched && total > 0"
        case .link:
            self.bindShow = bindShow
        }
        self.onPageSizeChange = onPageSizeChange
        self.onFirstPage = onFirstPage
        self.onPreviousPage = onPreviousPage
        self.onNextPage = onNextPage
        self.onLastPage = onLastPage

        // 2. Content & Accessibility
        self.ariaLabel = ariaLabel
        self.itemsPerPageLabel = itemsPerPageLabel
        self.firstPageAriaLabel = firstPageAriaLabel
        self.previousPageAriaLabel = previousPageAriaLabel
        self.nextPageAriaLabel = nextPageAriaLabel
        self.lastPageAriaLabel = lastPageAriaLabel

        // 3. Value & Options
        self.mode = mode
        self.info = info
        self.pageSizeOptions = pageSizeOptions

        // 6. Analytics & Tracking
        self.matomoStatus = matomoStatus
        self.contentTracker = contentTracker
    }
}
