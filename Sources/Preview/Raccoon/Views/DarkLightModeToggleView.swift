import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct DarkLightModeToggleView: TemplateRepresentable {

    let variants: [PreviewVariant<DarkLightModeToggleData>] = [
        #previewVariant(
            tr(
                "Default Toggle",
                [
                    "de": "Standard-Umschalter",
                    "fr": "Bascule standard",
                    "es": "Interruptor predeterminado",
                    "it": "Interruttore predefinito",
                    "pt": "Alternador padrão",
                    "nl": "Standaard tuimelschakelaar",
                    "da": "Standard omskifter",
                    "sv": "Standardväxlare",
                    "nb": "Standard vekslebryter",
                    "fi": "Vakiokytkin",
                    "is": "Sjálfgefinn rofi",
                    "el": "Προεπιλεγμένος διακόπτης",
                    "tr": "Varsayılan geçiş anahtarı",
                    "hu": "Alapértelmezett kapcsoló",
                    "hr": "Zadani preklopnik",
                    "pl": "Domyślny przełącznik",
                    "sk": "Predvolený prepínač",
                    "cs": "Výchozí přepínač",
                    "lb": "Standard-Ëmschalter",
                ]
            ),
            DarkLightModeToggleData()
        ),
        #previewVariant(
            tr(
                "Toggle with Matomo",
                [
                    "de": "Umschalter mit Matomo",
                    "fr": "Bascule avec Matomo",
                    "es": "Interruptor con Matomo",
                    "it": "Interruttore con Matomo",
                    "pt": "Alternador com Matomo",
                    "nl": "Tuimelschakelaar met Matomo",
                    "da": "Omskifter med Matomo",
                    "sv": "Växlare med Matomo",
                    "nb": "Vekslebryter med Matomo",
                    "fi": "Kytkin Matomolla",
                    "is": "Rofi með Matomo",
                    "el": "Διακόπτης με Matomo",
                    "tr": "Matomo ile geçiş anahtarı",
                    "hu": "Kapcsoló Matomóval",
                    "hr": "Preklopnik s Matomom",
                    "pl": "Przełącznik z Matomo",
                    "sk": "Prepínač s Matomom",
                    "cs": "Přepínač s Matomem",
                    "lb": "Ëmschalter mat Matomo",
                ]
            ),
            DarkLightModeToggleData(
                id: "darkLightModeToggle",
                matomoStatus: .ACCEPTED
            )
        ),
    ]

    func makeHtml(ctx: DarkLightModeToggleData) -> String {
        let html = renderFragments(DarkLightModeToggle(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Dark Light Mode Toggle")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { DarkLightModeToggle(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
