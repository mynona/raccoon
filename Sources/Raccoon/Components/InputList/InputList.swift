import HTML
import SGML
import SVG
import WebBuilders

public struct InputList: TemplateRepresentable {
    var data: InputListData
    typealias styles = InputListStyles
    typealias inputFieldStyles = InputFieldStyles

    /// Messages that `input-list.js` shows. The script asks the i18n store for them, so they are
    /// recorded here to land in the page dictionary.
    private static let scriptTexts: [LocalizedText] = [
        LocalizedText("inputlist.errInvalid", "Invalid value."),
        LocalizedText("inputlist.errEmpty", "Value cannot be empty."),
        LocalizedText("inputlist.errDuplicate", "This value already exists."),
    ]

    private static func recordScriptTexts() {
        for text in scriptTexts { text.recordUse() }
    }

    private static let delete = LocalizedText("inputlist.delete", "Delete")
    private static let deleteValue = LocalizedText(
        "inputlist.deleteValue",
        "Delete value"
    )
    private static let add = LocalizedText("inputlist.add", "Add")
    private static let addValue = LocalizedText(
        "inputlist.addValue",
        "Add value"
    )
    private static let clearAll = LocalizedText(
        "inputlist.clearAll",
        "Clear All"
    )
    private static let clearAllValues = LocalizedText(
        "inputlist.clearAllValues",
        "Clear all values"
    )
    private static let editValue = LocalizedText(
        "inputlist.editValue",
        "Edit value"
    )
    private static let enterValue = LocalizedText(
        "inputlist.enterValue",
        "Enter value"
    )
    private static let addNewValue = LocalizedText(
        "inputlist.addNewValue",
        "Add new value"
    )
    private static let enterNewValue = LocalizedText(
        "inputlist.enterNewValue",
        "Enter new value"
    )
    private static let value = LocalizedText("inputlist.value", "Value")

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
                label: Self.delete,
                ariaLabel: Self.deleteValue,
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
                label: Self.add,
                ariaLabel: Self.addValue,
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
                label: Self.clearAll,
                ariaLabel: Self.clearAllValues,
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
                    .localized(.ariaLabel, Self.editValue)
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
                    .localized(.placeholder, Self.enterValue)
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
                    .localized(.ariaLabel, Self.addNewValue)
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
                    .localized(.placeholder, Self.enterNewValue)
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

                    Th(Self.value.resolved)
                        .localized(Self.value)
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
        let _ = Self.recordScriptTexts()
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
                "inputListForm(\(JavaScriptEscaper.htmlAttributeEscape(jsonInitialValues())), \(JavaScriptEscaper.alpineStringLiteral(data.validationRegEx)), \(JavaScriptEscaper.alpineStringLiteral(data.validationMessage.resolved)))"
        )
        .setAttribute(
            name: "x-init",
            value: "init()"
        )
        .class("w-full p-4")
        .addClass(
            data.errorMessages?.hasMessages == true
                ? inputFieldStyles.inputContainerBorderError
                : inputFieldStyles.inputContainerBorder
        )

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
