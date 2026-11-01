import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct ModalDeleteView: TemplateRepresentable {

    let variants: [PreviewVariant<DeleteModalData>] = [
        #previewVariant(
            tr(
                "Standard Confirmation Dialog",
                [
                    "de": "Standard-Bestätigungsdialog",
                    "fr": "Boîte de dialogue de confirmation standard",
                    "es": "Diálogo de confirmación estándar",
                    "it": "Finestra di dialogo di conferma standard",
                    "pt": "Diálogo de confirmação padrão",
                    "nl": "Standaard bevestigingsdialoog",
                    "da": "Standard bekræftelsesdialog",
                    "sv": "Standard bekräftelsedialog",
                    "nb": "Standard bekreftelsesdialog",
                    "fi": "Vakiovahvistusikkuna",
                    "is": "Staðlaður staðfestingargluggi",
                    "el": "Τυπικός διάλογος επιβεβαίωσης",
                    "tr": "Standart onay iletişim kutusu",
                    "hu": "Szabványos megerősítő párbeszédpanel",
                    "hr": "Standardni dijaloški okvir potvrde",
                    "pl": "Standardowe okno dialogowe potwierdzenia",
                    "sk": "Štandardný potvrdzovací dialóg",
                    "cs": "Standardní potvrzovací dialog",
                    "lb": "Standard-Bestätegungsdialog",
                ]
            ),
            DeleteModalData(
                deletionRedirect: "/items",
                csrfToken: "tok_abc123"
            )
        ),
        #previewVariant(
            tr(
                "Second Independent Modal Instance",
                [
                    "de": "Zweite unabhängige Modal-Instanz",
                    "fr": "Deuxième instance modale indépendante",
                    "es": "Segunda instancia modal independiente",
                    "it": "Seconda istanza modale indipendente",
                    "pt": "Segunda instância modal independente",
                    "nl": "Tweede onafhankelijke modale instantie",
                    "da": "Anden uafhængig modalforekomst",
                    "sv": "Andra oberoende modala instansen",
                    "nb": "Andre uavhengige modale forekomst",
                    "fi": "Toinen itsenäinen modaali-instanssi",
                    "is": "Önnur óháð sprettigluggatilvik",
                    "el": "Δεύτερο ανεξάρτητο στιγμιότυπο modal",
                    "tr": "İkinci bağımsız modal örneği",
                    "hu": "Második független modális példány",
                    "hr": "Druga neovisna modalna instanca",
                    "pl": "Druga niezależna instancja modala",
                    "sk": "Druhá nezávislá modálna inštancia",
                    "cs": "Druhá nezávislá modální instance",
                    "lb": "Zweet onofhängeg Modal-Instanz",
                ]
            ),
            DeleteModalData(
                deletionRedirect: "/records",
                csrfToken: "tok_def456"
            )
        ),
    ]

    func makeHtml(ctx: DeleteModalData) -> String {
        let html = renderFragments(DeleteModal(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("DeleteModal")

                Span {
                    ActionButton(
                        ActionButtonData(
                            id: "buttonOpenDeleteModal",
                            action: "/system/client-delete/uuid",
                            method: .post,
                            label: tr(
                                "Delete",
                                de: "Löschen",
                                fr: "Supprimer",
                                es: "Eliminar",
                                it: "Elimina"
                            ),
                            htmlType: .button,
                            buttonType: .warning,
                            contentTracker: MatomoContentTracker(
                                name: "client",
                                piece: "button.delete",
                                target: "/system/client-delete/uui"
                            )
                        )
                    )
                    .render()
                }
                .setAttribute(
                    name: "x-on:click",
                    value: "open = true"
                )
                .setAttribute(
                    name: "@click",
                    value: "$store.modal = true"
                )

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { DeleteModal(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")
            .setAttribute(
                name: "x-data",
                value: "{ open: false }"
            )

        }
        .render()

    }
}
