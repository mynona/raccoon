import HTML
import SGML
import SVG
import WebBuilders

public struct InputField: TemplateRepresentable {
    let data: InputFieldData
    typealias styles = InputFieldStyles

    public init(
        _ data: InputFieldData
    ) {
        self.data = data
    }

    func getRequired() -> String {
        data.label?.isRequired == true ? "required" : ""
    }

    @Builder<Element>
    func showLabel() -> [Element] {
        if let label = data.label {
            Label(label).render()
        }
    }

    /// Combines all ids that describe this field so `aria-describedby` covers label,
    /// helper text and both error containers (accepts a space-separated token list).
    func getAriaDescribedBy() -> String? {
        var ids: [String] = []
        if let labelId = data.label?.id { ids.append("label-\(labelId)") }
        if let helperId = data.helperText?.id {
            ids.append("\(helperId)-helper")
        }
        ids.append("\(data.id)-local-error")
        if data.errorMessages?.errorMessages != nil {
            ids.append("\(data.id)-server-error")
        }
        return ids.isEmpty ? nil : ids.joined(separator: " ")
    }

    @Builder<Element>
    public func render() -> [Element] {

        let required = getRequired()
        // Pass regexPattern as a valid JS string (no double escaping)
        let regexPattern = data.validationRegex ?? ""
        let errorMessage = data.validationMessage ?? ""
        let hasInitialValue = data.value != nil && !data.value!.isEmpty
        let hasServerError = data.errorMessages?.errorMessages != nil

        let valueBase64 = (data.value ?? "")
            .data(using: .utf8)!
            .base64EncodedString()

        let maskedInMatomo =
            (data.isMaskedInMatomo) ? "data-matomo-mask" : ""

        DebugComment("Input field")
        Script()
            .src("/js/input-field.js")
            .setAttribute(
                name: "type",
                value: "text/javascript"
            )
        Div {

            Div {

                showLabel()

                Input()
                    .flagAttribute(required)
                    .type(data.type)
                    .id(data.id)
                    .name(data.id)
                    .value(data.value)
                    .placeholder(data.placeholder ?? " ")
                    .setAttribute(
                        name: "autocomplete",
                        value: data.autocomplete
                    )
                    .if(getAriaDescribedBy() != nil) {
                        $0.ariaDescribedBy(getAriaDescribedBy())
                    }
                    .setAttribute(
                        name: "x-model",
                        value: "value"
                    )
                    .setAttribute(
                        name: "@input",
                        value:
                            "isTouched = true; hasServerError = false; validate()"
                    )
                    .setAttribute(
                        name: "@blur",
                        value:
                            "isTouched = true; hasServerError = false; validate(); $nextTick(() => isTouched = true)"
                    )
                    .class(
                        "block w-full p-0 text-sm leading-6"
                    )
                    .addClass(styles.inputReset)
                    .addClass(styles.textColorInput)
                    .addClass(styles.textColorPlaceholder)
                    // Matomo
                    .setAttribute(
                        name: "data-matomo-name",
                        value: "\(data.label?.title ?? "input")"
                    )
                    .flagAttribute(maskedInMatomo)

                // ErrorIcon
                Div {
                    Svg.icon(.dash_circle)
                        .class("\(styles.textColorError)")
                }
                .class(
                    "pointer-events-none absolute inset-y-0 right-0 flex items-center pr-4"
                )
                .setAttribute(
                    name: "x-show",
                    value:
                        "(hasInitialValue || isTouched) && (hasError || hasServerError)"
                )
                .setAttribute(
                    name: "x-transition",
                    value: ""
                )

                // SuccessIcon
                Div {
                    Svg.icon(.check_circle)
                        .class("\(styles.textColorSuccess)")
                }
                .class(
                    "pointer-events-none absolute inset-y-0 right-0 flex items-center pr-4"
                )
                .setAttribute(
                    name: "x-show",
                    value:
                        "(hasInitialValue || isTouched) && (isValid && !hasServerError)"
                )

            }
            .class("relative px-3 pb-1.5 pt-2.5")
            .addClass(styles.inputContainerBorder)
            .addClass(styles.inputContainerHover)
            .addClass(styles.inputContainerFocus)
            .setAttribute(
                name: ":class",
                value: """
                    {
                      '\(styles.borderColorError)': (hasInitialValue || isTouched) && ( hasError || hasServerError),
                      '\(styles.borderColorSuccess)': (hasInitialValue || isTouched) && (isValid && !hasServerError),
                      '\(styles.borderColorDefault)': !hasInitialValue && !isTouched
                    }
                    """
            )

            // MARK: local error
            Div {
                P {}
                    .setAttribute(
                        name: "x-text",
                        value: "errorMessage"
                    )
                    .class("\(styles.textColorError) text-sm mt-2")
            }
            .setAttribute(
                name: "x-show",
                value:
                    "(hasInitialValue || isTouched) && hasError && !hasServerError"
            )
            .setAttribute(
                name: "aria-live",
                value: "polite"
            )
            .id("\(data.id)-local-error")

            // MARK: server error
            Div {
                if let fieldError = data.errorMessages {
                    ErrorMessage(fieldError).render()
                }
            }
            .setAttribute(
                name: "x-show",
                value: "!isTouched"
            )
            .id("\(data.id)-server-error")

            // MARK: helper text
            if let helperText = data.helperText {
                HelperText(helperText).render()
            }

        }
        .setAttribute(
            name: "x-data",
            value:
                "inputField({value: \(JavaScriptEscaper.alpineStringLiteral(valueBase64)), regexPattern: \(regexPattern.isEmpty ? "null" : "/\(regexPattern)/"), errorMessage: \(JavaScriptEscaper.alpineStringLiteral(errorMessage)), hasServerError: \(hasServerError ? "true" : "false"), hasInitialValue: \(hasInitialValue ? "true" : "false")})"
        )

    }
}
