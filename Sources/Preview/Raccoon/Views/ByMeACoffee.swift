import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct ByMeACoffeeView: TemplateRepresentable {

    let variants: [PreviewVariant<ByMeACoffeeData>] = [
        #previewVariant(
            tr(
                "Default Button",
                [
                    "de": "Standard-Schaltfläche",
                    "fr": "Bouton standard",
                    "es": "Botón predeterminado",
                    "it": "Pulsante predefinito",
                    "pt": "Botão padrão",
                    "nl": "Standaardknop",
                    "da": "Standardknap",
                    "sv": "Standardknapp",
                    "nb": "Standardknapp",
                    "fi": "Vakiopainike",
                    "is": "Sjálfgefinn hnappur",
                    "el": "Προεπιλεγμένο κουμπί",
                    "tr": "Varsayılan düğme",
                    "hu": "Alapértelmezett gomb",
                    "hr": "Zadani gumb",
                    "pl": "Domyślny przycisk",
                    "sk": "Predvolené tlačidlo",
                    "cs": "Výchozí tlačítko",
                    "lb": "Standard-Knäppchen",
                ]
            ),
            ByMeACoffeeData(
                dataSlug: "support-kaeru",
                imageSrc: "/images/bmc-yellow.png",
                imageHeight: 60,
                imageWidth: 210
            )
        ),
        #previewVariant(
            tr(
                "Button with Matomo",
                [
                    "de": "Schaltfläche mit Matomo",
                    "fr": "Bouton avec Matomo",
                    "es": "Botón con Matomo",
                    "it": "Pulsante con Matomo",
                    "pt": "Botão com Matomo",
                    "nl": "Knop met Matomo",
                    "da": "Knap med Matomo",
                    "sv": "Knapp med Matomo",
                    "nb": "Knapp med Matomo",
                    "fi": "Painike Matomolla",
                    "is": "Hnappur með Matomo",
                    "el": "Κουμπί με Matomo",
                    "tr": "Matomo ile düğme",
                    "hu": "Gomb Matomóval",
                    "hr": "Gumb s Matomom",
                    "pl": "Przycisk z Matomo",
                    "sk": "Tlačidlo s Matomom",
                    "cs": "Tlačítko s Matomem",
                    "lb": "Knäppchen mat Matomo",
                ]
            ),
            ByMeACoffeeData(
                dataSlug: "support-kaeru",
                imageSrc: "/images/bmc-yellow.png",
                imageHeight: 60,
                imageWidth: 210,
                matomoStatus: .ACCEPTED
            )
        ),
    ]

    func makeHtml(ctx: ByMeACoffeeData) -> String {
        let html = renderFragments(ByMeACoffee(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("ByMeACoffee")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { ByMeACoffee(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
