import Foundation

/// JSON handed to `data-table.js`. Only what the browser needs; all markup is rendered on the server.
struct DataTableClientConfig: Encodable {

    struct Endpoint: Encodable {
        let url: String
        let method: String
        let pageParam: String
        let sizeParam: String
        let sortParam: String
        let filterParam: String
        let filterModeParam: String
        let itemsPath: String
        let totalPath: String
        let headers: [String: String]
    }

    struct Option: Encodable {
        let title: String
        let value: String
    }

    struct Filter: Encodable {
        let label: String
        let kind: String
        let `operator`: String
        let options: [Option]
    }

    struct Column: Encodable {
        let key: String
        let label: String
        let type: String
        let align: String
        let sortable: Bool
        let hideable: Bool
        let visible: Bool
        let filter: Filter?
    }

    struct Sort: Encodable {
        let key: String
        let direction: String
    }

    struct Search: Encodable {
        let param: String
        let minLength: Int
        let hint: String
    }

    let search: Search?

    let id: String
    let endpoint: Endpoint
    let fixedQuery: [String: String]
    let columns: [Column]
    let pageSizeOptions: [Int]
    let defaultPageSize: Int
    let defaultSort: Sort?
    let hasRowNumbers: Bool
    let hasPagination: Bool
    let hasColumnConfigurator: Bool
    let hasFilterMode: Bool
    let hasUrlState: Bool
    let filterTrigger: String
    let labels: DataTableLabels

    init(_ data: DataTableData) {
        id = data.id
        endpoint = Endpoint(
            url: data.endpoint.url,
            method: data.endpoint.method.rawValue,
            pageParam: data.endpoint.pageParam,
            sizeParam: data.endpoint.sizeParam,
            sortParam: data.endpoint.sortParam,
            filterParam: data.endpoint.filterParam,
            filterModeParam: data.endpoint.filterModeParam,
            itemsPath: data.endpoint.itemsPath,
            totalPath: data.endpoint.totalPath,
            headers: data.endpoint.requestHeaders
        )
        fixedQuery = data.fixedQuery
        columns = data.columns.map { column in
            Column(
                key: column.key,
                label: column.label,
                type: column.cellType.wireName,
                align: column.align.rawValue,
                sortable: column.hasSorting,
                hideable: column.isHideable,
                visible: column.isVisibleByDefault,
                filter: column.hasFiltering
                    ? Self.filter(column, labels: data.labels) : nil
            )
        }
        pageSizeOptions = data.pageSizeOptions
        defaultPageSize = data.defaultPageSize
        defaultSort = data.defaultSort.map {
            Sort(key: $0.key, direction: $0.direction.rawValue)
        }
        hasRowNumbers = data.hasRowNumbers
        search = data.search.map {
            Search(
                param: $0.param,
                minLength: $0.minLength,
                hint: $0.hint.replacingOccurrences(
                    of: "{min}",
                    with: String($0.minLength)
                )
            )
        }
        hasPagination = data.hasPagination
        hasColumnConfigurator = data.hasColumnConfigurator
        hasFilterMode = data.hasFilterMode
        hasUrlState = data.hasUrlState
        filterTrigger =
            switch data.filterTrigger {
            case .mixed: "mixed"
            case .apply: "apply"
            case .immediate: "immediate"
            }
        labels = data.labels
    }

    private static func filter(
        _ column: DataTableColumn,
        labels: DataTableLabels
    ) -> Filter? {
        guard let filter = column.filter else { return nil }
        let kind: String
        var options: [Option] = []
        switch filter.kind {
        case .text: kind = "text"
        case .integer: kind = "integer"
        case .double: kind = "double"
        case .date: kind = "date"
        case .dateRange: kind = "dateRange"
        case .enumeration(let values):
            kind = "enumeration"
            options = values.map { Option(title: $0.title, value: $0.value) }
        case .boolean(.dropdown):
            kind = "boolean-dropdown"
            options = [
                Option(title: labels.yes, value: "true"),
                Option(title: labels.no, value: "false"),
            ]
        case .boolean(.check): kind = "boolean-check"
        }
        return Filter(
            label: filter.label ?? column.label,
            kind: kind,
            operator: filter.operator.rawValue,
            options: options
        )
    }

    /// Base64 of the UTF-8 JSON. Safe inside an HTML attribute and decoded by `dataTableConfig()`.
    func encoded() -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys]
        guard let json = try? encoder.encode(self) else { return "" }
        return json.base64EncodedString()
    }
}
