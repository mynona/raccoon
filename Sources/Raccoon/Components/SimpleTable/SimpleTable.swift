import HTML
import SGML
import SVG
import WebBuilders

/// The built-in texts of `SimpleTable` and its column configurator.
enum SimpleTableTexts {
    static let copied = LocalizedText("simpletable.copied", "Copied")
    static let copyTable = LocalizedText(
        "simpletable.copyTable",
        "Copy table"
    )
    static let toggleFilter = LocalizedText(
        "simpletable.toggleFilter",
        "Toggle filter"
    )
    static let selectColumns = LocalizedText(
        "simpletable.selectColumns",
        "Select visible columns"
    )
    static let searchRows = LocalizedText(
        "simpletable.searchRows",
        "Search table rows"
    )
    static let clearFilter = LocalizedText(
        "simpletable.clearFilter",
        "Clear filter"
    )
    static let noResults = LocalizedText(
        "simpletable.noResults",
        "No results found"
    )
    static let configure = LocalizedText(
        "simpletable.configure",
        "Configure columns"
    )
    static let closeConfigurator = LocalizedText(
        "simpletable.closeConfigurator",
        "Close column configurator"
    )
    static let reorderColumn = LocalizedText(
        "simpletable.reorderColumn",
        "Reorder column"
    )
    static let resetAll = LocalizedText(
        "simpletable.resetAll",
        "Reset all settings"
    )
    static let resetColumns = LocalizedText(
        "simpletable.resetColumns",
        "Reset column settings"
    )
    static let cancel = LocalizedText("simpletable.cancel", "Cancel")
    static let cancelChanges = LocalizedText(
        "simpletable.cancelChanges",
        "Cancel column changes"
    )
    static let save = LocalizedText("simpletable.save", "Save")
    static let applyChanges = LocalizedText(
        "simpletable.applyChanges",
        "Apply column changes"
    )

    /// Announcements that `simple-table.js` makes. The script asks the i18n store for them, so they are
    /// recorded when the table renders to land in the page dictionary.
    static let scriptTexts: [LocalizedText] = [
        LocalizedText("simpletable.dropped", "Dropped {{key}}."),
        LocalizedText(
            "simpletable.pickedUp",
            "Picked up {{key}}. Use arrow keys to move."
        ),
        LocalizedText(
            "simpletable.cancelled",
            "Cancelled reordering {{key}}."
        ),
        LocalizedText(
            "simpletable.moved",
            "Moved {{key}} to position {{position}}."
        ),
        LocalizedText(
            "simpletable.movedFirst",
            "Moved {{key}} to the first position."
        ),
        LocalizedText(
            "simpletable.movedLast",
            "Moved {{key}} to the last position."
        ),
    ]

    static func recordScriptTexts() {
        for text in scriptTexts { text.recordUse() }
    }
}

public struct SimpleTable: TemplateRepresentable {
    let data: SimpleTableData
    typealias styles = SimpleTableStyles
    typealias buttonStyles = ActionButtonStyles
    typealias tableStyles = TableStyles

    public init(
        _ data: SimpleTableData
    ) {
        self.data = data
    }

    // MARK: - Title + Actions
    @Builder<Element>
    func titleWithActionButtons() -> [Element] {
        Div {
            Div {

                if let caption = data.caption {
                    P(caption.resolved)
                        .localized(caption)
                        .class("text-left border-none")
                        .addClass(tableStyles.captionTextFont)
                        .addClass(tableStyles.captionTextColor)
                        .addClass(tableStyles.captionTextSize)
                        .ariaHidden("true")
                }

                Div {

                    // Copy button
                    Button {
                        Div {
                            Span {
                                Svg.icon(.copy)
                            }
                            .setAttribute(
                                name: "x-show",
                                value: "!copied"
                            )
                            .class("w-5 h-5")

                            Span {
                                Svg.icon(.check_circle)
                            }
                            .setAttribute(
                                name: "x-show",
                                value: "copied"
                            )
                            .class("w-5 h-5")
                        }

                        Div {
                            Span(SimpleTableTexts.copied.resolved)
                                .localized(SimpleTableTexts.copied)
                        }
                            .class("ml-2")
                            .setAttribute(
                                name: "x-show",
                                value: "copied"
                            )
                            .setAttribute(
                                name: "aria-live",
                                value: "polite"
                            )
                    }
                    .class(
                        "flex flex-row items-center space-x-1"
                    )
                    .addClass("cursor-pointer")
                    .addClass(ActionButtonStyles.font)
                    .addClass(ActionButtonStyles.textSizeBase)
                    .addClass(ActionButtonStyles.paddingIcon)
                    .addClass(ActionButtonStyles.textColorIcon)
                    .addClass(ActionButtonStyles.backgroundColorIcon)
                    .addClass(ActionButtonStyles.borderIcon)
                    .addClass(CommonStyles.focusDefault)
                    .addClass(CommonStyles.hoverDefault)
                    .setAttribute(
                        name: "@click",
                        value: "copyWithFeedback()"
                    )
                    .setAttribute(
                        name: "x-show",
                        value: "hasCopyToClipboard && canCopy"
                    )
                    .localized(.ariaLabel, SimpleTableTexts.copyTable)
                    // Matomo
                    .flagAttribute("data-track-content")
                    .setAttribute(
                        name: "data-content-name",
                        value: "simple-table"
                    )
                    .setAttribute(
                        name: "data-content-piece",
                        value: "button.copy"
                    )
                    .setAttribute(
                        name: "data-content-target",
                        value: "\(data.caption?.english ?? "untitled")"
                    )

                    // Filter toggle
                    Div {
                        Button {
                            Svg.icon(.search)
                                .class("w-5 h-5")
                        }
                        .addClass("cursor-pointer")
                        .addClass(ActionButtonStyles.font)
                        .addClass(ActionButtonStyles.textSizeBase)
                        .addClass(ActionButtonStyles.paddingIcon)
                        .addClass(ActionButtonStyles.textColorIcon)
                        .addClass(ActionButtonStyles.backgroundColorIcon)
                        .addClass(ActionButtonStyles.borderIcon)
                        .addClass(CommonStyles.focusDefault)
                        .addClass(CommonStyles.hoverDefault)
                        .localized(.ariaLabel, SimpleTableTexts.toggleFilter)
                        .setAttribute(
                            name: "x-show",
                            value: "hasSearch"
                        )
                        .setAttribute(
                            name: "@click",
                            value: """
                                showFilter = !showFilter;
                                    if (showFilter) {
                                        $nextTick(() => { $refs.filterInput?.focus() });
                                    }
                                """
                        )
                        // Matomo
                        .flagAttribute("data-track-content")
                        .setAttribute(
                            name: "data-content-name",
                            value: "simple-table"
                        )
                        .setAttribute(
                            name: "data-content-piece",
                            value: "search.toggle"
                        )
                        .setAttribute(
                            name: "data-content-target",
                            value: "\(data.caption?.english ?? "untitled")"
                        )

                    }

                    // Column selector
                    Div {

                        Div {
                            Button {
                                Svg.icon(.layout_three_columns)
                                    .class("w-5 h-5")
                            }
                            .addClass("cursor-pointer")
                            .addClass(ActionButtonStyles.font)
                            .addClass(ActionButtonStyles.textSizeBase)
                            .addClass(ActionButtonStyles.paddingIcon)
                            .addClass(ActionButtonStyles.textColorIcon)
                            .addClass(ActionButtonStyles.backgroundColorIcon)
                            .addClass(ActionButtonStyles.borderIcon)
                            .addClass(CommonStyles.focusDefault)
                            .addClass(CommonStyles.hoverDefault)
                            .setAttribute(
                                name: "x-show",
                                value: "hasColumnConfigurator"
                            )
                            .setAttribute(
                                name: "@click",
                                value: "openColumnModal()"
                            )
                            .localized(
                                .ariaLabel,
                                SimpleTableTexts.selectColumns
                            )
                            .setAttribute(
                                name: "data-column-trigger",
                                value: ""
                            )
                            .flagAttribute("data-track-content")
                            .setAttribute(
                                name: "data-content-name",
                                value: "simple-table"
                            )
                            .setAttribute(
                                name: "data-content-piece",
                                value: "column-configurator.toggle"
                            )
                            .setAttribute(
                                name: "data-content-target",
                                value: "\(data.caption?.english ?? "untitled")"
                            )

                        }

                        simpleTableColumnConfigurator(
                            caption: data.caption?.english
                        )

                    }
                    .class("relative")

                }
                .class("flex flex-row items-center space-x-4")

            }
            .class(
                "flex flex-row justify-between w-full items-center px-3 pb-6"
            )
        }
    }

    @Builder<Element>
    func filterInput() -> [Element] {
        Div {
            SearchField(
                SearchFieldData(
                    bindModel: "filterText",
                    bindRef: "filterInput",
                    ariaLabel: SimpleTableTexts.searchRows,
                    clearAriaLabel: SimpleTableTexts.clearFilter,
                    hasTransparentBackground: true,
                    contentTracker: MatomoContentTracker(
                        name: "simple-table",
                        piece: "search.clear",
                        target: data.caption?.english ?? "untitled"
                    )
                )
            )
            .render()
        }
        .setAttribute(
            name: "x-show",
            value: "showFilter"
        )
        .class("pb-4")
    }

    @Builder<Element>
    func table() -> [Element] {
        Table {

            if let caption = data.caption {
                Caption(caption.resolved)
                    .localized(caption)
                    .class("sr-only")
            }

            Thead {
                Tr {
                    Template {
                        Th {
                            Div {
                                Span {}
                                    .setAttribute(
                                        name: "x-text",
                                        value: "col.label"
                                    )

                                Svg.icon(.sort_up, width: 16, height: 16)
                                    .setAttribute(
                                        name: "x-show",
                                        value:
                                            "col.sortable && sortKey === col.key && sortDirection === 'asc'"
                                    )

                                Svg.icon(.sort_down, width: 16, height: 16)
                                    .setAttribute(
                                        name: "x-show",
                                        value:
                                            "col.sortable && sortKey === col.key && sortDirection === 'desc'"
                                    )
                            }
                            .class("flex flex-row space-x-2 items-center")
                            .setAttribute(
                                name: ":class",
                                value: """
                                    col.align === 'right'
                                      ? 'justify-end'
                                      : col.align === 'center'
                                        ? 'justify-center'
                                        : 'justify-start'
                                    """
                            )
                        }
                        .class("select-none")
                        .addClass(tableStyles.thPadding)
                        .addClass(tableStyles.thTextFont)
                        .addClass(tableStyles.thTextSize)
                        .addClass(tableStyles.thTextColor)
                        .setAttribute(
                            name: ":class",
                            value: """
                                {
                                  'text-left': col.align === 'left',
                                  'text-center': col.align === 'center',
                                  'text-right': col.align === 'right',
                                  'cursor-pointer \(tableStyles.thHover)': col.sortable
                                }
                                """
                        )
                        .setAttribute(
                            name: "@click",
                            value: "if (col.sortable) sort(col.key)"
                        )
                    }
                    .setAttribute(
                        name: "x-for",
                        value: "(col, index) in activeColumns"
                    )
                    .setAttribute(
                        name: ":key",
                        value: "col.key"
                    )
                }
            }
            .class(tableStyles.theadBackgroundColor)

            Tbody {

                // No search results
                Tr {

                    Td {

                        Div {

                            Div {
                                Svg.icon(.info_circle)
                                    .class("w-5 h-5")
                            }
                            .class("text-on-surface")

                            P(SimpleTableTexts.noResults.resolved)
                                .localized(SimpleTableTexts.noResults)

                        }
                        .class("flex flex-row space-x-4 items-center")

                    }
                    .class(
                        "px-2 py-4 text-left text-gray-500 dark:text-gray-400"
                    )
                    .setAttribute(
                        name: ":colspan",
                        value: "activeColumns.length"
                    )
                }
                .setAttribute(
                    name: "x-show",
                    value: "sortedRows.length === 0"
                )

                // Results
                Template {
                    Tr {
                        Template {
                            Td {}
                                .class(tableStyles.tdBodyPadding)
                                .addClass(tableStyles.tdBodyTextFont)
                                .addClass(tableStyles.tdBodyTextSize)
                                .addClass(tableStyles.tdBodyTextColor)
                                .setAttribute(
                                    name: ":class",
                                    value:
                                        "{ 'text-left': col.align === 'left', 'text-center': col.align === 'center', 'text-right': col.align === 'right' }"
                                )
                                .setAttribute(
                                    name: "x-text",
                                    value: "format(row[col.key], col)"
                                )
                        }
                        .setAttribute(
                            name: "x-for",
                            value: "col in activeColumns"
                        )
                        .setAttribute(
                            name: ":key",
                            value: "col.key"
                        )
                    }
                    .addClass(tableStyles.trBodyAlternatingRows)
                    .addClass(tableStyles.trBodyHoverBorder)
                }
                .setAttribute(
                    name: "x-for",
                    value: "(row, index) in sortedRows"
                )
                .setAttribute(
                    name: ":key",
                    value: "row.id ?? index"
                )
            }
            //.class(tableStyles.tbodyDivide)

        }
        .class("min-w-full")
        .addClass(tableStyles.tableBorder)
        .addClass(tableStyles.tableBorderColor)

    }

    // MARK: - Render
    @Builder<Element>
    public func render() -> [Element] {
        let _ = SimpleTableTexts.recordScriptTexts()

        if let json = data.json {

            DebugComment("Simple Table")
            Div {

                titleWithActionButtons()

                filterInput()

                Div {

                    table()

                }
                .class("overflow-x-auto")

            }
            .setAttribute(
                name: "x-data",
                value: "datatable(\(json))"
            )
            .class("pt-12 pb-14")

            Script()
                .src("/js/simple-table.js")
                .setAttribute(
                    name: "type",
                    value: "text/javascript"
                )
        }
    }
}
