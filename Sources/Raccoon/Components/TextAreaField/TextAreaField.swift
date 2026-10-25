import Foundation
import HTML
import SGML
import SVG
import WebBuilders

public struct TextAreaField: TemplateRepresentable {
    let data: TextAreaFieldData
    typealias styles = InputFieldStyles

    public init(
        _ data: TextAreaFieldData
    ) {
        self.data = data
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

    func getRequired() -> String {
        data.label?.isRequired == true ? "required" : ""
    }

    @Builder<Element>
    func showServerError() -> [Element] {
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
    }

    @Builder<Element>
    func showHelperText() -> [Element] {
        if let helperText = data.helperText {
            HelperText(helperText).render()
        }
    }

    @Builder<Element>
    func showError() -> [Element] {
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
    }

    @Builder<Element>
    func showLabel() -> [Element] {
        if let label = data.label {
            Label(label).render()
        }
    }

    @Builder<Element>
    public func render() -> [Element] {

        let required = getRequired()
        let regexPattern =
            data.validationRegex.map {
                JavaScriptEscaper.alpineStringLiteral($0)
            } ?? "null"
        let errorMessage =
            data.validationMessage.map {
                JavaScriptEscaper.alpineStringLiteral($0)
            } ?? "''"
        let hasInitialValue = data.value != nil && !data.value!.isEmpty
        let hasServerError = data.errorMessages?.errorMessages != nil
        let monospaced = data.isMonospaced ? "font-mono" : "font-sans"

        let maxRows = max(data.rows, 8)
        let minHeightStyle = "calc(\(data.rows) * 1.5em)"
        let maxHeightStyle = "calc(\(maxRows) * 1.5em)"

        let valueBase64 = (data.value ?? "")
            .data(using: .utf8)!
            .base64EncodedString()

        DebugComment("Textarea field")
        Div {
            Div {
                showLabel()
                Textarea(data.value ?? "")
                    .rows(Int(data.rows))
                    .flagAttribute(required)
                    .id(data.id)
                    .name(data.id)
                    .placeholder(data.placeholder ?? " ")
                    .if(getAriaDescribedBy() != nil) {
                        $0.ariaDescribedBy(getAriaDescribedBy())
                    }
                    .setAttribute(name: "x-model", value: "value")
                    .setAttribute(
                        name: "@input",
                        value:
                            "isTouched = true; hasServerError = false; validate(); autoResize($el)"
                    )
                    .setAttribute(
                        name: "@blur",
                        value:
                            "isTouched = true; hasServerError = false; validate()"
                    )
                    .setAttribute(
                        name: ":aria-invalid",
                        value: "(hasError || hasServerError) ? 'true' : 'false'"
                    )
                    .setAttribute(name: "x-init", value: "autoResize($el)")
                    // Deliberate inline style
                    .setAttribute(
                        name: "style",
                        value:
                            "overflow-x:hidden;overflow-y:auto;resize:none;min-height:\(minHeightStyle);max-height:\(maxHeightStyle);"
                    )
                    .class(
                        "block w-full p-0 resize-none sm:text-sm sm:leading-6 overflow-y-auto"
                    )
                    .addClass(styles.inputReset)
                    .addClass(styles.textColorInput)
                    .addClass(styles.textColorPlaceholder)

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
                .setAttribute(name: "x-transition", value: "")

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
            .class(
                "relative rounded-md px-3 pb-1.5 pt-2.5 \(monospaced)"
            )
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
            showError()
            showServerError()
            showHelperText()
        }
        .setAttribute(
            name: "x-data",
            value:
                "textAreaFieldAlpine({regexPattern: \(regexPattern), errorMessage: \(errorMessage), hasServerError: \(hasServerError ? "true" : "false"), hasInitialValue: \(hasInitialValue ? "true" : "false"), initialValue: \(JavaScriptEscaper.alpineStringLiteral(valueBase64)) })"
        )
        .setAttribute(
            name: "x-init",
            value:
                "if (regexPattern) regex = new RegExp(regexPattern); initialized = true; value = $el.querySelector('textarea').value"
        )
        .setAttribute(
            name: "x-effect",
            value: "if (initialized && (hasInitialValue || value)) validate()"
        )

        Script()
            .src("/js/text-area-field.js")
            .setAttribute(name: "type", value: "text/javascript")
    }
}
