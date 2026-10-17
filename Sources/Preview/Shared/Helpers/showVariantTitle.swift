import HTML
import SGML
import WebBuilders

/// Shows the variant's "//" comment above the rendered component.
@Builder<Element>
func showVariantTitle(_ label: String, _ ctx: Any) -> [Element] {

    Div {

        H2(label)
            .class("font-bold text-black dark:text-white")
    }
}
