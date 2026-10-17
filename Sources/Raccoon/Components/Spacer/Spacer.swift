import HTML
import SGML
import SVG
import WebBuilders

public struct Spacer: TemplateRepresentable {

    let data: SpacerData

    func generateSpacer() -> String {
        switch data.space {
        case 1: "pb-1 md:pb-2"
        case 2: "pb-2 md:pb-3"
        case 3: "pb-3 md:pb-4"
        case 4: "pb-4 md:pb-5"
        case 5: "pb-5 md:pb-6"
        case 6: "pb-6 md:pb-7"
        case 7: "pb-7 md:pb-8"
        case 8: "pb-8 md:pb-9"
        case 9: "pb-9 md:pb-10"
        default: "pb-10 md:pb-11"
        }
    }

    public init(
        _ data: SpacerData
    ) {
        self.data = data
    }

    @Builder<Element>
    public func render() -> [Element] {

        DebugComment("Spacer")
        Div {}
            .class(generateSpacer())
            .ariaHidden("true")

    }
}
