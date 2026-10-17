import HTML
import Raccoon
import SGML
import Vapor
import WebBuilders

@Builder<Element>
func showData(_ data: String) -> [Element] {

    Div {
        Pre {

            Code(data)
                .class(
                    "whitespace-pre-wrap break-words overflow-x-auto max-w-full"
                )
        }
    }
    .class(
        "font-mono text-sm bg-gray-100 dark:bg-gray-800 text-black dark:text-gray-100 p-4 rounded-md overflow-x-auto"
    )
}

@Builder<Element>
func showCopyableData(_ data: String) -> [Element] {

    Div {
        Div {
            CopyToClipboard(
                CopyToClipboardData(
                    value: data,
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
        }
    }
    .class(
        "relative font-mono text-sm bg-gray-100 dark:bg-gray-800 text-black dark:text-gray-100 p-4 rounded-md overflow-x-auto"
    )
}
