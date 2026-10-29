import HTML
import SGML
import WebBuilders

/// A single radio input with label, helper text and error messages.
///
/// Use `RadioGroup` to render several radios that belong together.
public struct Radio: TemplateRepresentable {
    let data: RadioData
    typealias styles = RadioStyles

    public init(
        _ data: RadioData
    ) {
        self.data = data
    }

    @Builder<Element>
    func showDetails(isEnabled: Bool) -> [Element] {
        if data.label != nil || data.helperText?.hasVisibleText == true
            || data.errorMessages?.hasMessages == true
        {
            Div {
                if let label = data.label {
                    HTML.Label(label)
                        .for(data.id)
                        .class(isEnabled ? styles.labelEnabled : styles.labelDisabled)
                }
                if let helperText = data.helperText, helperText.hasVisibleText {
                    HelperText(helperText).render()
                }
                if let errorMessages = data.errorMessages, errorMessages.hasMessages {
                    Div { ErrorMessage(errorMessages).render() }
                        .id("\(data.id)-error")
                }
            }
            .class(styles.labelWrapper)
        }
    }

    @Builder<Element>
    public func render() -> [Element] {
        let isEnabled = data.state == .enabled
        let hasError = data.errorMessages?.hasMessages == true

        // HelperText renders its own `<helperText.id>-helper` id.
        let helperId: String? =
            data.helperText?.hasVisibleText == true ? data.helperText.map { "\($0.id)-helper" } : nil
        let describedBy: String? =
            switch (helperId, hasError) {
            case (let helperId?, true): "\(helperId) \(data.id)-error"
            case (let helperId?, false): helperId
            case (nil, true): "\(data.id)-error"
            case (nil, false): nil
            }

        Div {
            Div {
                Input()
                    .id(data.id)
                    .name(data.name ?? data.id)
                    .type(.radio)
                    .value(data.value ?? data.id)
                    .class(isEnabled ? styles.inputEnabled : styles.inputDisabled)
                    .if(data.isSelected) { $0.checked() }
                    .if(!isEnabled) { $0.disabled() }
                    .if(hasError || data.isInvalid) { $0.ariaInvalid(.true) }
                    .if(describedBy != nil) {
                        $0.setAttribute(
                            name: "aria-describedby",
                            value: describedBy ?? ""
                        )
                    }
            }
            .class(styles.inputWrapper)

            showDetails(isEnabled: isEnabled)
        }
        .class(styles.container)
    }
}

extension HelperTextData {
    /// Whether the helper text renders anything.
    var hasVisibleText: Bool {
        !(text ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

extension ErrorMessageData {
    /// Whether the error container renders anything.
    var hasMessages: Bool {
        !(errorMessages ?? []).isEmpty
    }
}
