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
        [
            "relative",
            CommonStyles.fontMono,
            CommonStyles.textSizeSmall,
            CommonStyles.textColorDefault,
            "bg-tertiary dark:bg-surface-dark border",
            CommonStyles.borderColorDefault,
            CommonStyles.cornerRadiusMedium,
            "p-4 rounded-md overflow-x-auto",
        ]
        .joined(separator: " ")
    )
}
