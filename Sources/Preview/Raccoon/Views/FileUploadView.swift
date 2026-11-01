import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct FileUploadView: TemplateRepresentable {

    let variants: [PreviewVariant<SingleFileUploadData>] = [
        #previewVariant(
            "Standard Upload",
            SingleFileUploadData(
                id: "file-upload",
                label: LabelData(
                    id: "label-1",
                    title: tr(
                        "label",
                        de: "Beschriftung",
                        fr: "libellé",
                        es: "etiqueta",
                        it: "etichetta"
                    )
                ),
                errorMessages: nil
            )
        ),
        #previewVariant(
            "Upload with Validation Error",
            SingleFileUploadData(
                id: "file-upload2",
                label: LabelData(
                    id: "label-1",
                    title: tr(
                        "label",
                        de: "Beschriftung",
                        fr: "libellé",
                        es: "etiqueta",
                        it: "etichetta"
                    )
                ),
                errorMessages: ErrorMessageData(
                    id: "err-1",
                    errorMessages: [
                        tr(
                            "error one",
                            de: "Fehler eins",
                            fr: "erreur un",
                            es: "error uno",
                            it: "errore uno"
                        )
                    ],
                    hasIcon: true
                )
            )
        ),
        #previewVariant(
            "Upload without Label",
            SingleFileUploadData(
                id: "file-upload3",
                errorMessages: ErrorMessageData(
                    id: "err-1-3",
                    errorMessages: [
                        tr(
                            "error one",
                            de: "Fehler eins",
                            fr: "erreur un",
                            es: "error uno",
                            it: "errore uno"
                        )
                    ],
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
                        P(PreviewTexts.uploadSingle.resolved)
                            .localized(PreviewTexts.uploadSingle)
                            .class("font-semibold mb-2")
                        Div {
                            InputField(
                                InputFieldData(
                                    id: "alt_text",
                                    label: LabelData(
                                        id: "alt_text",
                                        title: tr(
                                            "Alt text",
                                            de: "Alternativtext",
                                            fr: "Texte alternatif",
                                            es: "Texto alternativo",
                                            it: "Testo alternativo"
                                        )
                                    ),
                                    placeholder: tr(
                                        "Describe the image",
                                        de: "Beschreibe das Bild",
                                        fr: "Décrivez l'image",
                                        es: "Describe la imagen",
                                        it: "Descrivi l'immagine"
                                    )
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
                                    title: tr(
                                        "Select Image",
                                        de: "Bild auswählen",
                                        fr: "Sélectionner une image",
                                        es: "Seleccionar imagen",
                                        it: "Seleziona immagine"
                                    )
                                )
                            )
                        )
                        .render()

                        Div {
                            ActionButton(
                                ActionButtonData(
                                    id: "submit-single-upload",
                                    label: tr(
                                        "Upload Image",
                                        de: "Bild hochladen",
                                        fr: "Téléverser l'image",
                                        es: "Subir imagen",
                                        it: "Carica immagine"
                                    ),
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

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { SingleFileUpload(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
