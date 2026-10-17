import HTML
import SGML
import WebBuilders

public struct Check: TemplateRepresentable {
    let data: CheckData
    typealias styles = CheckStyles

    public init(
        _ data: CheckData
    ) {
        self.data = data
    }

    @Builder<Element>
    func showLabel() -> [Element] {
        Div {
            HTML.Label(data.label ?? "")
                .for(data.id)
                .class(styles.textFontDefault)
                .if(data.state == .enabled) {
                    $0.class(styles.textColorLabel)
                } else: {

                    $0
                        .class(styles.textColorLabelDisabled)
                        .addClass("cursor-not-allowed")

                }

            showHelperText()
            showErrorMessages()

        }
        .class("ml-3")
    }

    @Builder<Element>
    func showHelperText() -> [Element] {
        if let helperText = data.helperText {
            Div {
                HelperText(helperText).render()
            }
            .id("\(data.id)-helper")
        }
    }

    @Builder<Element>
    func showErrorMessages() -> [Element] {
        if let errorMessages = data.errorMessages {
            Div {
                ErrorMessage(errorMessages).render()
            }
            .id("\(data.id)-error")
            .setAttribute(
                name: "x-show",
                value: "hasServerError"
            )
        }
    }

    func getDescribedBy() -> String? {
        var describedBy: [String] = []
        if data.helperText != nil {
            describedBy.append("\(data.id)-helper")
        }
        if data.errorMessages != nil {
            describedBy.append("\(data.id)-error")
        }
        return describedBy.isEmpty ? nil : describedBy.joined(separator: " ")
    }

    @Builder<Element>
    public func render() -> [Element] {
        let describedBy = getDescribedBy()
        Div {
            Div {
                Div {

                    Input()
                        .id(data.id)
                        .name(data.name ?? data.id)
                        .type(.checkbox)
                        .if(data.isSelected) {
                            $0.checked()
                        }
                        .if(describedBy != nil) {
                            if let describedBy {
                                return $0.setAttribute(
                                    name: "aria-describedby",
                                    value: describedBy
                                )
                            }
                            return $0
                        }
                        .class("h-4 w-4")
                        .if(data.state != .enabled) {

                            $0
                                .disabled()
                                .addClass("cursor-not-allowed")
                        } else: {

                            $0
                                .addClass(styles.focusDefault)
                                .addClass(styles.hoverDefault)
                        }
                        .addClass(styles.textColorCheckbox)

                }
                .class("flex h-6 items-center")

                showLabel()
            }
            .class("relative flex items-start")

        }
        .setAttribute(
            name: "x-data",
            value:
                "{ hasServerError: \(data.errorMessages?.errorMessages != nil ? "true" : "false") }"
        )
        .class("space-y-5")
        .if(data.state != .enabled) {
            $0.addClass("cursor-not-allowed")
        }
    }
}
