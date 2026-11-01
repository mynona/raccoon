import HTML
import Raccoon
import SGML
import WebBuilders

/// Shows the variant title above the rendered component.
@Builder<Element>
func showVariantTitle(_ label: LocalizedText, _ ctx: Any) -> [Element] {

    Div {

        H2(label.resolved)
            .localized(label)
            .class(
                ["font-bold", CommonStyles.textColorEmphasized].joined(
                    separator: " "
                )
            )
    }
}
