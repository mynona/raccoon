/// HTTP method used by `DataTable` to load data. Parameters are always sent in the query string.
public enum DataTableHTTPMethod: String, Sendable {
    case get = "GET"
    case post = "POST"
}

/// Describes where `DataTable` loads its data from and how request and response are mapped.
///
/// Defaults describe the generic contract documented in the `DataTable` plan:
/// `POST {url}?page=2&per=20&sort=title:asc&filter[title][contains]=bear&filterMode=or`
/// answered by `{ "items": [...], "total": 95 }`.
public struct DataTableEndpoint: Sendable {

    // MARK: - 1. Identity & Alpine Bindings
    /// URL that returns the JSON data.
    public let url: String

    /// HTTP method of the request.
    public let method: DataTableHTTPMethod

    // MARK: - 3. Value & Options
    /// Query parameter name for the 1-based page number.
    public let pageParam: String

    /// Query parameter name for the page size.
    public let sizeParam: String

    /// Query parameter name for the sort state (`field:asc` or `field:desc`).
    public let sortParam: String

    /// Query parameter template for a filter. `{key}` and `{op}` are replaced by column key and operator.
    public let filterParam: String

    /// Query parameter name for the filter combination mode (`and` or `or`).
    public let filterModeParam: String

    /// Dot separated path of the row array in the JSON response.
    public let itemsPath: String

    /// Dot separated path of the total item count in the JSON response.
    public let totalPath: String

    /// Static headers sent with every request (for example a CSRF token rendered by the consumer).
    public let requestHeaders: [String: String]

    /// Creates an endpoint description for `DataTable`.
    ///
    /// - Parameters:
    ///   - url: URL that returns the JSON data.
    ///   - method: HTTP method of the request.
    ///   - pageParam: Query parameter name for the page number.
    ///   - sizeParam: Query parameter name for the page size.
    ///   - sortParam: Query parameter name for the sort state.
    ///   - filterParam: Query parameter template for a filter (`{key}`, `{op}`).
    ///   - filterModeParam: Query parameter name for the filter combination mode.
    ///   - itemsPath: Path of the row array in the JSON response.
    ///   - totalPath: Path of the total item count in the JSON response.
    ///   - requestHeaders: Static headers sent with every request.
    public init(
        // 1. Identity & Alpine Bindings
        url: String,
        method: DataTableHTTPMethod = .post,

        // 3. Value & Options
        pageParam: String = "page",
        sizeParam: String = "per",
        sortParam: String = "sort",
        filterParam: String = "filter[{key}][{op}]",
        filterModeParam: String = "filterMode",
        itemsPath: String = "items",
        totalPath: String = "total",
        requestHeaders: [String: String] = [:]
    ) {
        // 1. Identity & Alpine Bindings
        self.url = url
        self.method = method

        // 3. Value & Options
        self.pageParam = pageParam
        self.sizeParam = sizeParam
        self.sortParam = sortParam
        self.filterParam = filterParam
        self.filterModeParam = filterModeParam
        self.itemsPath = itemsPath
        self.totalPath = totalPath
        self.requestHeaders = requestHeaders
    }
}
