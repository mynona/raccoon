import HTML
import Raccoon
import SGML
import WebBuilders

@Builder<Element>
func showConfig(label: String, html: String) -> [Element] {

    Details {
        Summary(">")
            .class(
                [
                    CommonStyles.cursorPointer,
                    CommonStyles.fontMono,
                    CommonStyles.textSizeSmall,
                    CommonStyles.textColorDefault,
                    "select-none",
                ]
                .joined(separator: " ")
            )

        Div {
            showData(label)
            showCode(html)
        }
        .class("flex flex-row space-x-4 mt-6")
    }
    .class("mb-12")
}
