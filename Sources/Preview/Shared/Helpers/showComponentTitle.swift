import HTML
import SGML
import WebBuilders

@Builder<Element>
func showComponentTitle(_ title: String) -> [Element] {

    Div {
        H1(title)
    }
    .class("mb-8 text-2xl font-bold text-black dark:text-white")
}
