
/// Configuration data for the `Pagination` component.
public struct PaginationData: Sendable {

    public let tableOfContent: PaginationItem?
    public let pages: [PaginationItem]
    /// Base link
    public let hrefBase: String

    /// Creates a new configuration instance for `Pagination`.
    ///
    /// - Parameters:
    ///   - tableOfContent: Optional sidebar item representing table of contents.
    ///   - pages: Array of page items available in pagination sequence.
    ///   - hrefBase: Base URL prefix used for constructing pagination links.
    public init(
        tableOfContent: PaginationItem? = nil,
        pages: [PaginationItem],
        hrefBase: String
    ) {
        self.tableOfContent = tableOfContent
        self.pages = pages
        self.hrefBase = hrefBase
    }
}
