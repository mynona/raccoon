import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct ViewMasekedSecretView: TemplateRepresentable {

    let variants: [PreviewVariant<ViewMaskedSecretData>] = [
        #previewVariant(
            tr(
                "Masked Secret without Copy Action",
                [
                    "de": "Maskiertes Geheimnis ohne Kopieraktion",
                    "fr": "Secret masqué sans action de copie",
                    "es": "Secreto enmascarado sin acción de copiar",
                    "it": "Segreto mascherato senza azione di copia",
                    "pt": "Segredo mascarado sem ação de copiar",
                    "nl": "Gemaskerd geheim zonder kopieeractie",
                    "da": "Maskeret hemmelighed uden kopieringshandling",
                    "sv": "Maskerad hemlighet utan kopieringsåtgärd",
                    "nb": "Maskert hemmelighet uten kopieringshandling",
                    "fi": "Peitetty salaisuus ilman kopiointitoimintoa",
                    "is": "Hulin leyndarmál án afritunaraðgerðar",
                    "el": "Μασκαρεμένο μυστικό χωρίς ενέργεια αντιγραφής",
                    "tr": "Kopyalama eylemsiz maskelenmiş gizli bilgi",
                    "hu": "Maszkolt titok másolási művelet nélkül",
                    "hr": "Maskirana tajna bez radnje kopiranja",
                    "pl": "Zamaskowany sekret bez akcji kopiowania",
                    "sk": "Maskované tajomstvo bez akcie kopírovania",
                    "cs": "Maskované tajemství bez akce kopírování",
                    "lb": "Maskéiert Geheimnis ouni Kopéieraktioun",
                ]
            ),
            ViewMaskedSecretData(
                secret: "super-secret-token-12345",
                revealCount: 4,
                hasCopyToClipboard: false
            )
        ),
        #previewVariant(
            tr(
                "Masked Secret with Copy Action",
                [
                    "de": "Maskiertes Geheimnis mit Kopieraktion",
                    "fr": "Secret masqué avec action de copie",
                    "es": "Secreto enmascarado con acción de copiar",
                    "it": "Segreto mascherato con azione di copia",
                    "pt": "Segredo mascarado com ação de copiar",
                    "nl": "Gemaskerd geheim met kopieeractie",
                    "da": "Maskeret hemmelighed med kopieringshandling",
                    "sv": "Maskerad hemlighet med kopieringsåtgärd",
                    "nb": "Maskert hemmelighet med kopieringshandling",
                    "fi": "Peitetty salaisuus kopiointitoiminnolla",
                    "is": "Hulin leyndarmál með afritunaraðgerð",
                    "el": "Μασκαρεμένο μυστικό με ενέργεια αντιγραφής",
                    "tr": "Kopyalama eylemli maskelenmiş gizli bilgi",
                    "hu": "Maszkolt titok másolási művelettel",
                    "hr": "Maskirana tajna s radnjom kopiranja",
                    "pl": "Zamaskowany sekret z akcją kopiowania",
                    "sk": "Maskované tajomstvo s akciou kopírovania",
                    "cs": "Maskované tajemství s akcí kopírování",
                    "lb": "Maskéiert Geheimnis mat Kopéieraktioun",
                ]
            ),
            ViewMaskedSecretData(
                secret: "'ä:ß/\"super-secret-token-12345",
                revealCount: 4,
                hasCopyToClipboard: true
            )
        ),
    ]

    func makeHtml(ctx: ViewMaskedSecretData) -> String {
        let html = renderFragments(ViewMaskedSecret(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("ViewMaskedSecret")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { ViewMaskedSecret(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
