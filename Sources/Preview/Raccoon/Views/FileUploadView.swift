import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct FileUploadView: TemplateRepresentable {

    let variants: [(String, SingleFileUploadData)] = [
        (
            """
            //
            """,
            SingleFileUploadData(
                id: "file-upload",
                label: LabelData(
                    id: "label-1",
                    title: "label"
                ),
                errorMessages: nil
            )
        ),
        (
            """
            //
            """,
            SingleFileUploadData(
                id: "file-upload2",
                label: LabelData(
                    id: "label-1",
                    title: "label"
                ),
                errorMessages: ErrorMessageData(
                    id: "err-1",
                    errorMessages: ["error one"],
                    hasIcon: true
                )
            )
        ),
        (
            """
            // noLabel

            SingleFileUploadData(
                id: "file-upload3",
                label: nil
                errorMessages: ErrorMessageData(
                    ["error one"],
                    id: "err-1-2",
                    showIcon: true
                    )
            )
            """,
            SingleFileUploadData(
                id: "file-upload3",
                errorMessages: ErrorMessageData(
                    id: "err-1-3",
                    errorMessages: ["error one"],
                    hasIcon: true
                )
            )
        ),
    ]

    func makeHtml(ctx: SingleFileUploadData) -> String {
        let html = renderFragments(SingleFileUpload(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("SingleFileUpload")

                Form {
                    Div {
                        P("Test live single upload against fake endpoint:")
                            .class("font-semibold mb-2")
                        Div {
                            InputField(
                                InputFieldData(
                                    id: "alt_text",
                                    label: LabelData(
                                        id: "alt_text",
                                        title: "Alt text"
                                    ),
                                    placeholder: "Describe the image"
                                )
                            )
                            .render()
                        }
                        .class("mb-4")

                        SingleFileUpload(
                            SingleFileUploadData(
                                id: "image",
                                label: LabelData(
                                    id: "image",
                                    title: "Select Image"
                                )
                            )
                        )
                        .render()

                        Div {
                            ActionButton(
                                ActionButtonData(
                                    id: "submit-single-upload",
                                    label: "Upload Image",
                                    htmlType: .submit,
                                    buttonType: .primary,
                                    hasFullWidth: false,
                                    contentTracker: MatomoContentTracker(
                                        name: "upload",
                                        piece: "single",
                                        target: "/upload/single"
                                    )
                                )
                            )
                            .render()
                        }
                        .class("mt-4")
                    }
                    .class(
                        "p-6 border border-gray-300 dark:border-gray-700 rounded-lg mb-8 bg-gray-50 dark:bg-black/20"
                    )
                }
                .action("/upload/single")
                .method(.post)
                .setAttribute(name: "enctype", value: "multipart/form-data")

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { SingleFileUpload(ctx).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
