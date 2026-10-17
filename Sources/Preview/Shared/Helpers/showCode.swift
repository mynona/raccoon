import HTML
import Raccoon
import SGML
import Vapor
import WebBuilders

@Builder<Element>
func showCode(_ data: String) -> [Element] {

    Div {
        Pre {

            Code(data)
                .class(
                    "whitespace-pre-wrap break-words overflow-x-auto max-w-full"
                )
                .tabIndex(-1)
        }
        .tabIndex(-1)
    }
    .class(
        "font-mono bg-gray-100 dark:bg-gray-800 text-black dark:text-gray-100 p-4 text-sm rounded-md overflow-x-auto"
    )
}

@Builder<Element>
func showCopyableCode(_ data: String) -> [Element] {

    Div {
        Div {
            CopyToClipboard(
                CopyToClipboardData(
                    value: unescapeHTML(data),
                    orientation: .horizontal
                )
            )
            .render()
        }
        .class("absolute top-4 right-4 z-10")

        Pre {

            Code(data)
                .class(
                    "whitespace-pre-wrap break-words overflow-x-auto max-w-full block pr-16"
                )
                .tabIndex(-1)
        }
        .tabIndex(-1)
    }
    .class(
        "relative font-mono bg-gray-100 dark:bg-gray-800 text-black dark:text-gray-100 p-4 text-sm rounded-md overflow-x-auto"
    )
}
