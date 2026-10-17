import HTML
import SGML
import WebBuilders

@Builder<Element>
func showConfig(label: String, html: String) -> [Element] {

    Details {
        Summary(">")
            .class(
                "cursor-pointer font-mono text-sm text-gray-950 dark:text-gray-400 select-none"
            )

        Div {
            showData(label)
            showCode(html)
        }
        .class("flex flex-row space-x-4 mt-6")
    }
    .class("mb-12")
}
