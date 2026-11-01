import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct DataTableView: TemplateRepresentable {

    let hasFailure: Bool

    private var data: DataTableData {
        let described = RaccoonFacts.years(of: \.first_described)
        let surveyed = RaccoonFacts.years(of: \.last_surveyed)
        return DataTableData(
            id: "raccoon-facts",
            endpoint: DataTableEndpoint(
                url: "/simulation/raccoons",
                method: .get
            ),
            caption: "Raccoon facts (illustrative sample data)",
            columns: [
                DataTableColumn(
                    key: "name",
                    label: "Name",
                    filter: DataTableFilter(
                        placeholder: "Contains",
                        kind: .text
                    ),
                    hasSorting: true,
                    isHideable: false
                ),
                DataTableColumn(
                    key: "range",
                    label: "Range",
                    filter: DataTableFilter(kind: .text),
                    hasSorting: true
                ),
                DataTableColumn(
                    key: "description",
                    label: "Description",
                    cellType: .markdown,
                    isVisibleByDefault: false
                ),
                DataTableColumn(
                    key: "habitat",
                    label: "Habitat",
                    filter: DataTableFilter(
                        kind: .enumeration(
                            RaccoonFacts.habitats.map {
                                DataTableFilterOption(title: $0, value: $0)
                            }
                        )
                    ),
                    hasSorting: true
                ),
                DataTableColumn(
                    key: "body_length_cm",
                    label: "Body length (cm)",
                    cellType: .integer,
                    filter: DataTableFilter(
                        label: "Body length at least (cm)",
                        kind: .integer,
                        operator: .gte
                    ),
                    hasSorting: true
                ),
                DataTableColumn(
                    key: "weight_kg",
                    label: "Weight (kg)",
                    cellType: .double,
                    filter: DataTableFilter(
                        label: "Weight at most (kg)",
                        kind: .double,
                        operator: .lte
                    ),
                    hasSorting: true
                ),
                DataTableColumn(
                    key: "first_described",
                    label: "First described",
                    filter: DataTableFilter(
                        kind: .dateRange,
                        minYear: described.lowerBound,
                        maxYear: described.upperBound
                    ),
                    hasSorting: true
                ),
                DataTableColumn(
                    key: "last_surveyed",
                    label: "Last surveyed",
                    filter: DataTableFilter(
                        kind: .date,
                        minYear: surveyed.lowerBound,
                        maxYear: surveyed.upperBound
                    ),
                    hasSorting: true
                ),
                DataTableColumn(
                    key: "nocturnal",
                    label: "Nocturnal",
                    cellType: .custom(.yesNo(key: "nocturnal")),
                    filter: DataTableFilter(kind: .boolean(.check)),
                    hasSorting: true
                ),
                DataTableColumn(
                    key: "status",
                    label: "Conservation status",
                    cellType: .custom(.badge(key: "status")),
                    filter: DataTableFilter(
                        kind: .enumeration(
                            RaccoonFacts.statuses.map {
                                DataTableFilterOption(title: $0, value: $0)
                            }
                        )
                    ),
                    hasSorting: true
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
                            buttonType: .secondary
                        )
                    ]),
                    isHideable: false
                ),
            ],
            fixedQuery: hasFailure ? ["fail": "1"] : [:],
            defaultSort: DataTableSort(key: "name"),
            search: DataTableSearch(
                label: "Search raccoons",
                placeholder: "Search by name or range (min. 3 characters)…"
            ),
            hasFilterMode: true
        )
    }

    @Builder<Element>
    func render() -> [Element] {
        Basic(title: "DataTable") {
            Div {
                showComponentTitle("DataTable")

                P {
                    "Rows are loaded from /simulation/raccoons, which answers after half a second. Sorting, filtering and paging run in that endpoint. "
                    A("Simulate an error")
                        .href("/preview/data-table?fail=1")
                        .class("underline")
                    " · "
                    A("Back to normal")
                        .href("/preview/data-table")
                        .class("underline")
                }

                Div { DataTable(data).render() }
                    .class("mb-4")
            }
            .class("mt-4 space-y-6")
        }
        .render()
    }
}
