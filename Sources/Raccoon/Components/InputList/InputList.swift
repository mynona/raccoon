import HTML
import SGML
import SVG
import WebBuilders

public struct InputList: TemplateRepresentable {
    var data: InputListData
    typealias styles = InputListStyles
    typealias inputFieldStyles = InputFieldStyles

    private func jsonInitialValues() -> String {
        guard let values = data.values else { return "[]" }
        return JavaScriptEscaper.jsonEncode(values, fallback: "[]")
    }

    public init(
        _ data: InputListData
    ) {
        self.data = data
    }

    @Builder<Element>
    func showDeleteButton() -> [Element] {
        ActionButton(
            ActionButtonData(
                clickAction: "remove(index)",
                label: "Delete",
                ariaLabel: "Delete value",
                htmlType: .button,
                buttonType: .icon,
                icon: .trash3,
                contentTracker:
                    MatomoContentTracker(
                        name: "input-list",
                        piece: "button.delete",
                        target: ""
                    )
            )
        )
        .render()
    }

    @Builder<Element>
    func showAddButton() -> [Element] {
        ActionButton(
            ActionButtonData(
                clickAction: "add",
                label: "Add",
                ariaLabel: "Add value",
                htmlType: .button,
                buttonType: .icon,
                icon: .plus_circle,
                contentTracker: MatomoContentTracker(
                    name: "input-list",
                    piece: "button.add",
                    target: ""
                )
            )
        )
        .render()
    }

    @Builder<Element>
    func showClearAllButton() -> [Element] {
        ActionButton(
            ActionButtonData(
                clickAction: "clearAll",
                label: "Clear All",
                ariaLabel: "Clear all values",
                htmlType: .button,
                buttonType: .icon,
                icon: .trash3,
                contentTracker: MatomoContentTracker(
                    name: "input-list",
                    piece: "button.clearall",
                    target: ""
                )
            )
        )
        .render()
    }

    @Builder<Element>
    func showRowInput() -> [Element] {
        Div {
            // Input with icons
            Div {
                Input()
                    .type(.text)
                    .ariaLabel("Edit value")
                    .setAttribute(
                        name: "x-model",
                        value: "values[index]"
                    )
                    .setAttribute(
                        name: "@input",
                        value:
                            "validateExisting(index)"
                    )
                    .setAttribute(
                        name: "@blur",
                        value:
                            "validateExisting(index)"
                    )
                    .placeholder("Enter value")
                    .addClass(inputFieldStyles.inputReset)
                    .addClass(inputFieldStyles.textColorInput)
                    .addClass(inputFieldStyles.textColorPlaceholder)

                // Error icon
                Div {
                    Span {
                        Svg.icon(.dash_circle)
                    }
                    .class(inputFieldStyles.textColorError)

                }
                .class(
                    "pointer-events-none absolute inset-y-0 right-0 flex items-center pr-4"
                )
                .setAttribute(
                    name: "x-show",
                    value: "rowErrors[index]"
                )

                // Success icon
                Div {
                    Svg.icon(.check_circle)
                        .class(inputFieldStyles.textColorSuccess)
                }
                .class(
                    "pointer-events-none absolute inset-y-0 right-0 flex items-center pr-4"
                )
                .setAttribute(
                    name: "x-show",
                    value: "rowValid[index]"
                )
            }
            .class("relative")
            .addClass(inputFieldStyles.inputContainerBorder)
            .addClass(inputFieldStyles.inputContainerHover)
            .addClass(inputFieldStyles.inputContainerFocus)
            .setAttribute(
                name: ":class",
                value: """
                      {
                        'border-1 \(inputFieldStyles.borderColorError)': rowErrors[index],
                        'border-1 \(inputFieldStyles.borderColorSuccess)': (!rowErrors[index] && rowValid[index]),
                        'border-1 \(inputFieldStyles.borderColorDefault)': (!rowErrors[index] && !rowValid[index])
                      }
                    """
            )

            // Error message
            Span {}
                .setAttribute(
                    name: "x-show",
                    value: "rowErrors[index]"
                )
                .setAttribute(
                    name: "x-text",
                    value: "rowErrors[index]"
                )
                .setAttribute(
                    name: "aria-live",
                    value: "polite"
                )
                .class("\(inputFieldStyles.textColorError)")
        }
    }

    @Builder<Element>
    func showAddInput() -> [Element] {
        Div {
            Div {
                Input()
                    .type(.text)
                    .setAttribute(
                        name: "x-model",
                        value: "newValue"
                    )
                    .ariaLabel("Add new value")
                    .setAttribute(
                        name: "@input",
                        value: "validateNew()"
                    )
                    .setAttribute(
                        name: "@keydown.enter.prevent",
                        value: "add"
                    )
                    .setAttribute(
                        name: "@keydown.escape.prevent",
                        value: "clearInput"
                    )
                    .placeholder("Enter new value")
                    .addClass(inputFieldStyles.inputReset)
                    .addClass(inputFieldStyles.textColorInput)
                    .addClass(inputFieldStyles.textColorPlaceholder)

                // Error icon
                Div {
                    Svg.icon(.dash_circle)
                        .class(inputFieldStyles.textColorError)
                }
                .class(
                    "pointer-events-none absolute inset-y-0 right-0 flex items-center pr-4"
                )
                .setAttribute(
                    name: "x-show",
                    value: "newError"
                )

                // Success icon
                Div {
                    Svg.icon(.check_circle)
                        .class(inputFieldStyles.textColorSuccess)
                }
                .class(
                    "pointer-events-none absolute inset-y-0 right-0 flex items-center pr-4"
                )
                .setAttribute(
                    name: "x-show",
                    value:
                        "newValue !== '' && !newError && regex.test(newValue)"
                )
            }
            .class("relative")
            .addClass(inputFieldStyles.inputContainerBorder)
            .addClass(inputFieldStyles.inputContainerHover)
            .addClass(inputFieldStyles.inputContainerFocus)
            .setAttribute(
                name: ":class",
                value: """
                      {
                        'border-1 \(inputFieldStyles.borderColorError)': (newError),
                        'border-1 \(inputFieldStyles.borderColorSuccess)': (newValue !== '' && !newError && regex.test(newValue)),
                        'border-1 \(inputFieldStyles.borderColorDefault)': (!newError && !(newValue !== '' && regex.test(newValue)))
                      }
                    """
            )

            // Error message
            Span {}
                .setAttribute(
                    name: "x-show",
                    value: "newError"
                )
                .setAttribute(
                    name: "x-text",
                    value: "newError"
                )
                .setAttribute(
                    name: "aria-live",
                    value: "polite"
                )
                .class("mt-4")
                .addClass(inputFieldStyles.textColorError)
        }
    }

    @Builder<Element>
    func showTable() -> [Element] {
        Table {
            Thead {
                Tr {
                    Th("#")
                        .scope(.col)
                        .class(
                            "px-3 py-2 text-left w-px"
                        )
                        .addClass(inputFieldStyles.textColorDefault)

                    Th("Value")
                        .scope(.col)
                        .class(
                            "px-3 py-2 text-left w-full"
                        )
                        .addClass(inputFieldStyles.textColorDefault)

                    Th { showClearAllButton() }
                        .scope(.col)
                        .class("px-3 py-2 text-left w-full")
                }
            }

            Tbody {
                // Existing values
                Template {
                    Tr {
                        Td {
                            Span {}
                                .setAttribute(
                                    name: "x-text",
                                    value: "index + 1"
                                )
                        }
                        .class(
                            "py-4 px-3 py-2 align-top w-px flex items-start"
                        )
                        .addClass(inputFieldStyles.borderColorDefault)
                        .addClass(inputFieldStyles.textColorDefault)

                        Td { showRowInput() }
                            .class("py-4 px-3 py-2 w-full")

                        Td { showDeleteButton() }
                            .class("py-4 px-3 py-2 w-full flex items-start")
                    }
                }
                .setAttribute(
                    name: "x-for",
                    value: "(value, index) in values"
                )
                .setAttribute(
                    name: ":key",
                    value: "index"
                )

                // New value row
                Tr {
                    Td {}.class("py-4 px-3 py-2 align-top w-px")

                    Td { showAddInput() }
                        .class("py-4 px-3 py-2 w-full")

                    Td { showAddButton() }
                        .class("py-4 px-3 py-2 w-full flex items-start")
                }
            }
            .addClass("divide-y")
            .addClass(styles.divideColorDefault)
        }
        .class("min-w-full table-auto mt-4")
        .addClass("divide-y")
        .addClass(styles.divideColorDefault)
    }

    @Builder<Element>
    public func render() -> [Element] {
        DebugComment("Input list")
        Script()
            .src("/js/input-list.js")
            .setAttribute(
                name: "type",
                value: "text/javascript"
            )
        Div {

            // MARK: label
            if let label = data.label {
                Label(label).render()
            }

            Div {

                showTable()

                // Hidden inputs for form submission
                Template {
                    Input()
                        .type(.hidden)
                        .name("\(data.id)[]")
                        .setAttribute(
                            name: ":value",
                            value: "value"
                        )
                }
                .setAttribute(
                    name: "x-for",
                    value: "value in values"
                )
                .setAttribute(
                    name: ":key",
                    value: "value"
                )
            }
        }
        .setAttribute(
            name: "x-data",
            value:
                "inputListForm(\(JavaScriptEscaper.htmlAttributeEscape(jsonInitialValues())), \(JavaScriptEscaper.alpineStringLiteral(data.validationRegEx)), \(JavaScriptEscaper.alpineStringLiteral(data.validationMessage)))"
        )
        .setAttribute(
            name: "x-init",
            value: "init()"
        )
        .class("w-full p-4")
        .addClass(inputFieldStyles.inputContainerBorder)

        // MARK: error
        if let fieldError = data.errorMessages {
            ErrorMessage(fieldError).render()
        }

        // MARK: helperText
        if let helperText = data.helperText {
            HelperText(helperText).render()
        }

    }
}
