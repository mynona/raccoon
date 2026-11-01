import HTML
import SGML
import SVG
import WebBuilders

/// Table for API driven data. Sorting, filtering and pagination run on the backend.
///
/// The server renders the shell (toolbar, filters, table frame, paginator). The browser loads the rows from
/// `DataTableEndpoint` through the Alpine factory in `/js/data-table.js`, which composes the `datatable()`
/// factory of `SimpleTable` for the column configurator. For static data use `SimpleTable`.
public struct DataTable: TemplateRepresentable {

    let data: DataTableData
    typealias styles = DataTableStyles
    typealias tableStyles = TableStyles

    /// Creates a new `DataTable`.
    ///
    /// - Parameter data: Configuration of the table.
    public init(_ data: DataTableData) {
        self.data = data
    }

    private var hasFilters: Bool {
        data.columns.contains { $0.hasFiltering }
    }

    private func js(_ value: String) -> String {
        JavaScriptEscaper.escapeSingleQuotedString(value)
    }

    func attribute(_ value: String) -> String {
        JavaScriptEscaper.htmlAttributeEscape(value)
    }

    // MARK: - Search

    @Builder<Element>
    private func searchField(_ search: DataTableSearch) -> [Element] {
        Div {
            SearchField(
                SearchFieldData(
                    id: "\(data.id)-search",
                    name: "\(data.id)-search",
                    bindModel: "searchTerm",
                    bindRef: "searchInput",
                    bindKeyup: "onSearchInput()",
                    bindClearAction: "clearSearch()",
                    placeholder: LocalizedText(verbatim: search.placeholder),
                    ariaLabel: LocalizedText(verbatim: search.label),
                    clearAriaLabel: LocalizedText(verbatim: search.clearLabel),
                    loadingBind: "isLoading"
                )
            )
            .render()
        }
        .class("pb-4")
        .setAttribute(name: "role", value: "search")
    }

    // MARK: - Toolbar

    @Builder<Element>
    private func filterToggle() -> [Element] {
        Button {
            Div {
                Svg.icon(.funnel, width: 20, height: 20)
                Span(data.labels.filters)
                Span {}
                    .class(styles.filterCount)
                    .setAttribute(
                        name: "x-show",
                        value: "activeFilterCount > 0"
                    )
                    .setAttribute(name: "x-text", value: "activeFilterCount")
            }
            .class(styles.filterToggleContent)
        }
        .type(.button)
        .class(styles.iconButton)
        .setAttribute(name: "x-ref", value: "filterToggle")
        .setAttribute(
            name: "@click",
            value: "filterPanelOpen = !filterPanelOpen"
        )
        .setAttribute(name: ":aria-expanded", value: "filterPanelOpen")
        .setAttribute(name: "aria-controls", value: "\(data.id)-filters")
        .setAttribute(name: ":aria-label", value: "filterToggleLabel")
    }

    @Builder<Element>
    private func clearAllButton() -> [Element] {
        Button {
            Svg.icon(.x_lg, width: 16, height: 16)
            Span(data.labels.clearAll)
        }
        .type(.button)
        .class(styles.iconButton)
        .addClass(styles.clearAllButton)
        .setAttribute(name: "x-show", value: "activeFilterCount > 0")
        .setAttribute(name: "@click", value: "clearFilters()")
    }

    @Builder<Element>
    private func columnConfigurator() -> [Element] {
        Div {
            Button {
                Svg.icon(.layout_three_columns)
                    .class("w-5 h-5")
            }
            .type(.button)
            .class(styles.iconButton)
            .setAttribute(name: "x-show", value: "hasColumnConfigurator")
            .setAttribute(name: "@click", value: "openColumnModal()")
            .setAttribute(name: "aria-label", value: "Select visible columns")
            .setAttribute(name: "data-column-trigger", value: "")

            simpleTableColumnConfigurator(caption: data.caption)
        }
        .class("relative")
    }

    @Builder<Element>
    private func toolbar() -> [Element] {
        Div {
            P(data.caption)
                .class("text-left border-none")
                .addClass(tableStyles.captionTextFont)
                .addClass(tableStyles.captionTextColor)
                .addClass(tableStyles.captionTextSize)
                .ariaHidden("true")

            Div {
                if hasFilters {
                    clearAllButton()
                    filterToggle()
                }
                if data.hasColumnConfigurator {
                    columnConfigurator()
                }
            }
            .class(styles.toolbarActions)
        }
        .class(styles.toolbar)
    }

    // MARK: - Filters

    @Builder<Element>
    private func chips() -> [Element] {
        Div {
            Template {
                Button {
                    Span {}
                        .setAttribute(name: "x-text", value: "chip.text")
                    Span {
                        Svg.icon(.x_lg, width: 12, height: 12)
                    }
                    .class(styles.chipIcon)
                    .setAttribute(name: "aria-hidden", value: "true")
                }
                .type(.button)
                .class(styles.chip)
                .setAttribute(name: "@click", value: "removeFilter(chip.key)")
                .setAttribute(name: ":aria-label", value: "chip.removeLabel")
            }
            .setAttribute(name: "x-for", value: "chip in chips")
            .setAttribute(name: ":key", value: "chip.key")
        }
        .class(styles.chipList)
        .setAttribute(name: "x-show", value: "activeFilterCount > 0")
    }

    private func filterField(
        id: String,
        key: String,
        kind: String,
        @Builder<Element> content: () -> [Element]
    ) -> Element {
        Div {
            content()
        }
        .setAttribute(name: "data-filter-field", value: id)
        .setAttribute(name: "data-filter-key", value: attribute(key))
        .setAttribute(name: "data-filter-kind", value: kind)
    }

    private func label(_ id: String, _ title: String) -> LabelData {
        LabelData(
            id: id,
            title: LocalizedText(verbatim: title),
            isRequired: false
        )
    }

    private func dropdownOptions(
        _ options: [DataTableFilterOption]
    ) -> [OptionValue] {
        [OptionValue(title: LocalizedText(verbatim: data.labels.all), value: "")]
            + options.map { OptionValue(title: LocalizedText(verbatim: $0.title), value: $0.value) }
    }

    @Builder<Element>
    private func filterControl(_ column: DataTableColumn) -> [Element] {
        if column.hasFiltering, let filter = column.filter {
            let title = filter.label ?? column.label
            let controlId = "\(data.id)-filter-\(column.key)"

            switch filter.kind {
            case .text, .integer, .double:
                let type: HTML.Input.Types =
                    if case .text = filter.kind { .text }
                    else { .number }
                filterField(
                    id: column.key,
                    key: column.key,
                    kind: "input"
                ) {
                    InputField(
                        InputFieldData(
                            id: controlId,
                            label: label(controlId, title),
                            placeholder: filter.placeholder.map(
                                LocalizedText.init(verbatim:)
                            ),
                            type: type
                        )
                    )
                    .render()
                }
            case .enumeration(let options):
                filterField(
                    id: column.key,
                    key: column.key,
                    kind: "dropdown"
                ) {
                    Dropdown(
                        DropdownData(
                            id: controlId,
                            label: label(controlId, title),
                            value: "",
                            options: dropdownOptions(options)
                        )
                    )
                    .render()
                }
            case .boolean(.dropdown):
                filterField(
                    id: column.key,
                    key: column.key,
                    kind: "dropdown"
                ) {
                    Dropdown(
                        DropdownData(
                            id: controlId,
                            label: label(controlId, title),
                            value: "",
                            options: dropdownOptions([
                                DataTableFilterOption(
                                    title: data.labels.yes,
                                    value: "true"
                                ),
                                DataTableFilterOption(
                                    title: data.labels.no,
                                    value: "false"
                                ),
                            ])
                        )
                    )
                    .render()
                }
            case .boolean(.check):
                filterField(
                    id: column.key,
                    key: column.key,
                    kind: "check"
                ) {
                    Check(
                        CheckData(
                            id: controlId,
                            label: LocalizedText(verbatim: title)
                        )
                    )
                    .render()
                }
            case .date:
                filterField(
                    id: column.key,
                    key: column.key,
                    kind: "datepicker"
                ) {
                    DatePicker(
                        DatePickerData(
                            id: controlId,
                            label: label(controlId, title),
                            format: filter.dateFormat,
                            minYear: filter.minYear,
                            maxYear: filter.maxYear
                        )
                    )
                    .render()
                }
            case .dateRange:
                filterField(
                    id: column.key,
                    key: column.key,
                    kind: "datepicker"
                ) {
                    DatePicker(
                        DatePickerData(
                            id: controlId,
                            endId: "\(controlId)-end",
                            label: label(controlId, title),
                            format: filter.dateFormat,
                            minYear: filter.minYear,
                            maxYear: filter.maxYear,
                            isRange: true
                        )
                    )
                    .render()
                }
            }
        }
    }

    @Builder<Element>
    private func filterModeControl() -> [Element] {
        if data.hasFilterMode {
            filterField(id: "__mode", key: "__mode", kind: "dropdown") {
                Dropdown(
                    DropdownData(
                        id: "\(data.id)-filter-mode",
                        label: label(
                            "\(data.id)-filter-mode",
                            data.labels.filterMode
                        ),
                        value: "and",
                        options: [
                            OptionValue(
                                title: LocalizedText(verbatim: data.labels.filterModeAnd),
                                value: "and"
                            ),
                            OptionValue(
                                title: LocalizedText(verbatim: data.labels.filterModeOr),
                                value: "or"
                            ),
                        ]
                    )
                )
                .render()
            }
        }
    }

    @Builder<Element>
    private func filterPanel() -> [Element] {
        Div {
            for column in data.columns {
                filterControl(column)
            }
            filterModeControl()

            Div {
                ActionButton(
                    ActionButtonData(
                        id: "\(data.id)-apply",
                        clickAction: "applyFilters()",
                        label: LocalizedText(verbatim: data.labels.apply),
                        htmlType: .button,
                        buttonType: .primary,
                        contentTracker: MatomoContentTracker(
                            name: "data-table",
                            piece: "filter.apply",
                            target: data.id
                        )
                    )
                )
                .render()
            }
            .class(styles.filterPanelActions)
            .setAttribute(name: "x-show", value: "hasPendingFilters")
        }
        .id("\(data.id)-filters")
        .class(styles.filterPanel)
        .setAttribute(name: "role", value: "group")
        .setAttribute(name: "aria-label", value: attribute(data.labels.filters))
        .setAttribute(name: "x-show", value: "filterPanelOpen")
        .setAttribute(name: "@input", value: "onFilterControl($event)")
        .setAttribute(name: "@change", value: "onFilterControl($event)")
        .setAttribute(
            name: "@dropdown-change",
            value: "onFilterControl($event)"
        )
        .setAttribute(
            name: "@datepicker-change",
            value: "onFilterControl($event)"
        )
        .setAttribute(name: "@keydown.enter", value: "onFilterEnter($event)")
    }

    // MARK: - Cells

    private func tracked<T: SGML.Attributes & SGML.Mutable>(
        _ element: T,
        action: DataTableAction
    ) -> T {
        guard let tracker = action.contentTracker,
            data.matomoStatus == .ACCEPTED || data.matomoStatus == .BANNER
        else { return element }
        return
            element
            .flagAttribute("data-track-content")
            .setAttribute(
                name: "data-content-name",
                value: attribute(tracker.name)
            )
            .setAttribute(
                name: "data-content-piece",
                value: attribute(tracker.piece)
            )
            .setAttribute(
                name: ":data-content-target",
                value:
                    "tableTemplate(row, '\(attribute(js(tracker.target)))')"
            )
    }

    private func buttonClass(_ type: ActionButtonType) -> String {
        let variant =
            switch type {
            case .primary: styles.primaryButton
            case .secondary: styles.secondaryButton
            case .tertiary: styles.tertiaryButton
            case .warning: styles.warningButton
            case .icon: styles.iconButton
            }
        return "flex items-center justify-center rounded-md w-fit " + variant
    }

    @Builder<Element>
    private func actionContent(_ action: DataTableAction) -> [Element] {
        if let icon = action.icon {
            Span {
                Svg.icon(icon, width: 16, height: 16)
            }
            .setAttribute(name: "aria-hidden", value: "true")
        }
        if let label = action.label {
            Span(label)
        }
    }

    @Builder<Element>
    private func actionElement(_ action: DataTableAction) -> [Element] {
        if let href = action.href {
            let link =
                A {
                    actionContent(action)
                }
                .class(buttonClass(action.buttonType))
                .setAttribute(
                    name: ":href",
                    value: "tableHref(row, '\(attribute(js(href)))')"
                )
                .if(action.clickAction != nil) {
                    $0.setAttribute(
                        name: "@click",
                        value: attribute(action.clickAction ?? "")
                    )
                }
            ariaName(link, action)
        }
        else {
            let button =
                Button {
                    actionContent(action)
                }
                .type(.button)
                .class(buttonClass(action.buttonType))
                .if(action.clickAction != nil) {
                    $0.setAttribute(
                        name: "@click",
                        value: attribute(action.clickAction ?? "")
                    )
                }
            ariaName(button, action)
        }
    }

    private func ariaName<T: SGML.Attributes & SGML.Mutable & Element>(
        _ element: T,
        _ action: DataTableAction
    ) -> Element {
        var result = tracked(element, action: action)
        if let bound = action.bindAriaLabel {
            result = result.setAttribute(
                name: ":aria-label",
                value: attribute(bound)
            )
        }
        else if let label = action.ariaLabel {
            result = result.setAttribute(
                name: "aria-label",
                value: attribute(label)
            )
        }
        return result
    }

    @Builder<Element>
    private func actionsCell(_ actions: [DataTableAction]) -> [Element] {
        Div {
            for action in actions {
                if let visibleWhen = action.visibleWhen {
                    Template {
                        actionElement(action)
                    }
                    .setAttribute(
                        name: "x-if",
                        value: attribute(visibleWhen)
                    )
                }
                else {
                    actionElement(action)
                }
            }
        }
        .class(styles.actionList)
    }

    @Builder<Element>
    private func cellBody(_ column: DataTableColumn) -> [Element] {
        switch column.cellType {
        case .actions(let actions):
            Template {
                actionsCell(actions)
            }
            .setAttribute(
                name: "x-if",
                value: "col.key === '\(attribute(js(column.key)))'"
            )
        case .custom(let template):
            Template {
                Div {
                    template.build()
                }
            }
            .setAttribute(
                name: "x-if",
                value: "col.key === '\(attribute(js(column.key)))'"
            )
        default:
            []
        }
    }

    @Builder<Element>
    private func dataRow() -> [Element] {
        Tr {
            if data.hasRowNumbers {
                Td {}
                    .class(styles.rowNumber)
                    .setAttribute(name: "x-text", value: "rowNumber(index)")
            }
            Template {
                Td {
                    Template {
                        Span {
                            Span {}
                                .setAttribute(
                                    name: "x-show",
                                    value: "!isEmpty(row, col)"
                                )
                                .setAttribute(
                                    name: "x-text",
                                    value: "cellText(row, col)"
                                )
                            Span {
                                Span("—")
                                    .setAttribute(
                                        name: "aria-hidden",
                                        value: "true"
                                    )
                                Span(data.labels.emptyValue)
                                    .class("sr-only")
                            }
                            .setAttribute(
                                name: "x-show",
                                value: "isEmpty(row, col)"
                            )
                        }
                    }
                    .setAttribute(
                        name: "x-if",
                        value:
                            "['text', 'integer', 'double'].includes(col.type)"
                    )

                    Template {
                        Div {}
                            .setAttribute(
                                name: "x-html",
                                value: "row[col.key + '_html'] || ''"
                            )
                    }
                    .setAttribute(
                        name: "x-if",
                        value: "col.type === 'markdown'"
                    )

                    for column in data.columns {
                        cellBody(column)
                    }
                }
                .class(tableStyles.tdBodyPadding)
                .addClass(tableStyles.tdBodyTextFont)
                .addClass(tableStyles.tdBodyTextSize)
                .addClass(tableStyles.tdBodyTextColor)
                .setAttribute(
                    name: ":class",
                    value: alignBinding(numeric: true)
                )
            }
            .setAttribute(name: "x-for", value: "col in activeColumns")
            .setAttribute(name: ":key", value: "col.key")
        }
        .addClass(tableStyles.trBodyAlternatingRows)
        .addClass(tableStyles.trBodyHoverBorder)
    }

    @Builder<Element>
    private func skeletonRow() -> [Element] {
        Tr {
            if data.hasRowNumbers {
                Td {
                    Span {}.class(styles.skeletonCell)
                }
                .class(tableStyles.tdBodyPadding)
            }
            Template {
                Td {
                    Span {}.class(styles.skeletonCell)
                }
                .class(tableStyles.tdBodyPadding)
            }
            .setAttribute(name: "x-for", value: "col in activeColumns")
            .setAttribute(name: ":key", value: "col.key")
        }
        .setAttribute(name: "aria-hidden", value: "true")
        .addClass(tableStyles.trBodyAlternatingRows)
    }

    /// Class object for Alpine `:class`. Literal class names live here so the Tailwind scan finds them.
    private func alignBinding(numeric: Bool = false) -> String {
        var entries = [
            "'\(styles.alignRight)': col.align === 'right'",
            "'\(styles.alignCenter)': col.align === 'center'",
            "'\(styles.alignLeft)': col.align === 'left'",
        ]
        if numeric {
            entries.append(
                "'\(styles.numeric)': col.type === 'integer' || col.type === 'double'"
            )
        }
        return "{ \(entries.joined(separator: ", ")) }"
    }

    // MARK: - Table

    @Builder<Element>
    private func headerCell() -> [Element] {
        Th {
            Template {
                Button {
                    Span {}
                        .setAttribute(name: "x-text", value: "col.label")
                    Svg.icon(.sort_up, width: 16, height: 16)
                        .setAttribute(
                            name: "x-show",
                            value:
                                "sortKey === col.key && sortDirection === 'asc'"
                        )
                    Svg.icon(.sort_down, width: 16, height: 16)
                        .setAttribute(
                            name: "x-show",
                            value:
                                "sortKey === col.key && sortDirection === 'desc'"
                        )
                }
                .type(.button)
                .class(styles.sortButton)
                .setAttribute(name: "@click", value: "sort(col.key)")
                .setAttribute(name: ":class", value: alignBinding())
            }
            .setAttribute(name: "x-if", value: "col.sortable")

            Template {
                Span {}
                    .setAttribute(name: "x-text", value: "col.label")
            }
            .setAttribute(name: "x-if", value: "!col.sortable")
        }
        .setAttribute(name: "scope", value: "col")
        .setAttribute(name: ":aria-sort", value: "ariaSort(col)")
        .class("select-none")
        .addClass(tableStyles.thPadding)
        .addClass(tableStyles.thTextFont)
        .addClass(tableStyles.thTextSize)
        .addClass(tableStyles.thTextColor)
        .setAttribute(name: ":class", value: alignBinding())
    }

    @Builder<Element>
    private func table() -> [Element] {
        Table {
            Caption(data.caption).class("sr-only")

            Thead {
                Tr {
                    if data.hasRowNumbers {
                        Th(data.labels.rowNumberHeader)
                            .setAttribute(name: "scope", value: "col")
                            .class("text-left")
                            .addClass(tableStyles.thPadding)
                            .addClass(tableStyles.thTextFont)
                            .addClass(tableStyles.thTextSize)
                            .addClass(tableStyles.thTextColor)
                    }
                    Template {
                        headerCell()
                    }
                    .setAttribute(name: "x-for", value: "col in activeColumns")
                    .setAttribute(name: ":key", value: "col.key")
                }
            }
            .class(tableStyles.theadBackgroundColor)

            Tbody {
                Template {
                    skeletonRow()
                }
                .setAttribute(
                    name: "x-for",
                    value: "n in (status === 'loading' ? skeletonRows : [])"
                )
                .setAttribute(name: ":key", value: "n")

                Template {
                    dataRow()
                }
                .setAttribute(
                    name: "x-for",
                    value: "(row, index) in (status === 'loading' ? [] : rows)"
                )
                .setAttribute(name: ":key", value: "row.id ?? index")

                Tr {
                    Td {
                        Div {
                            Svg.icon(.info_circle)
                                .class("w-5 h-5")
                                .setAttribute(
                                    name: "aria-hidden",
                                    value: "true"
                                )
                            P {}
                                .setAttribute(
                                    name: "x-text",
                                    value: "emptyText"
                                )
                            Button(data.labels.clearAll)
                                .type(.button)
                                .class(styles.linkButton)
                                .setAttribute(
                                    name: "x-show",
                                    value: "activeFilterCount > 0"
                                )
                                .setAttribute(
                                    name: "@click",
                                    value: "clearFilters()"
                                )
                        }
                        .class(styles.emptyState)
                    }
                    .setAttribute(name: ":colspan", value: "columnCount")
                }
                .setAttribute(
                    name: "x-show",
                    value: "status === 'ready' && rows.length === 0"
                )

                Tr {
                    Td {
                        Div {
                            Svg.icon(.info_circle)
                                .class("w-5 h-5")
                                .setAttribute(
                                    name: "aria-hidden",
                                    value: "true"
                                )
                            P {}
                                .setAttribute(
                                    name: "x-text",
                                    value: "searchHint"
                                )
                        }
                        .class(styles.emptyState)
                    }
                    .setAttribute(name: ":colspan", value: "columnCount")
                }
                .setAttribute(name: "x-show", value: "status === 'idle'")
            }
        }
        .class(styles.table)
        .setAttribute(name: ":aria-busy", value: "status === 'loading'")
    }

    @Builder<Element>
    private func errorBanner() -> [Element] {
        Div {
            Span(data.labels.error)
            Button(data.labels.retry)
                .type(.button)
                .class(styles.linkButton)
                .setAttribute(name: "@click", value: "load()")
        }
        .class(styles.errorBanner)
        .setAttribute(name: "role", value: "alert")
        .setAttribute(name: "x-show", value: "status === 'error'")
    }

    @Builder<Element>
    private func paginator() -> [Element] {
        if data.hasPagination {
            TablePaginator(
                TablePaginatorData(
                    selectId: "\(data.id)-per",
                    selectName: "\(data.id)-per",
                    bindShow: "total > 0",
                    pageSizeOptions: data.pageSizeOptions
                )
            )
            .render()
        }
    }

    // MARK: - Render

    @Builder<Element>
    public func render() -> [Element] {
        DebugComment("Data table")
        Div {
            if let search = data.search {
                searchField(search)
            }

            toolbar()

            if hasFilters {
                filterPanel()
                chips()
            }

            errorBanner()

            Div {
                table()
            }
            .class(styles.scrollRegion)
            .setAttribute(name: "role", value: "region")
            .setAttribute(name: "aria-label", value: attribute(data.caption))
            .setAttribute(name: "tabindex", value: "0")
            .setAttribute(name: ":style", value: "minHeightStyle")

            Div {}
                .class("sr-only")
                .setAttribute(name: "role", value: "status")
                .setAttribute(name: "aria-atomic", value: "true")
                .setAttribute(name: "x-text", value: "announcement")

            paginator()
        }
        .id(data.id)
        .class(styles.root)
        .setAttribute(
            name: "x-data",
            value:
                "dataTable(dataTableConfig('\(DataTableClientConfig(data).encoded())'))"
        )

        Script()
            .src("/js/simple-table.js")
            .setAttribute(name: "type", value: "text/javascript")
        Script()
            .src("/js/data-table.js")
            .setAttribute(name: "type", value: "text/javascript")
    }
}
