import Foundation

/// Mode of operation for `TablePaginator`.
public enum TablePaginatorMode: Sendable {
    /// Pure client-side or AJAX interaction driven entirely by Alpine.js.
    case alpine

    /// Server-side rendered (SSR) navigation using standard URL links and query parameters.
    case link(basePath: String, queryParams: [String: String] = [:])
}
