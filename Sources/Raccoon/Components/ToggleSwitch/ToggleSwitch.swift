import HTML
import SGML
import SVG
import WebBuilders

public struct ToggleSwitch: TemplateRepresentable {
    let data: ToggleSwitchData
    typealias styles = ToggleSwitchStyles

    public init(
        _ data: ToggleSwitchData
    ) {
        self.data = data
    }

    @Builder<Element>
    func showLabel() -> [Element] {
        if let label = data.label {
            let title = label.title ?? ""
            let position = label.position
            HTML.Label(title)
                .for("\(data.id)-button")
                .flagAttribute("x-switch:label")
                .class(styles.label)
                .if(position == .left) {
                    $0.addClass("pr-3")
                } else: {
                    $0.addClass("pl-3")
                }
                .if(data.size == .sm) {
                    $0.addClass(styles.textSizeSmall)
                }
                .if(data.size == .base) {
                    $0.addClass(styles.textSizeBase)
                }
                .if(data.size == .xl) {
                    $0.addClass(styles.textSizeLarge)
                }
                .if(data.state != .enabled) {
                    $0.addClass(styles.cursorNotAllowed)
                }
        }
    }

    @Builder<Element>
    func includeHiddenInputToStoreData() -> [Element] {
        // The selected value will be stored in this
        // hidden input field and sent when the form
        // is submitted
        Input()
            .type(.hidden)
            .id(data.id)
            .name(data.id)
            .setAttribute(
                name: ":value",
                value: "value"
            )
    }

    @Builder<Element>
    func showToggleSwitchButton() -> [Element] {
        let labelTitle = data.label?.title
        Button {

            Span {}
                .if(data.size == .sm) {

                    $0
                        .setAttribute(
                            name: ":class",
                            value:
                                "$switch.isChecked ? 'translate-x-3' : 'translate-x-1'"
                        )
                        .addClass("h-2 w-2")

                }
                .if(data.size == .base) {

                    $0
                        .setAttribute(
                            name: ":class",
                            value:
                                "$switch.isChecked ? 'translate-x-5' : 'translate-x-1'"
                        )
                        .addClass("h-3 w-3")

                }
                .if(data.size == .xl) {

                    $0
                        .setAttribute(
                            name: ":class",
                            value:
                                "$switch.isChecked ? 'translate-x-6' : 'translate-x-1'"
                        )
                        .addClass("h-7 w-7")

                }
                .class(
                    styles.toggleKnob
                )

        }
        .id("\(data.id)-button")
        .flagAttribute("x-switch")
        .setAttribute(
            name: "x-model",
            value: "value"
        )
        .setAttribute(
            name: ":class",
            value:
                "$switch.isChecked ? '\(styles.toggleChecked)' : '\(styles.toggleUnchecked)'"
        )
        .class("relative inline-flex py-1 transition flex-none")
        .addClass(styles.cornerRadiusFull)
        .if(data.size == .sm) {
            $0.addClass("w-6")
        }
        .if(data.size == .base) {
            $0.addClass("w-9")
        }
        .if(data.size == .xl) {
            $0.addClass("w-14")
        }
        .if(data.apiURL != nil) {
            if let apiURL = data.apiURL {
                return
                    $0.setAttribute(
                        name: "data-api-url",
                        value: JavaScriptEscaper.htmlAttributeEscape(apiURL)
                    )
                    .setAttribute(
                        name: "@click",
                        value: "updateStatus($el.dataset.apiUrl)"
                    )
            }
            return $0
        }
        .if(data.state != .enabled) {

            $0
                .disabled()
                .addClass(styles.cursorNotAllowed)

        } else: {
            $0.addClass(styles.cursorPointer)
        }
        .if(labelTitle != nil) {
            if let labelTitle {
                return $0.ariaLabel(labelTitle)
            }
            return $0
        } else: {
            $0.ariaLabel("Toggle switch")
        }
        .addClass(styles.focusDefault)
        .addClass(styles.hoverDefault)
        .setAttribute(name: "@click.stop", value: "")
    }

    @Builder<Element>
    public func render() -> [Element] {

        Script()
            .src("/js/toggle.js")

        Div {

            includeHiddenInputToStoreData()

            if data.label?.position == .left { showLabel() }

            showToggleSwitchButton()

            if data.label?.position == .right { showLabel() }

        }
        .setAttribute(
            name: "x-data",
            value:
                "toggleSwitch({ initialValue: \(data.isSelected), apiUrl: \(data.apiURL.map { "'\(JavaScriptEscaper.htmlAttributeEscape($0))'" } ?? "null") })"
        )
        .flagAttribute("x-switch:group")
        .class("flex-none flex items-center ")
    }

}
