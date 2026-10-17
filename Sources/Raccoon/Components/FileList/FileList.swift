import HTML
import SGML
import SVG
import WebBuilders

public struct FileList: TemplateRepresentable {
    let data: FileListData
    typealias styles = FileListStyles

    public init(_ data: FileListData = .init()) {
        self.data = data
    }

    @Builder<Element>
    public func render() -> [Element] {
        let uploadPrefix = data.uploadId ?? "file-upload"

        Template {
            Div {
                Template {
                    Div {
                        Div {
                            Svg.icon(
                                .file_earmark,
                                width: 24,
                                height: 24
                            )
                        }
                        .class("ps-4")
                        .addClass(styles.textColorDefault)

                        Div {
                            Span("")
                                .setAttribute(
                                    name: "x-text",
                                    value: "file.name"
                                )
                                .class(
                                    "w-full text-left truncate"
                                )
                                .addClass(styles.textColorDefault)

                            Span("")
                                .setAttribute(
                                    name: "x-text",
                                    value:
                                        "typeof formatSize === 'function' ? formatSize(file.size) : fileSize"
                                )
                                .class(
                                    "text-left"
                                )
                                .addClass(styles.metaTextSize)
                                .addClass(styles.textColorDefault)
                        }
                        .class("flex-1 flex flex-col px-4 truncate")

                        if data.hasRemoveAction {
                            ActionButton(
                                ActionButtonData(
                                    id: "btnRemove",
                                    bindId:
                                        "'btnRemove-\(uploadPrefix)-' + index",
                                    clickAction: "remove(index)",
                                    label: nil,
                                    ariaLabel: "Remove file",
                                    bindTooltipId:
                                        "'tooltip-\(uploadPrefix)-' + index",
                                    tooltip: "Remove file",
                                    tooltipPosition: .top,
                                    htmlType: .button,
                                    buttonType: .icon,
                                    state: .enabled,
                                    size: .base,
                                    hasFullWidth: false,
                                    icon: .trash3,
                                    iconPosition: .left,
                                    contentTracker: data.contentTracker
                                        ?? MatomoContentTracker(
                                            name: "file-upload",
                                            piece: "button.remove",
                                            target: ""
                                        )
                                )
                            )
                            .render()
                        }
                    }
                    .setAttribute(
                        name: ":data-index",
                        value: "index"
                    )
                    .class(styles.row)
                }
                .setAttribute(
                    name: "x-for",
                    value: "(file, index) in Array.from(files)"
                )
            }
            .class(styles.container)
        }
        .setAttribute(
            name: "x-if",
            value: "files.length > 0"
        )
    }
}
