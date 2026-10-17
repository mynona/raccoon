import HTML
import SGML
import SVG
import WebBuilders

public struct ErrorMessage: TemplateRepresentable {
    let data: ErrorMessageData
    typealias styles = ErrorMessageStyles

    public init(
        _ data: ErrorMessageData
    ) {
        self.data = data
    }

    @Builder<Element>
    func showIcon() -> [Element] {
        Span { Svg.icon(.dash_circle) }
            .class("flex-none")
            .addClass(styles.textColorError)
            .setAttribute(
                name: "aria-hidden",
                value: "true"
            )
    }

    @Builder<Element>
    public func render() -> [Element] {

        DebugComment("Error Message")
        if let errors = data.errorMessages, !errors.isEmpty {
            Div {
                for (index, error) in errors.enumerated() {
                    Div {
                        if data.hasIcon { showIcon() }
                        Div { P("\(error)") }.class("flex-1")
                    }
                    .if(data.id != nil) {
                        if let id = data.id {
                            return $0.id("\(id)-error-\(index)")
                        }
                        return $0
                    }
                    .class("flex space-x-2 items-center mt-2")
                    .addClass(styles.textSizeSmall)
                    .addClass(styles.textColorError)
                }
            }
            .role("alert")
            .setAttribute(name: "aria-atomic", value: "true")
        }
    }
}
