import HTML
import SGML
import SVG
import WebBuilders

public struct MultiSelect: TemplateRepresentable {
    let data: MultiSelectData
    typealias styles = MultiSelectStyles
    typealias inputFieldStyles = InputFieldStyles
    typealias buttonStyles = ActionButtonStyles

    public init(
        _ data: MultiSelectData
    ) {
        self.data = data
    }

    // Map OptionContext to JSON data
    func singleSelectOptions() -> String {
        guard let elements = data.options else { return "[]" }

        struct OptionPayload: Encodable {
            let id: String
            let name: String
            let disabled: Bool
        }
        let payloads = elements.map {
            OptionPayload(
                id: $0.value ?? "",
                name: $0.title ?? "",
                disabled: false
            )
        }
        return JavaScriptEscaper.jsonEncode(payloads, fallback: "[]")
    }

    func getTitle(forValue id: String) -> String {
        guard let elements = data.options else { return "" }
        for element in elements where id == element.value {
            return element.title!
        }
        return "(No value set)"
    }

    // Returns indices of preselected values in the options list, e.g. [11,8,10]
    func getIDs() -> String {
        guard let elements = data.options,
            elements.count > 0,
            let values = data.values
        else { return "[]" }

        var result: [Int] = []
        for value in values {
            for (index, element) in elements.enumerated() {
                if value == element.value {
                    result.append(index)
                }
            }
        }
        let mapped = result.map { String($0) }.joined(separator: ",")
        return "[\(mapped)]"
    }

    @Builder<Element>
    func showInfo() -> [Element] {
        Div {

            if let label = data.label {

                Label(label).render()

                // Hidden input to be compliant with accessibility rules
                // for the Label id
                if data.label != nil {
                    Input()
                        .id(data.label?.id ?? data.id)
                        .name(data.label?.id ?? data.id)
                        .type(.text)
                        .setAttribute(name: "tabindex", value: "-1")
                        .setAttribute(name: "aria-hidden", value: "true")
                        .class("sr-only")

                }

            }

            if let values = data.values, values.count > 0 {
                Div {
                    for value in values {
                        let title = getTitle(forValue: value)
                        Span(title)
                            .class(
                                "flex-initial mt-2 mr-2 p-1 px-2 \(styles.optionInfo)"
                            )
                    }
                }
                .class("flex flex-wrap py-2")
            }

        }
        .class("p-2")
        .addClass(styles.infoBorder)
        .addClass(styles.infoTextColor)
        .if(data.backgroundColor != nil) {
            $0.style("background-color: \(data.backgroundColor!);")
        } else: {
            $0.addClass("bg-transparent")
        }
    }

    @Builder<Element>
    func showDisabledOrHidden() -> [Element] {
        Div {

            if let label = data.label {
                Label(
                    LabelData(
                        id: label.id,
                        title: label.title,
                        position: label.position ?? .left,
                        size: label.size,
                        isRequired: label.isRequired,
                        isDisabled: true,
                        xhtml: label.xhtml
                    )
                )
                .render()

                // Hidden input to be compliant with accessibility rules
                // for the Label id
                if data.label != nil {
                    Input()
                        .id(data.label?.id ?? data.id)
                        .name(data.label?.id ?? data.id)
                        .type(.text)
                        .setAttribute(name: "tabindex", value: "-1")
                        .setAttribute(name: "aria-hidden", value: "true")
                        .class("sr-only")

                }

            }

            if let values = data.values, values.count > 0 {

                Div {

                    for value in values {

                        Div { Span(getTitle(forValue: value)) }
                            .class(
                                "flex-initial mt-2 mr-2 p-1 px-2 \(styles.optionInfo)"
                            )

                    }
                }
                .class("flex flex-wrap py-2")
            }

            // LockIcon
            Div {
                Svg.icon(.lock)
                    .class("\(styles.textColorDisabled)")
            }
            .class(
                "pointer-events-none absolute inset-y-0 right-0 flex items-center pr-4"
            )

        }
        .class(
            "relative rounded-md px-3 pb-1.5 pt-2.5 cursor-not-allowed"
        )
        .addClass(styles.borderColorDisabled)
        .if(data.backgroundColor != nil) {
            $0.style("background-color: \(data.backgroundColor!);")
        } else: {
            $0.addClass("bg-transparent")
        }
    }

    @Builder<Element>
    func showOptions() -> [Element] {
        // Select options
        Div {

            Ul {

                Template {

                    Li {

                        Span {}
                            .setAttribute(
                                name: "x-text",
                                value: "framework.name"
                            )

                        Span {
                            Svg.icon(
                                .check_lg,
                                title: "Select \(data.id)",
                                width: 16,
                                height: 16,
                                role: .img
                            )
                        }
                        .setAttribute(
                            name: "x-show",
                            value: "$comboboxOption.isSelected"
                        )
                        .class("text-on-theme")

                    }
                    .setAttribute(
                        name: "@combobox-option:select",
                        value: "hasServerError = false"
                    )
                    .flagAttribute("x-combobox:option")
                    .flagAttribute("x-cloak")
                    .setAttribute(
                        name: ":value",
                        value: "framework"
                    )
                    .setAttribute(
                        name: ":disabled",
                        value: "framework.disabled"
                    )
                    .setAttribute(
                        name: ":class",
                        value: """
                            {
                               'bg-tertiary text-on-surface-bright': $comboboxOption.isActive,
                               'text-on-surface dark:print:!text-print': ! $comboboxOption.isActive,
                               'opacity-50 cursor-not-allowed': $comboboxOption.isDisabled,
                            }
                            """
                    )
                    .class(
                        "flex items-center cursor-default justify-between gap-2 w-full px-4 py-2 text-sm"
                    )

                }
                .setAttribute(
                    name: "x-for",
                    value: "framework in filteredFrameworks"
                )
                .setAttribute(
                    name: ":key",
                    value: "framework.id"
                )
                .flagAttribute("hidden")

            }
            .class(
                "divide-y divide-gray-300 dark:divide-gray-400"
            )

            showEverythingSelectedMessage()
            showNoValueFoundMessage()

        }
        .flagAttribute("x-combobox:options")
        .flagAttribute("x-cloak")
        .flagAttribute("x-transition.out.opacity")
        .class(
            "absolute rounded-md left-0 w-full max-h-60 overflow-y-scroll overflow-hidden mt-3 pb-2.5 pt-2.5 px-3 z-10 origin-top-right \(styles.optionContainer)"
        )
    }

    @Builder<Element>
    func showHelperText() -> [Element] {
        if let helperText = data.helperText {
            HelperText(helperText).render()
        }
    }

    @Builder<Element>
    func showErrorMessages() -> [Element] {
        if let errorMessages = data.errorMessages {
            Div {
                ErrorMessage(errorMessages).render()
            }
            .setAttribute(
                name: "x-show",
                value: "hasServerError"
            )
        }
    }

    @Builder<Element>
    func showErrorIcon() -> [Element] {
        if let _ = data.errorMessages {
            Div {
                Svg.icon(.dash_circle)
                    .class("\(inputFieldStyles.textColorError)")
            }
            .class("flex ml-3")
            //.class("pointer-events-none absolute inset-y-0 right-2 flex items-center pr-2")
            .setAttribute(
                name: "x-show",
                value: "hasServerError"
            )
        }
    }

    @Builder<Element>
    func showDropdownButton() -> [Element] {
        Button {
            Svg.icon(
                .chevron_down,
                width: 16,
                height: 16
            )
            .setAttribute(
                name: ":class",
                value: "{ 'rotate-180': $combobox.isOpen }"
            )
        }
        .flagAttribute("x-combobox:button")
        .type(.button)
        .class("flex items-center")
        .addClass("cursor-pointer")
        .addClass(buttonStyles.font)
        .addClass(buttonStyles.textSizeBase)
        .addClass(buttonStyles.paddingIcon)
        .addClass(buttonStyles.textColorIcon)
        .addClass(buttonStyles.backgroundColorIcon)
        .addClass(buttonStyles.borderIcon)
        .addClass(CommonStyles.focusDefault)
        .addClass(CommonStyles.hoverDefault)

    }

    @Builder<Element>
    func showEverythingSelectedMessage() -> [Element] {
        // Messages (aria-live for announcements)
        P("Everything selected.")
            .setAttribute(
                name: "x-show",
                value:
                    "filteredFrameworks.length == 0 && selected.length === frameworks.length"
            )
            .setAttribute(
                name: "role",
                value: "status"
            )
            .setAttribute(
                name: "aria-live",
                value: "polite"
            )
            .class(
                "px-4 py-2 text-sm text-gray-600 dark:text-gray-400"
            )
    }

    @Builder<Element>
    func showNoValueFoundMessage() -> [Element] {
        P("No values found.")
            .setAttribute(
                name: "x-show",
                value:
                    "filteredFrameworks.length == 0 && selected.length !== frameworks.length"
            )
            .setAttribute(
                name: "role",
                value: "status"
            )
            .setAttribute(
                name: "aria-live",
                value: "polite"
            )
            .class("px-4 py-2 text-sm text-gray-600")
    }

    @Builder<Element>
    func showLabel() -> [Element] {
        if let label = data.label {
            Label(label).render()
        }
    }

    @Builder<Element>
    func showSelectedItems() -> [Element] {
        // Show selected items
        Div {
            Template {
                Button {
                    Span {}
                        .setAttribute(
                            name: "x-text",
                            value: "selectedFramework.name"
                        )

                    Span {
                        Svg.icon(.x_lg, title: "Remove", width: 12, height: 12)
                    }
                    .class("pl-1")

                }
                .setAttribute(
                    name: "x-on:click.prevent",
                    value: "remove(selectedFramework); hasServerError = false;"
                )
                .class(
                    "inline-flex items-center p-1 px-2 \(styles.optionSelected)"
                )
                .addClass(InputFieldStyles.inputContainerFocus)
                .addClass(InputFieldStyles.inputContainerHover)

            }
            .setAttribute(
                name: "x-for",
                value: "selectedFramework in selected"
            )
            .setAttribute(
                name: ":key",
                value: "selectedFramework.id"
            )
            .class("pr-2")

        }
        .setAttribute(
            name: "x-show",
            value: "selected.length"
        )
        .class(
            "flex flex-wrap items-center gap-3 border-b mb-1 border-gray-300 py-4"
        )
    }

    @Builder<Element>
    func showInputField() -> [Element] {
        Div {
            // The selected value will be stored in this
            // hidden input field and sent when the form
            // is submitted
            Select {
            }
            .id(data.id)
            .name(data.name)
            .flagAttribute("multiple")
            .class("hidden")
            .setAttribute(
                name: "x-html",
                value: "selectedOptions()"
            )

            // Visual representation of the input in the user interface
            Input()
                .flagAttribute("x-combobox:input")
                .setAttribute(
                    name: "@input",
                    value: "query = $event.target.value;"
                )
                .setAttribute(
                    name: "autocomplete",
                    value: "off"
                )
                .placeholder("Search or select")
                .ariaLabel("Search or select")
                .class("flex-1 p-0 w-full text-sm")
                .addClass(inputFieldStyles.inputReset)
                .addClass(inputFieldStyles.textColorInput)
                .addClass(inputFieldStyles.textColorPlaceholder)

            showDropdownButton()
            showErrorIcon()
        }
        .class("flex items-center gap-4 w-full py-2.5")
        .class("flex items-center justify-between gap-2 w-full")
    }

    @Builder<Element>
    func showEnabled() -> [Element] {
        // https://alpinejs.dev/component/headless-combobox

        Script()
            .src("/js/multi-select.js")
            .setAttribute(
                name: "type",
                value: "text/javascript"
            )
        Div {
            Div {
                Div {
                    Div {
                        showLabel()
                        showSelectedItems()
                        showInputField()
                    }
                    .class("w-full px-3 pb-1.5 pt-2.5 rounded-md")
                    .addClass(inputFieldStyles.inputContainerBorder)
                    .addClass(inputFieldStyles.inputContainerHover)
                    .addClass(inputFieldStyles.inputContainerFocus)
                    .if(data.backgroundColor != nil) {
                        $0.style("background-color: \(data.backgroundColor!)")
                    } else: {
                        $0.addClass("bg-transparent")
                    }
                    .setAttribute(
                        name: ":class",
                        value:
                            "{ '\(inputFieldStyles.borderColorError)': hasServerError, '\(inputFieldStyles.borderColorDefault)': !hasServerError }"
                    )

                    showOptions()

                }
                .class("relative")

            }
            .flagAttribute("x-combobox")
            .flagAttribute("multiple")
            .setAttribute(
                name: "x-model",
                value: "selected"
            )
            .class("p-0 border-0 bg-transparent")

            showHelperText()
            showErrorMessages()

        }
        .setAttribute(
            name: "x-data",
            value:
                "multiSelect({frameworks: \(JavaScriptEscaper.htmlAttributeEscape(singleSelectOptions())), preselected: \(getIDs()), hasServerError: \(data.errorMessages != nil ? "true" : "false")})"
        )
    }

    @Builder<Element>
    public func render() -> [Element] {

        switch data.state {

        case .enabled:
            showEnabled()

        case .disabled, .hidden:
            showDisabledOrHidden()

        case .info:
            showInfo()

        }
    }
}
