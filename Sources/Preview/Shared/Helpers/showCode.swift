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
        [
            CommonStyles.fontMono,
            CommonStyles.textSizeSmall,
            CommonStyles.textColorDefault,
            "bg-tertiary dark:bg-surface-dark border",
            CommonStyles.borderColorDefault,
            CommonStyles.cornerRadiusMedium,
            "p-4 overflow-x-auto",
        ]
        .joined(separator: " ")
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
        [
            "relative",
            CommonStyles.fontMono,
            CommonStyles.textSizeSmall,
            CommonStyles.textColorDefault,
            "bg-tertiary dark:bg-surface-dark border",
            CommonStyles.borderColorDefault,
            CommonStyles.cornerRadiusMedium,
            "p-4 overflow-x-auto",
        ]
        .joined(separator: " ")
    )
}
