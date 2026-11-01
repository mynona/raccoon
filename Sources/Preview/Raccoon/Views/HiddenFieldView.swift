import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct HiddenFieldView: TemplateRepresentable {

    let variants: [PreviewVariant<HiddenFieldData>] = [
        #previewVariant(
            tr(
                "Key-Value Hidden Input",
                [
                    "de": "Schlüssel-Wert-verstecktes Eingabefeld",
                    "fr": "Champ masqué clé-valeur",
                    "es": "Campo oculto clave-valor",
                    "it": "Campo nascosto chiave-valore",
                    "pt": "Campo oculto chave-valor",
                    "nl": "Verborgen sleutel-waarde invoer",
                    "da": "Skjult nøgle-værdi-felt",
                    "sv": "Dolt nyckel-värde-fält",
                    "nb": "Skjult nøkkel-verdi-felt",
                    "fi": "Piilotettu avain-arvo-syötekenttä",
                    "is": "Folið lykill-gildi innsláttarsvæði",
                    "el": "Κρυφό πεδίο κλειδιού-τιμής",
                    "tr": "Anahtar-değer gizli giriş",
                    "hu": "Rejtett kulcs-érték bemenet",
                    "hr": "Skriveni unos ključ-vrijednost",
                    "pl": "Ukryte pole klucz-wartość",
                    "sk": "Skryté vstupné pole kľúč-hodnota",
                    "cs": "Skryté vstupní pole klíč-hodnota",
                    "lb": "Schlëssel-Wäert verstoppt Agab",
                ]
            ),
            HiddenFieldData(
                id: "hidden-key",
                value: "hidden-value",
                state: .enabled
            )
        )
    ]

    func makeHtml(ctx: HiddenFieldData) -> String {
        let html = renderFragments(HiddenField(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("HiddenField")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { HiddenField(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
