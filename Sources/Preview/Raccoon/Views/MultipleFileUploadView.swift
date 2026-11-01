import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct MultipleFileUploadView: TemplateRepresentable {

    let variants: [PreviewVariant<MultipleFileUploadData>] = [
        #previewVariant(
            tr(
                "Multiple Files Upload",
                [
                    "de": "Hochladen mehrerer Dateien",
                    "fr": "Téléversement de plusieurs fichiers",
                    "es": "Subida de varios archivos",
                    "it": "Caricamento di file multipli",
                    "pt": "Envio de múltiplos arquivos",
                    "nl": "Meerdere bestanden uploaden",
                    "da": "Upload af flere filer",
                    "sv": "Uppladdning av flera filer",
                    "nb": "Opplasting av flere filer",
                    "fi": "Useiden tiedostojen lataus",
                    "is": "Hlaða upp mörgum skrám",
                    "el": "Μεταφόρτωση πολλών αρχείων",
                    "tr": "Çoklu dosya yükleme",
                    "hu": "Több fájl feltöltése",
                    "hr": "Prijenos više datoteka",
                    "pl": "Przesyłanie wielu plików",
                    "sk": "Nahrávanie viacerých súborov",
                    "cs": "Nahrávání více souborů",
                    "lb": "Erop luede vu méi Dateien",
                ]
            ),
            MultipleFileUploadData(
                id: "multi-file-upload",
                label: LabelData(
                    id: "multi-label-1",
                    title: tr(
                        "Attach multiple documents",
                        de: "Mehrere Dokumente anhängen",
                        fr: "Joindre plusieurs documents",
                        es: "Adjuntar varios documentos",
                        it: "Allega più documenti"
                    )
                ),
                errorMessages: nil
            )
        ),
        #previewVariant(
            tr(
                "Multiple Files with Validation Error",
                [
                    "de": "Mehrere Dateien mit Validierungsfehler",
                    "fr": "Plusieurs fichiers avec erreur de validation",
                    "es": "Varios archivos con error de validación",
                    "it": "File multipli con errore di validazione",
                    "pt": "Múltiplos arquivos com erro de validação",
                    "nl": "Meerdere bestanden met validatiefout",
                    "da": "Flere filer med valideringsfejl",
                    "sv": "Flera filer med valideringsfel",
                    "nb": "Flere filer med valideringsfeil",
                    "fi": "Useita tiedostoja vahvistusvirheellä",
                    "is": "Margar skrár með sannprófunarvillu",
                    "el": "Πολλά αρχεία με σφάλμα επικύρωσης",
                    "tr": "Doğrulama hatalı çoklu dosya",
                    "hu": "Több fájl érvényesítési hibával",
                    "hr": "Više datoteka s pogreškom provjere",
                    "pl": "Wiele plików z błędem walidacji",
                    "sk": "Viaceré súbory s chybou overenia",
                    "cs": "Více souborů s chybou ověření",
                    "lb": "Méi Dateie mat Validéierungsfeeler",
                ]
            ),
            MultipleFileUploadData(
                id: "multi-file-upload-err",
                label: LabelData(
                    id: "multi-label-2",
                    title: tr(
                        "Upload files",
                        de: "Dateien hochladen",
                        fr: "Téléverser des fichiers",
                        es: "Subir archivos",
                        it: "Carica file"
                    )
                ),
                errorMessages: ErrorMessageData(
                    id: "err-multi-1",
                    errorMessages: [
                        tr(
                            "Files must not exceed 10MB in total.",
                            de:
                                "Die Dateien dürfen insgesamt 10 MB nicht überschreiten.",
                            fr:
                                "Les fichiers ne doivent pas dépasser 10 Mo au total.",
                            es:
                                "Los archivos no deben superar los 10 MB en total.",
                            it: "I file non devono superare 10 MB in totale."
                        )
                    ],
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
                        P(PreviewTexts.uploadMultiple.resolved)
                            .localized(PreviewTexts.uploadMultiple)
                            .class("font-semibold mb-2")
                        Div {
                            InputField(
                                InputFieldData(
                                    id: "alt_text",
                                    label: LabelData(
                                        id: "alt_text",
                                        title: tr(
                                            "Description / Alt text",
                                            de: "Beschreibung / Alternativtext",
                                            fr:
                                                "Description / texte alternatif",
                                            es:
                                                "Descripción / texto alternativo",
                                            it:
                                                "Descrizione / testo alternativo"
                                        )
                                    ),
                                    placeholder: tr(
                                        "Describe the uploaded files",
                                        de:
                                            "Beschreibe die hochgeladenen Dateien",
                                        fr: "Décrivez les fichiers téléversés",
                                        es: "Describe los archivos subidos",
                                        it: "Descrivi i file caricati"
                                    )
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
                                    title: tr(
                                        "Select Files",
                                        de: "Dateien auswählen",
                                        fr: "Sélectionner des fichiers",
                                        es: "Seleccionar archivos",
                                        it: "Seleziona file"
                                    )
                                )
                            )
                        )
                        .render()

                        Div {
                            ActionButton(
                                ActionButtonData(
                                    id: "submit-multi-upload",
                                    label: tr(
                                        "Upload Files",
                                        de: "Dateien hochladen",
                                        fr: "Téléverser les fichiers",
                                        es: "Subir archivos",
                                        it: "Carica file"
                                    ),
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
                        [
                            "p-6 border mb-8",
                            CommonStyles.borderColorDefault,
                            CommonStyles.cornerRadiusLarge,
                            "bg-tertiary dark:bg-surface-dark",
                        ]
                        .joined(separator: " ")
                    )
                }
                .action("/upload/multiple")
                .method(.post)
                .setAttribute(name: "enctype", value: "multipart/form-data")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { MultipleFileUpload(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
