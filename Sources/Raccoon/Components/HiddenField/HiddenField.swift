import HTML
import SGML
import WebBuilders

public struct HiddenField: TemplateRepresentable {
    let context: HiddenFieldData

    public init(_ context: HiddenFieldData) {
        self.context = context
    }

    @Builder<Element>
    public func render() -> [Element] {

        switch context.state {

        case .enabled:

            // No id: a hidden input has no label to associate, and `key` repeats across forms
            Input()
                .type(.hidden)
                .name(context.id)
                .value(context.value)

        default:

            Div {}
                .class("hidden")

        }
    }
}
