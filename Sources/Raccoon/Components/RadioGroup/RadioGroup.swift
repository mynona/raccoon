import HTML
import SGML
import WebBuilders

/// A group of related radios rendered as `<fieldset>` with a `<legend>`.
///
/// All radios share `data.name`, so the browser provides single selection and arrow-key navigation.
public struct RadioGroup: TemplateRepresentable {
    let data: RadioGroupData
    typealias styles = RadioGroupStyles

    public init(
        _ data: RadioGroupData
    ) {
        self.data = data
    }

    @Builder<Element>
    func showLegend(isEnabled: Bool) -> [Element] {
        if let label = data.label {
            Legend {
                Span(label.title ?? data.id.capitalized)
                if label.isRequired {
                    Span { Svg.icon(.asterisk, width: 8, height: 8) }
                        .ariaHidden("true")
                    Span("(required)")
                        .class(styles.legendRequired)
                }
            }
            .class(styles.legend(size: label.size, isDisabled: label.isDisabled || !isEnabled))
        }
    }

    @Builder<Element>
    public func render() -> [Element] {
        let isEnabled = data.state == .enabled
        let helperText = data.helperText.flatMap { $0.hasVisibleText ? $0 : nil }
        let errorMessages = data.errorMessages.flatMap { $0.hasMessages ? $0 : nil }
        let hasError = errorMessages != nil

        // HelperText renders its own `<helperText.id>-helper` id.
        let describedBy: String? =
            switch (helperText, hasError) {
            case (let helperText?, true): "\(helperText.id)-helper \(data.id)-error"
            case (let helperText?, false): "\(helperText.id)-helper"
            case (nil, true): "\(data.id)-error"
            case (nil, false): nil
            }

        // Only the first matching option is selected, as the browser would keep just one anyway.
        let selectedIndex: Int? = data.selectedValue.flatMap { selected in
            data.options.firstIndex { ($0.value ?? $0.id) == selected }
        }

        Fieldset {
            showLegend(isEnabled: isEnabled)

            if let helperText {
                HelperText(helperText).render()
            }
            if let errorMessages {
                Div { ErrorMessage(errorMessages).render() }
                    .id("\(data.id)-error")
            }

            Div {
                for (index, option) in data.options.enumerated() {
                    Radio(
                        RadioData(
                            id: option.id,
                            name: data.name,
                            label: option.label,
                            value: option.value,
                            helperText: option.helperText,
                            isInvalid: hasError || option.isInvalid,
                            state: isEnabled ? option.state : .disabled,
                            isSelected: index == selectedIndex
                        )
                    )
                    .render()
                }
            }
            .class(
                data.label != nil || helperText != nil || hasError
                    ? styles.optionsAfterContent : styles.options
            )
        }
        .id(data.id)
        .if(describedBy != nil) {
            $0.setAttribute(name: "aria-describedby", value: describedBy ?? "")
        }
    }
}
