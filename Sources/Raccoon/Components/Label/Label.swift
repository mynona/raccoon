import HTML
import SGML
import WebBuilders

public struct Label: TemplateRepresentable {
    let data: LabelData
    typealias styles = LabelStyles

    public init(
        _ data: LabelData
    ) {
        self.data = data
    }

    @Builder<Element>
    func showRequired() -> [Element] {
        if data.isRequired {
            Span { Svg.icon(.asterisk, width: 8, height: 8) }
                .setAttribute(
                    name: "aria-hidden",
                    value: "true"
                )
            Span("(required)")
                .class("sr-only")
        }
    }

    @Builder<Element>
    public func render() -> [Element] {

        DebugComment("Label")
        Div {

            HTML.Label {

                Span("\(data.title ?? data.id.capitalized)")
                    .if(data.xhtml != nil) {
                        $0.setAttribute(
                            name: "x-html",
                            value: "\(data.xhtml!)"
                        )
                    }

                showRequired()
            }
            .id("label-\(data.id)")
            .class("flex space-x-1 items-center")
            .addClass(styles.font)
            .if(data.isDisabled) {

                $0
                    .addClass(styles.textColorDisabled)
                    .addClass(styles.cursorNotAllowed)

            } else: {
                $0.addClass(styles.textColorDefault)
            }
            .if(data.size == .sm) {
                $0.addClass(styles.textSizeTiny)
            }
            .if(data.size == .base) {
                $0.addClass(styles.textSizeBase)
            }
            .if(data.size == .xl) {
                $0.addClass(styles.textSizeLarge)
            }
            .for(data.id)

        }
        .class("w-full flex")
        .if(data.position == .right) {
            $0.addClass("justify-end")
        }
        .if(data.position == .left) {
            $0.addClass("justify-start")
        }

    }
}
