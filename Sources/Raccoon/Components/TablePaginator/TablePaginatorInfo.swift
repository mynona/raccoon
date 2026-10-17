import Foundation

/// Pagination metadata and calculated state for table pagination.
public struct TablePaginatorInfo: Sendable {
    /// 1-based current page index.
    public let page: Int

    /// Number of items per page.
    public let per: Int

    /// Total number of items across all pages.
    public let total: Int

    /// Optional link or identifier for the previous page.
    public let previous: String?

    /// Optional link or identifier for the next page.
    public let next: String?

    /// Creates a pagination info calculation model.
    ///
    /// - Parameters:
    ///   - page: 1-based page number (defaults to 1 if nil or < 1).
    ///   - per: Items per page (defaults to `defaultPer` if nil or < 1).
    ///   - total: Total number of items across all pages.
    ///   - previous: Optional previous page link or identifier.
    ///   - next: Optional next page link or identifier.
    ///   - defaultPer: Default items per page if `per` is omitted.
    public init(
        page: Int?,
        per: Int?,
        total: Int,
        previous: String? = nil,
        next: String? = nil,
        defaultPer: Int = 20
    ) {
        self.page = max(1, page ?? 1)
        self.per = max(1, per ?? defaultPer)
        self.total = total
        self.previous = previous
        self.next = next
    }

    /// Total number of pages calculated from `total` and `per`.
    public var totalPages: Int {
        guard per > 0 else { return 1 }
        return max(1, Int((Double(total) / Double(per)).rounded(.up)))
    }

    /// Whether there is a preceding page.
    public var hasPrevious: Bool {
        page > 1
    }

    /// Whether there is a subsequent page.
    public var hasNext: Bool {
        page < totalPages
    }

    /// 1-based index of the first item on the current page.
    public var startItem: Int {
        total == 0 ? 0 : (page - 1) * per + 1
    }

    /// 1-based index of the last item on the current page.
    public var endItem: Int {
        min(page * per, total)
    }

    /// Formatted human-readable range description (e.g. `"1 – 20 of 100"`).
    public var rangeLabel: String {
        total == 0 ? "0 of 0" : "\(startItem) – \(endItem) of \(total)"
    }
}
