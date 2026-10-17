import Foundation
import HTML
import SGML
import SVG
import WebBuilders

/// Checkbox selection component with search and "select all" functionality.
///
/// - Renders a table of checkboxes with Alpine.js interactivity.
/// - Provides a search input to filter options.
/// - Includes a "Select All" checkbox with indeterminate state (hidden when searching).
/// - Displays "No results found" when search yields no matches.
/// - Submits the selected values as a single hidden input containing a comma-separated list of IDs.
///
/// ### Parsing submitted values
/// On form submission, the hidden input named `data.id` will contain a string of comma-separated values
/// (e.g. `"id1,id2,id3"`).
/// To parse this in Vapor, you can split the string into an array:
///
/// ```swift
/// let selectedString = try req.content.get(String.self, at: "myFieldKey")
/// let selectedIds = selectedString.split(separator: ",").map(String.init)
/// ```
///
/// If your values are UUIDs:
/// ```swift
/// let selectedUUIDs = selectedString
///     .split(separator: ",")
///     .compactMap { UUID(uuidString: String($0)) }
/// ```
public struct CheckboxSelect: TemplateRepresentable {
    let idPrefix: String
    let data: CheckboxSelectData
    typealias styles = CheckBoxSelectStyles

    public init(
        _ data: CheckboxSelectData,
        idPrefix: String = UUID().uuidString
            .replacingOccurrences(of: "-", with: "_")
    ) {
        // Sanitize idPrefix: replace dashes with underscores, prepend _ if first char is not a letter/underscore
        var prefix = idPrefix.replacingOccurrences(of: "-", with: "_")
        if let first = prefix.first, !(first.isLetter || first == "_") {
            prefix = "_" + prefix
        }
        self.idPrefix = prefix
        self.data = data
    }

    private func jsonInitialValues() -> String {
        JavaScriptEscaper.jsonEncode(data.values, fallback: "[]")
    }

    @Builder<Element>
    func showLabel() -> [Element] {
        if let label = data.label {
            Label(label).render()
        }
    }

    @Builder<Element>
    func showSearch() -> [Element] {
        if data.hasSearch {
            Div {
                SearchField(
                    SearchFieldData(
                        bindModel: "searchRaw",
                        bindRef: "checkboxSearchInput",
                        tabindex: "0",
                        placeholder: "Search",
                        ariaLabel: "Search options",
                        ariaControls: "checkbox-options",
                        iconTitle: "Search",
                        hasTransparentBackground: true
                    )
                )
                .render()
            }
            .class("my-4")
        }
    }

    func addSpace() -> Bool {
        guard data.hasSearch == false || data.hasSelectAll == false else {
            return false
        }
        return true
    }

    @Builder<Element>
    func showOptions() -> [Element] {
        Div {
            Table {
                let cellPadding = "pr-2 text-left pb-2"
                let cellPaddingHeader = "pr-2 text-left pb-4"

                Thead {
                    if data.hasSelectAll {
                        Tr {
                            Th {

                                // Accessibility requirement
                                Span("Select")
                                    .class("sr-only")

                                Input()
                                    .type(.checkbox)
                                    .id("\(idPrefix)-selectAll")
                                    .setAttribute(
                                        name: "x-model",
                                        value: "selectAll"
                                    )
                                    .setAttribute(
                                        name: "@change",
                                        value: "toggleAll()"
                                    )
                                    .setAttribute(
                                        name: "aria-label",
                                        value: "Select all options"
                                    )
                                    .setAttribute(
                                        name: "aria-checked",
                                        value:
                                            "selectAll ? 'true' : (filteredValues.some(v => v.selected) ? 'mixed' : 'false')"
                                    )
                                    .setAttribute(
                                        name: "tabindex",
                                        value: "0"
                                    )
                                    .class(styles.textColorCheckbox)
                                    .addClass(styles.hoverDefault)
                                    .addClass(styles.focusDefault)

                            }
                            .class(cellPaddingHeader)

                            Th {

                                // Accessibility requirement
                                Span("Option")
                                    .class("sr-only")

                                HTML.Label("Select All")
                                    .for("\(idPrefix)-selectAll")
                                    .class(styles.textColorLabel)
                            }
                            .class(cellPaddingHeader)

                        }
                        .setAttribute(
                            name: "x-show",
                            value: "searchRaw.length === 0"
                        )
                    }
                }

                Tbody {
                    Template {
                        Tr {
                            Td {
                                Input()
                                    .type(.checkbox)
                                    .setAttribute(
                                        name: ":id",
                                        value: "'\(idPrefix)-' + opt.value"
                                    )
                                    .setAttribute(
                                        name: "x-model",
                                        value: "opt.selected"
                                    )
                                    .setAttribute(
                                        name: "@change",
                                        value: "updateSelectAll()"
                                    )
                                    .setAttribute(
                                        name: "tabindex",
                                        value: "0"
                                    )
                                    .class(styles.textColorCheckbox)
                                    .addClass(styles.hoverDefault)
                                    .addClass(styles.focusDefault)
                            }
                            .class(cellPadding)

                            Td {
                                HTML.Label {}
                                    .setAttribute(
                                        name: ":for",
                                        value: "'\(idPrefix)-' + opt.value"
                                    )
                                    .setAttribute(
                                        name: "x-text",
                                        value: "formatLabel(opt.title)"
                                    )
                                    .class(styles.textColorLabel)
                            }
                            .class(cellPadding)
                        }
                    }
                    .setAttribute(
                        name: "x-for",
                        value: "opt in filteredValues"
                    )
                    .setAttribute(
                        name: ":key",
                        value: "opt.value"
                    )

                    Tr {
                        Td {
                            Span("No results found.")
                                .class(styles.textColorNoResults)
                                .ariaLive(.polite)
                        }
                        .setAttribute(
                            name: "colspan",
                            value: "2"
                        )
                        .class("py-2")
                    }
                    .setAttribute(
                        name: "x-show",
                        value: "filteredValues.length === 0"
                    )
                }
            }
        }
        .id("\(idPrefix)-checkbox-options")
        .if(addSpace()) {
            $0.class("mt-2")
        }
    }

    @Builder<Element>
    func showHiddenInput() -> [Element] {
        // Single hidden input with comma-separated UUIDs
        Input()
            .type(.hidden)
            .name(data.id)
            .setAttribute(
                name: "x-model",
                value: "joined"
            )
            .id("\(idPrefix)-hidden")
            .ariaHidden("true")
    }

    @Builder<Element>
    public func render() -> [Element] {

        DebugComment("Checkbox select")

        Script()
            .src("/js/checkbox-select.js")
            .setAttribute(
                name: "type",
                value: "text/javascript"
            )

        Div {

            Div {

                showLabel()
                showSearch()
                showOptions()
                showHiddenInput()

            }
            .setAttribute(
                name: "x-data",
                value:
                    "checkboxSelect(\(JavaScriptEscaper.htmlAttributeEscape(jsonInitialValues())))"
            )
            .setAttribute(
                name: "x-init",
                value: "updateSelectAll()"
            )

        }
        .class("p-4")
        .addClass(styles.inputContainerBorder)

        if let fieldError = data.errorMessages {
            ErrorMessage(fieldError).render()
        }

        if let helperText = data.helperText {
            HelperText(helperText).render()
        }

    }
}
