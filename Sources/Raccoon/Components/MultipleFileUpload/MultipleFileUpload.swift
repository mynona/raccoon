import HTML
import SGML
import SVG
import WebBuilders

public struct MultipleFileUpload: TemplateRepresentable {
    let data: MultipleFileUploadData
    typealias styles = MultipleFileUploadStyles
    typealias inputFieldStyles = InputFieldStyles

    public init(
        _ data: MultipleFileUploadData
    ) {
        self.data = data
    }

    @Builder<Element>
    func showBrowseOrDragAndDropMessage() -> [Element] {
        Div {
            Span { Svg.icon(.cloud_arrow_up, width: 32, height: 32) }
            P("Browse or drag and drop files here.")
                .class("m-0 pt-2")
        }
        .class("flex flex-col items-center justify-center py-10 text-center")
        .addClass(styles.textColorDefault)
    }

    @Builder<Element>
    func showLabel() -> [Element] {
        if let label = data.label {
            Label(
                LabelData(
                    id: data.id,
                    title: label.title
                )
            )
            .render()
        }
    }

    @Builder<Element>
    func showUploadContainer() -> [Element] {
        Div {

            Input()
                .type(.file)
                .id(data.id)
                .name("\(data.id)[]")
                .flagAttribute("multiple")
                .ariaLabel("Upload multiple files")
                .setAttribute(
                    name: "@change",
                    value: "addFiles($event)"
                )
                .setAttribute(
                    name: "@dragover",
                    value: "isDragging = true"
                )
                .setAttribute(
                    name: "@dragleave",
                    value: "isDragging = false"
                )
                .setAttribute(
                    name: "@drop",
                    value: "isDragging = false"
                )
                .setAttribute(
                    name: "@focus",
                    value: "isFocused = true"
                )
                .setAttribute(
                    name: "@blur",
                    value: "isFocused = false"
                )
                .class(
                    "absolute inset-0 z-50 w-full h-full p-0 m-0 outline-hidden opacity-0 cursor-pointer"
                )

            Div { showBrowseOrDragAndDropMessage() }
                .setAttribute(
                    name: "aria-hidden",
                    value: "true"
                )

        }
        .setAttribute(
            name: "x-ref",
            value: "dnd"
        )
        .class(
            "relative flex flex-col cursor-pointer w-full \(styles.dragAndDropContainer)"
        )
        .setAttribute(
            name: ":class",
            value:
                "{ 'border-blue-400 border-4 border-inset': isDragging, 'ring-2 ring-focusring': isFocused }"
        )
    }

    @Builder<Element>
    func showFileList() -> [Element] {
        FileList(
            FileListData(
                uploadId: data.id,
                hasRemoveAction: true,
                contentTracker: MatomoContentTracker(
                    name: "multiple-file-upload",
                    piece: "button.remove",
                    target: ""
                )
            )
        )
        .render()
    }

    @Builder<Element>
    func showErrorMessages() -> [Element] {
        if let errorMessages = data.errorMessages {
            Div {
                ErrorMessage(errorMessages).render()
            }
            .setAttribute(
                name: "x-show",
                value: "hasServerError"
            )
        }
    }

    @Builder<Element>
    public func render() -> [Element] {
        DebugComment("Multiple file upload")
        Script()
            .src("/js/file-upload.js")
            .setAttribute(
                name: "type",
                value: "text/javascript"
            )

        Div {

            Div {

                Div {

                    showLabel()

                    Div {

                        Div {

                            showUploadContainer()
                            showFileList()

                        }
                        .setAttribute(
                            name: "x-data",
                            value: "multipleFileDnD('\(data.id)')"
                        )
                        .class(
                            "relative flex flex-col w-full"
                        )
                        .addClass(styles.containerFont)

                    }
                    .class("rounded-md mx-auto")
                    .if(data.label != nil) {
                        $0.addClass("pt-2.5")
                    }

                }
                .class("p-4")

            }
            .class("w-full")
            .addClass(inputFieldStyles.inputBorder)
            .setAttribute(
                name: ":class",
                value:
                    "{ '\(inputFieldStyles.borderColorError)': hasServerError, '\(inputFieldStyles.borderColorDefault)': !hasServerError }"
            )

            showErrorMessages()

        }
        .setAttribute(
            name: "x-data",
            value:
                """
                { 
                  hasServerError: \(data.errorMessages != nil ? "true" : "false"),
                }
                """
        )

    }

}
