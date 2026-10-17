import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct MultipleFileUploadView: TemplateRepresentable {

    let variants: [(String, MultipleFileUploadData)] = [
        (
            """
            // Multiple file upload
            """,
            MultipleFileUploadData(
                id: "multi-file-upload",
                label: LabelData(
                    id: "multi-label-1",
                    title: "Attach multiple documents"
                ),
                errorMessages: nil
            )
        ),
        (
            """
            // Multiple file upload with error
            """,
            MultipleFileUploadData(
                id: "multi-file-upload-err",
                label: LabelData(
                    id: "multi-label-2",
                    title: "Upload files"
                ),
                errorMessages: ErrorMessageData(
                    id: "err-multi-1",
                    errorMessages: ["Files must not exceed 10MB in total."],
                    hasIcon: true
                )
            )
        ),
    ]

    func makeHtml(ctx: MultipleFileUploadData) -> String {
        let html = renderFragments(MultipleFileUpload(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("MultipleFileUpload")

                Form {
                    Div {
                        P("Test live multiple upload against fake endpoint:")
                            .class("font-semibold mb-2")
                        Div {
                            InputField(
                                InputFieldData(
                                    id: "alt_text",
                                    label: LabelData(
                                        id: "alt_text",
                                        title: "Description / Alt text"
                                    ),
                                    placeholder: "Describe the uploaded files"
                                )
                            )
                            .render()
                        }
                        .class("mb-4")

                        MultipleFileUpload(
                            MultipleFileUploadData(
                                id: "files",
                                label: LabelData(
                                    id: "files",
                                    title: "Select Files"
                                )
                            )
                        )
                        .render()

                        Div {
                            ActionButton(
                                ActionButtonData(
                                    id: "submit-multi-upload",
                                    label: "Upload Files",
                                    htmlType: .submit,
                                    buttonType: .primary,
                                    hasFullWidth: false,
                                    contentTracker: MatomoContentTracker(
                                        name: "upload",
                                        piece: "multiple",
                                        target: "/upload/multiple"
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
                .action("/upload/multiple")
                .method(.post)
                .setAttribute(name: "enctype", value: "multipart/form-data")

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { MultipleFileUpload(ctx).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
