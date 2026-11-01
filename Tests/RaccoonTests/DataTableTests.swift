import Foundation
import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

private func decodedConfig(_ html: String) throws -> [String: Any] {
    let marker = "dataTableConfig('"
    let start = try #require(html.range(of: marker))
    let rest = html[start.upperBound...]
    let end = try #require(rest.firstIndex(of: "'"))
    let data = try #require(Data(base64Encoded: String(rest[..<end])))
    return try #require(
        try JSONSerialization.jsonObject(with: data) as? [String: Any]
    )
}

private func makeData(
    columns: [DataTableColumn]? = nil,
    hasRowNumbers: Bool = true,
    hasPagination: Bool = true,
    hasColumnConfigurator: Bool = true,
    hasFilterMode: Bool = false
) -> DataTableData {
    DataTableData(
        id: "facts",
        endpoint: DataTableEndpoint(url: "/data"),
        caption: "Raccoon facts",
        columns: columns ?? [
            DataTableColumn(
                key: "name",
                label: "Name",
                filter: DataTableFilter(kind: .text),
                hasSorting: true
            ),
            DataTableColumn(
                key: "weight",
                label: "Weight",
                cellType: .double,
                filter: DataTableFilter(kind: .double, operator: .lte)
            ),
            DataTableColumn(
                key: "habitat",
                label: "Habitat",
                filter: DataTableFilter(
                    kind: .enumeration([
                        DataTableFilterOption(title: "Forest", value: "forest")
                    ])
                )
            ),
            DataTableColumn(
                key: "nocturnal",
                label: "Nocturnal",
                cellType: .custom(.yesNo(key: "nocturnal")),
                filter: DataTableFilter(kind: .boolean(.check))
            ),
            DataTableColumn(
                key: "described",
                label: "Described",
                filter: DataTableFilter(kind: .dateRange)
            ),
            DataTableColumn(
                key: "actions",
                label: "Actions",
                cellType: .actions([
                    DataTableAction(
                        id: "details",
                        clickAction: "alert(row.name + ' clicked')",
                        label: "Details",
                        bindAriaLabel: "'Details for ' + row.name",
                        visibleWhen: "row.canEdit"
                    )
                ])
            ),
        ],
        hasRowNumbers: hasRowNumbers,
        hasPagination: hasPagination,
        hasColumnConfigurator: hasColumnConfigurator,
        hasFilterMode: hasFilterMode
    )
}

@Suite("DataTable")
struct DataTableTests {

    @Test(
        "column defaults derive alignment and filtering from the configuration"
    )
    func columnDefaults() {
        let text = DataTableColumn(key: "a", label: "A")
        let integer = DataTableColumn(key: "b", label: "B", cellType: .integer)
        let centered = DataTableColumn(
            key: "c",
            label: "C",
            cellType: .double,
            align: .center
        )
        #expect(text.align == .left)
        #expect(integer.align == .right)
        #expect(centered.align == .center)
        #expect(text.isHideable)
        #expect(text.isVisibleByDefault)
        #expect(!text.hasSorting)
    }

    @Test("hasFiltering requires a filter definition")
    func filteringNeedsFilter() {
        let withoutFilter = DataTableColumn(
            key: "a",
            label: "A",
            hasFiltering: true
        )
        let disabled = DataTableColumn(
            key: "b",
            label: "B",
            filter: DataTableFilter(kind: .text),
            hasFiltering: false
        )
        let enabled = DataTableColumn(
            key: "c",
            label: "C",
            filter: DataTableFilter(kind: .text)
        )
        #expect(!withoutFilter.hasFiltering)
        #expect(!disabled.hasFiltering)
        #expect(enabled.hasFiltering)
    }

    @Test("filter operators default by kind")
    func filterOperatorDefaults() {
        #expect(DataTableFilter(kind: .text).operator == .contains)
        #expect(DataTableFilter(kind: .integer).operator == .eq)
        #expect(DataTableFilter(kind: .dateRange).operator == .between)
        #expect(
            DataTableFilter(kind: .integer, operator: .gte).operator == .gte
        )
    }

    @Test("data defaults follow the plan")
    func dataDefaults() {
        let data = makeData()
        #expect(data.pageSizeOptions == [5, 10, 20, 50, 100])
        #expect(data.defaultPageSize == 20)
        #expect(data.hasRowNumbers)
        #expect(data.hasUrlState)
        #expect(data.endpoint.method == .post)
        #expect(data.endpoint.filterParam == "filter[{key}][{op}]")
    }

    @Test("renders semantic table with caption, sort buttons and aria-sort")
    func semanticTable() {
        let html = renderHTML(DataTable(makeData()).render())
        #expect(html.contains("<table"))
        #expect(
            html.contains("<caption class=\"sr-only\">Raccoon facts</caption>")
        )
        #expect(html.contains("scope=\"col\""))
        #expect(html.contains(":aria-sort=\"ariaSort(col)\""))
        #expect(html.contains("@click=\"sort(col.key)\""))
        #expect(html.contains(":aria-busy=\"status === 'loading'\""))
        #expect(html.contains("role=\"status\""))
        #expect(html.contains("role=\"alert\""))
    }

    @Test("scroll region is focusable and named")
    func scrollRegion() {
        let html = renderHTML(DataTable(makeData()).render())
        #expect(html.contains("role=\"region\""))
        #expect(html.contains("aria-label=\"Raccoon facts\""))
        #expect(html.contains("tabindex=\"0\""))
    }

    @Test("renders row number column only when enabled")
    func rowNumbers() {
        let with = renderHTML(DataTable(makeData()).render())
        let without = renderHTML(
            DataTable(makeData(hasRowNumbers: false)).render()
        )
        #expect(with.contains("rowNumber(index)"))
        #expect(!without.contains("rowNumber(index)"))
    }

    @Test("reuses TablePaginator in alpine mode and honours hasPagination")
    func pagination() {
        let with = renderHTML(DataTable(makeData()).render())
        let without = renderHTML(
            DataTable(makeData(hasPagination: false)).render()
        )
        #expect(with.contains("goToPage(1)"))
        #expect(with.contains("changePageSize"))
        #expect(!without.contains("goToPage(1)"))
    }

    @Test("renders filter controls through existing components with unique ids")
    func filterControls() {
        let html = renderHTML(DataTable(makeData()).render())
        #expect(html.contains("id=\"facts-filters\""))
        #expect(html.contains("id=\"facts-filter-name\""))
        #expect(html.contains("id=\"facts-filter-weight\""))
        #expect(html.contains("type=\"number\""))
        #expect(html.contains("id=\"facts-filter-habitat\""))
        #expect(html.contains("dropdown({ selectedValue: ''"))
        #expect(html.contains("id=\"facts-filter-nocturnal\""))
        #expect(html.contains("type=\"checkbox\""))
        // dateRange reuses the range DatePicker, without a preselected date
        #expect(html.contains("id=\"facts-filter-described-popup\""))
        #expect(html.contains("name=\"facts-filter-described-end\""))
        #expect(html.contains("isRange: true, isEmpty: true"))
        #expect(html.contains("@dropdown-change=\"onFilterControl($event)\""))
        #expect(html.contains("@datepicker-change=\"onFilterControl($event)\""))
        #expect(html.contains("aria-controls=\"facts-filters\""))
        #expect(html.contains(":aria-expanded=\"filterPanelOpen\""))
    }

    @Test("filter wrappers expose the state names that data-table.js writes to")
    func filterContract() {
        // data-table.js sets `selectedValue`/`selectedTitle` (Dropdown) and `value` (InputField)
        let html = renderHTML(DataTable(makeData()).render())
        #expect(html.contains("data-filter-field=\"name\""))
        #expect(html.contains("data-filter-kind=\"input\""))
        #expect(html.contains("data-filter-kind=\"dropdown\""))
        #expect(html.contains("data-filter-kind=\"check\""))
        #expect(html.contains("datePickerWidget("))
        #expect(html.contains("x-model=\"value\""))
        #expect(html.contains("x-text=\"selectedTitle\""))
        #expect(html.contains("dispatch") || html.contains("select('"))
    }

    @Test("a single date filter reuses the DatePicker with range off")
    func singleDateFilter() throws {
        let data = makeData(columns: [
            DataTableColumn(
                key: "surveyed",
                label: "Surveyed",
                filter: DataTableFilter(kind: .date)
            )
        ])
        let html = renderHTML(DataTable(data).render())
        #expect(html.contains("isRange: false, isEmpty: true"))
        #expect(!html.contains("name=\"facts-filter-surveyed-end\""))
        #expect(html.contains("data-filter-kind=\"datepicker\""))
        let columns = try #require(decodedConfig(html)["columns"] as? [[String: Any]])
        let filter = try #require(columns[0]["filter"] as? [String: Any])
        #expect(filter["kind"] as? String == "date")
        #expect(filter["operator"] as? String == "eq")
    }

    @Test("date pickers are bounded to the configured years")
    func dateYearBounds() {
        let data = makeData(columns: [
            DataTableColumn(
                key: "described",
                label: "Described",
                filter: DataTableFilter(
                    kind: .dateRange,
                    minYear: 1898,
                    maxYear: 1941
                )
            )
        ])
        let html = renderHTML(DataTable(data).render())
        #expect(html.contains("minYear: 1898, maxYear: 1941"))
        let unbounded = renderHTML(DataTable(makeData()).render())
        #expect(unbounded.contains("minYear: null, maxYear: null"))
    }

    @Test("date range filters always use between")
    func dateRangeOperator() throws {
        let filter = DataTableFilter(kind: .dateRange)
        #expect(filter.operator == .between)
        #expect(filter.dateFormat == .DD_MM_YYYY)
    }

    @Test("renders filter mode selector only when enabled")
    func filterMode() {
        let off = renderHTML(DataTable(makeData()).render())
        let on = renderHTML(DataTable(makeData(hasFilterMode: true)).render())
        #expect(!off.contains("facts-filter-mode"))
        #expect(on.contains("facts-filter-mode"))
    }

    @Test("renders no filter UI without filterable columns")
    func noFilters() {
        let html = renderHTML(
            DataTable(
                makeData(columns: [DataTableColumn(key: "a", label: "A")])
            )
            .render()
        )
        #expect(!html.contains("facts-filters"))
        #expect(!html.contains("removeFilter(chip.key)"))
    }

    @Test("renders filter chips with the MultiSelect selected-option styling")
    func chips() {
        let html = renderHTML(DataTable(makeData()).render())
        #expect(html.contains("removeFilter(chip.key)"))
        #expect(html.contains(":aria-label=\"chip.removeLabel\""))
        #expect(html.contains(MultiSelectStyles.optionSelected))
    }

    @Test("column configurator is rendered only when enabled")
    func configurator() {
        let on = renderHTML(DataTable(makeData()).render())
        let off = renderHTML(
            DataTable(makeData(hasColumnConfigurator: false)).render()
        )
        #expect(on.contains("openColumnModal()"))
        #expect(on.contains("data-column-popover"))
        #expect(!off.contains("openColumnModal()"))
    }

    @Test("renders cell templates per type")
    func cells() {
        let html = renderHTML(DataTable(makeData()).render())
        #expect(html.contains("cellText(row, col)"))
        #expect(html.contains("x-html=\"row[col.key + '_html'] || ''\""))
        #expect(html.contains("col.key === 'nocturnal'"))
        #expect(html.contains("row['nocturnal'] ? 'Yes' : 'No'"))
        #expect(html.contains("col.key === 'actions'"))
        // Attribute values are entity-escaped; the browser decodes them before Alpine reads them
        #expect(html.contains("alert(row.name + &#39; clicked&#39;)"))
        #expect(
            html.contains(":aria-label=\"&#39;Details for &#39; + row.name\"")
        )
        #expect(html.contains("x-if=\"row.canEdit\""))
    }

    @Test("empty values are explained for screen readers")
    func emptyValues() {
        let html = renderHTML(DataTable(makeData()).render())
        #expect(html.contains("isEmpty(row, col)"))
        #expect(html.contains("<span class=\"sr-only\">No data</span>"))
    }

    @Test("renders loading skeleton and empty state")
    func states() {
        let html = renderHTML(DataTable(makeData()).render())
        #expect(html.contains("skeletonRows"))
        #expect(html.contains("motion-reduce:animate-none"))
        #expect(html.contains("x-text=\"emptyText\""))
        #expect(html.contains("clearFilters()"))
    }

    @Test("client config round-trips through base64 JSON")
    func clientConfig() throws {
        let html = renderHTML(DataTable(makeData()).render())
        let config = try decodedConfig(html)
        #expect(config["id"] as? String == "facts")
        #expect(config["hasPagination"] as? Bool == true)
        #expect(config["filterTrigger"] as? String == "mixed")
        let columns = try #require(config["columns"] as? [[String: Any]])
        #expect(columns.count == 6)
        #expect(columns[0]["sortable"] as? Bool == true)
        let weight = try #require(columns[1]["filter"] as? [String: Any])
        #expect(weight["operator"] as? String == "lte")
        #expect(weight["kind"] as? String == "double")
        let endpoint = try #require(config["endpoint"] as? [String: Any])
        #expect(endpoint["method"] as? String == "POST")
        #expect(endpoint["filterParam"] as? String == "filter[{key}][{op}]")
    }

    @Test("config with quotes and non-ASCII text cannot break the attribute")
    func unsafeText() throws {
        let data = DataTableData(
            id: "t",
            endpoint: DataTableEndpoint(url: "/data"),
            caption: "Rock \"n\" roll – Café <b>",
            columns: [DataTableColumn(key: "a", label: "Größe \"x\"")]
        )
        let html = renderHTML(DataTable(data).render())
        let config = try decodedConfig(html)
        let columns = try #require(config["columns"] as? [[String: Any]])
        #expect(columns[0]["label"] as? String == "Größe \"x\"")
        #expect(!html.contains("aria-label=\"Rock \"n\""))
    }

    @Test("loads the SimpleTable factory and the DataTable factory")
    func scripts() {
        let html = renderHTML(DataTable(makeData()).render())
        #expect(html.contains("/js/simple-table.js"))
        #expect(html.contains("/js/data-table.js"))
        #expect(html.contains("x-data=\"dataTable(dataTableConfig('"))
    }
}
