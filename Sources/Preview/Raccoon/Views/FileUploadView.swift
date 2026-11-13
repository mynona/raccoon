import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct FileUploadView: TemplateRepresentable {

    let toasts: [ToastItemData]

    init(toasts: [ToastItemData] = []) {
        self.toasts = toasts
    }

    let variants: [PreviewVariant<SingleFileUploadData>] = [
        #previewVariant(
            tr(
                "Standard Upload",
                [
                    "de": "Standard-Upload",
                    "fr": "Téléversement standard",
                    "es": "Subida estándar",
                    "it": "Caricamento standard",
                    "pt": "Envio padrão",
                    "nl": "Standaard upload",
                    "da": "Standard upload",
                    "sv": "Standarduppladdning",
                    "nb": "Standard opplasting",
                    "fi": "Vakiolataus",
                    "is": "Staðlað upphleðsla",
                    "el": "Τυπική μεταφόρτωση",
                    "tr": "Standart yükleme",
                    "hu": "Szabványos feltöltés",
                    "hr": "Standardni prijenos",
                    "pl": "Standardowe przesyłanie",
                    "sk": "Štandardné nahrávanie",
                    "cs": "Standardní nahrávání",
                    "lb": "Standard-Upload",
                ]
            ),
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
            tr(
                "Upload with Validation Error",
                [
                    "de": "Upload mit Validierungsfehler",
                    "fr": "Téléversement avec erreur de validation",
                    "es": "Subida con error de validación",
                    "it": "Caricamento con errore di validazione",
                    "pt": "Envio com erro de validação",
                    "nl": "Upload met validatiefout",
                    "da": "Upload med valideringsfejl",
                    "sv": "Uppladdning med valideringsfel",
                    "nb": "Opplasting med valideringsfeil",
                    "fi": "Lataus vahvistusvirheellä",
                    "is": "Upphleðsla með sannprófunarvillu",
                    "el": "Μεταφόρτωση με σφάλμα επικύρωσης",
                    "tr": "Doğrulama hatalı yükleme",
                    "hu": "Feltöltés érvényesítési hibával",
                    "hr": "Prijenos s pogreškom provjere",
                    "pl": "Przesyłanie z błędem walidacji",
                    "sk": "Nahrávanie s chybou overenia",
                    "cs": "Nahrávání s chybou ověření",
                    "lb": "Upload mat Validéierungsfeeler",
                ]
            ),
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
            tr(
                "Upload without Label",
                [
                    "de": "Upload ohne Beschriftung",
                    "fr": "Téléversement sans étiquette",
                    "es": "Subida sin etiqueta",
                    "it": "Caricamento senza etichetta",
                    "pt": "Envio sem etiqueta",
                    "nl": "Upload zonder label",
                    "da": "Upload uden etiket",
                    "sv": "Uppladdning utan etikett",
                    "nb": "Opplasting uten etikett",
                    "fi": "Lataus ilman nimikettä",
                    "is": "Upphleðsla án merkis",
                    "el": "Μεταφόρτωση χωρίς ετικέτα",
                    "tr": "Etiketsiz yükleme",
                    "hu": "Feltöltés címke nélkül",
                    "hr": "Prijenos bez oznake",
                    "pl": "Przesyłanie bez etykiety",
                    "sk": "Nahrávanie bez štítku",
                    "cs": "Nahrávání bez popisku",
                    "lb": "Upload ouni Etikett",
                ]
            ),
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

        Basic(toasts: toasts) {

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
                                        target: "/preview/file-upload"
                                    )
                                )
                            )
                            .render()
                        }
                        .class("mt-4")
                    }
                    .class(
                        [
                            "p-6 border mb-8",
                            CommonStyles.borderColorDefault,
                            CommonStyles.cornerRadiusLarge,
                            "bg-tertiary dark:bg-surface-dark",
                        ]
                        .joined(separator: " ")
                    )
                }
                .action("/preview/file-upload")
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
