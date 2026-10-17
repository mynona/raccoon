import HTML
import SGML
import SVG
import WebBuilders

/// SingleSelect: Alpine Combobox integration for UUID submission
///
/// Correct usage pattern (as of Alpine.js 3.15+):
/// - DO NOT use the `name` attribute on the combobox container. Alpine's built-in form integration will submit the entire selected object, not just the UUID.
/// - INSTEAD, always add a manual hidden input:
///     Input()
///         .type(.hidden)
///         .name(data.id)
///         .setAttribute(name: "x-bind:value", value: "selected ? selected.id : ''")
/// - This ensures only the UUID string is submitted to the backend.
/// - See analysis.md (Third Error Iteration) for details and rationale.
///
/// If Alpine or the Combobox API changes in the future, always verify the POST body and update this pattern as needed.
public struct SingleSelect: TemplateRepresentable {
    let data: SingleSelectData
    typealias styles = SingleSelectStyles
    typealias inputFieldStyles = InputFieldStyles
    typealias buttonStyles = ActionButtonStyles

    public init(
        _ data: SingleSelectData
    ) {
        self.data = data
    }

    // Build Alpine data array (must be valid JS even when empty)
    func singleSelectOptions() -> String {
        guard let elements = data.options, !elements.isEmpty else {
            return "[]"
        }
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
            return element.title ?? ""
        }
        return "(None)"
    }

    func getID(forValue id: String) -> Int {
        guard let elements = data.options, elements.count > 0 else {
            return 0
        }
        var result = 0
        for element in elements {
            if id == element.value {
                return result
            }
            result += 1
        }
        return 0
    }

    @Builder<Element>
    // Manual hidden input: ensures only UUID string is submitted
    func showHiddenInput() -> [Element] {
        Input()
            .type(.hidden)
            .name(data.id)
            .setAttribute(
                name: "x-bind:value",
                value: "selected ? selected.id : ''"
            )
    }

    @Builder<Element>
    func showVisibleInput() -> [Element] {
        let describedByIds = [
            data.helperText != nil ? "\(data.id)-helper" : nil,
            data.errorMessages != nil ? "\(data.id)-error-0" : nil,
        ]
        .compactMap { $0 }.joined(separator: " ")
        Input()
            .id(data.id)
            .type(.text)
            .flagAttribute("x-combobox:input")
            .setAttribute(
                name: ":display-value",
                value: "f => f ? f.name : ''"
            )
            .setAttribute(
                name: "autocomplete",
                value: "off"
            )
            .ariaAutoComplete(.list)
            .ariaControls("\(data.id)-listbox")
            .setAttribute(
                name: ":aria-activedescendant",
                value:
                    "isOpen && $combobox.activeIndex !== null ? `${id}-option-${$combobox.activeIndex}` : null"
            )
            .placeholder(data.placeholderText)
            .ariaLabel(data.placeholderAriaLabelText)
            .setAttribute(
                name: "x-model",
                value: "query"
            )
            .setAttribute(
                name: "x-ref",
                value: "comboInput"
            )
            .setAttribute(
                name: "@keydown.escape.stop.prevent",
                value: "onEsc($event)"
            )
            .class("flex-1 p-0 w-full text-sm")
            .addClass(inputFieldStyles.inputReset)
            .addClass(inputFieldStyles.textColorInput)
            .addClass(inputFieldStyles.textColorPlaceholder)
            .if(data.label != nil) { $0.ariaLabelledBy("label-\(data.id)") }
            .if(!describedByIds.isEmpty) { $0.ariaDescribedBy(describedByIds) }
    }

    @Builder<Element>
    func showDropdownButton() -> [Element] {
        Div {

            Button {
                Svg.icon(
                    .chevron_down,
                    title: "Select \(data.id)",
                    width: 16,
                    height: 16
                )
                .setAttribute(
                    name: ":class",
                    value: "{ 'rotate-180': $combobox.isOpen }"
                )
            }
            .setAttribute(
                name: "x-ref",
                value: "comboButton"
            )
            .flagAttribute("x-combobox:button")

        }
        .tabIndex(0)  // this tabIndex is additionally needed, otherwise the button cannot be accessed on all browsers
        .setAttribute(
            name: "@keydown.enter",
            value: "$refs.comboButton.click()"
        )
        .class("flex items-center")
        .addClass(buttonStyles.iconButton)
    }

    @Builder<Element>
    func showClearButton() -> [Element] {

        Button {
            Svg.icon(
                .x_circle,
                width: 16,
                height: 16
            )
        }
        .setAttribute(
            name: "x-show",
            value: "query.length > 0"
        )
        .setAttribute(
            name: "@click",
            value: "clearInput()"
        )
        .ariaLabel("Clear selection")
        .class("flex items-center")
        .class("ml-3")
        .addClass(buttonStyles.iconButton)
    }

    @Builder<Element>
    func showErrorIcon() -> [Element] {
        if let _ = data.errorMessages {
            Div {
                Svg.icon(.dash_circle)
                    .class("\(inputFieldStyles.textColorError)")
            }
            //.class("pointer-events-none absolute inset-y-0 right-4 flex items-center pr-4")
            .class("flex items-center ml-3")
            .setAttribute(
                name: "x-show",
                value: "hasServerError"
            )
        }
    }

    @Builder<Element>
    func showOptionList() -> [Element] {
        // Options list (Alpine 3.15-compliant structure)
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
                                width: 18,
                                height: 18,
                                role: .img
                            )
                        }
                        .setAttribute(
                            name: "x-show",
                            value: "$comboboxOption.isSelected"
                        )
                        .class("text-on-success")
                    }
                    .flagAttribute("x-combobox:option")
                    .role("option")
                    .setAttribute(
                        name: ":aria-selected",
                        value: "$comboboxOption.isSelected"
                    )
                    .setAttribute(
                        name: ":id",
                        value: "`${$root.id}-option-${idx}`"
                    )
                    .setAttribute(
                        name: "@combobox-option:select",
                        value: "hasServerError = false"
                    )
                    .setAttribute(
                        name: ":value",
                        value: "framework"
                    )
                    .setAttribute(
                        name: ":disabled",
                        value: "framework.disabled"
                    )
                    // Do not hide the selected option; all options should be visible for accessibility
                    .setAttribute(
                        name: ":class",
                        value: """
                            {
                                'text-on-surface ring-2 ring-offset-4 ring-offset-white dark:ring-offset-black ring-hoverring rounded-md !no-underline': $comboboxOption.isActive,
                                'text-on-surface ': ! $comboboxOption.isActive && ! $comboboxOption.isDisabled,
                                'opacity-50 cursor-not-allowed': $comboboxOption.isDisabled,
                            }
                            """
                    )
                    .class(
                        "flex items-center cursor-default justify-between mt-4 mb-4 w-full px-1 py-1 text-sm"
                    )
                    .addClass(styles.hoverDefault)

                }
                .setAttribute(
                    name: "x-for",
                    value: "(framework, idx) in filteredFrameworks"
                )
                .setAttribute(
                    name: ":key",
                    value: "framework.id"
                )
            }
            .class("px-4")
            //.class("divide-y divide-outline p-4")
            .addClass(styles.borderColorDefault)

            P("No values found.")
                .setAttribute(
                    name: "x-show",
                    value: "filteredFrameworks.length == 0"
                )
                .class(
                    "px-4 py-4 text-sm text-on-surface"
                )
        }
        .flagAttribute("x-combobox:options")
        .role("listbox")
        .id("\(data.id)-listbox")
        .flagAttribute("x-cloak")
        .flagAttribute("x-transition.out.opacity")
        .class(
            "absolute left-0 w-full max-h-60 overflow-y-scroll overflow-hidden mt-2 pb-2.5 pt-2.5 z-10 origin-top-right"
        )
        .addClass(styles.optionItem)
    }

    @Builder<Element>
    func showInfo() -> [Element] {
        Div {
            if let label = data.label {
                Label(label).render()
                Input()
                    .type(.hidden)
                    .id(data.id)
                    .name(data.id)
                    .setAttribute(
                        name: ":value",
                        value: "$root.selected ? $root.selected.id : ''"
                    )
            }
            P(getTitle(forValue: data.value ?? ""))
        }
        .class("pb-1.5 pt-2.5")
        .addClass(styles.infoBorder)
        .addClass(styles.infoTextColor)
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
            }

            Input()
                .disabled()
                .id(data.id)
                .type(.text)
                .name(data.id)
                .setAttribute(
                    name: "autocomplete",
                    value: "off"
                )
                .value(getTitle(forValue: data.value ?? ""))
                .class(
                    "block w-full p-0 sm:text-sm sm:leading-6 cursor-not-allowed"
                )
                .addClass(inputFieldStyles.inputReset)
                .addClass(styles.textColorDisabled)

            // LockIcon
            Div {
                Svg.icon(.lock)
                    .class("\(styles.textColorDisabled)")
            }
            .class(
                "pointer-events-none absolute inset-y-0 right-0 flex items-center pr-4"
            )
            .setAttribute(
                name: "x-show",
                value:
                    "($root.hasInitialValue || $root.isTouched) && ($root.isValid && !hasServerError)"
            )
        }
        .class("relative rounded-md px-3 pb-1.5 pt-2.5")
        .if(data.state == .disabled || data.state == .hidden) {
            $0.addClass("cursor-not-allowed \(styles.borderColorDisabled)")
        }
        .if(data.backgroundColor != nil) {
            $0.style("background-color: \(data.backgroundColor!);")
        } else: {
            $0.addClass("bg-transparent")
        }

        showHelperText()
    }

    @Builder<Element>
    func showEnabled() -> [Element] {
        let contextValue = data.value ?? ""
        Div {
            Div {
                Div {
                    Div {
                        if let label = data.label {
                            Label(label).render()
                        }
                        Div {
                            showHiddenInput()
                            showVisibleInput()
                            showClearButton()
                            showDropdownButton()
                            showErrorIcon()
                        }
                        .class("flex items-center justify-between gap-4")
                    }
                    .class("w-full px-3 py-2.5 rounded-md")
                    .addClass(inputFieldStyles.inputContainerBorder)
                    .addClass(inputFieldStyles.inputContainerHover)
                    .addClass(inputFieldStyles.inputContainerFocus)
                    .setAttribute(
                        name: ":class",
                        value:
                            "{ '\(inputFieldStyles.borderColorError)': hasServerError, '\(inputFieldStyles.borderColorDefault)': !hasServerError }"
                    )
                    .if(data.backgroundColor != nil) {
                        $0.style("background-color: \(data.backgroundColor!);")
                    } else: {
                        $0.addClass("bg-transparent")
                    }
                    showOptionList()
                }
                .class("relative")
            }
            .flagAttribute("x-combobox")
            .role("combobox")
            .ariaHasPopup(.listbox)
            .setAttribute(
                name: ":aria-expanded",
                value: "isOpen"
            )
            .setAttribute(
                name: "x-model",
                value: "selected"
            )

            // Remove name/by/value attributes from container
            showErrorMessages()
            showHelperText()
        }
        .class("w-full")
        .setAttribute(
            name: "x-data",
            value:
                "singleSelect({ id: \(JavaScriptEscaper.alpineStringLiteral(data.id)), frameworks: \(JavaScriptEscaper.htmlAttributeEscape(singleSelectOptions())), preselected: \(JavaScriptEscaper.alpineStringLiteral(contextValue)), hasServerError: \(data.errorMessages != nil ? "true" : "false") })"
        )
    }

    @Builder<Element>
    func showHelperText() -> [Element] {
        if let helperText = data.helperText {
            HelperText(
                HelperTextData(
                    id: "\(data.id)",
                    text: helperText.text,
                    isMarkdown: helperText.isMarkdown
                )
            )
            .render()
        }
    }

    @Builder<Element>
    func showErrorMessages() -> [Element] {
        if let errorMessages = data.errorMessages {
            Div {
                ErrorMessage(
                    ErrorMessageData(
                        id: "\(data.id)",
                        errorMessages: errorMessages.errorMessages,
                        hasIcon: errorMessages.hasIcon
                    )
                )
                .render()
            }
            .setAttribute(
                name: "x-show",
                value: "hasServerError"
            )
        }
    }

    @Builder<Element>
    public func render() -> [Element] {
        DebugComment("SingleSelect")

        Script()
            .setAttribute(name: "src", value: "/js/single-select.js")
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
