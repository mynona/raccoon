import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct LogoView: TemplateRepresentable {

    let variants: [PreviewVariant<LogoData>] = [
        #previewVariant(
            tr(
                "Default Static Logo",
                [
                    "de": "Standardmäßiges statisches Logo",
                    "fr": "Logo statique standard",
                    "es": "Logotipo estático predeterminado",
                    "it": "Logo statico predefinito",
                    "pt": "Logotipo estático padrão",
                    "nl": "Standaard statisch logo",
                    "da": "Standard statisk logo",
                    "sv": "Standard statisk logotyp",
                    "nb": "Standard statisk logo",
                    "fi": "Staattinen vakiologo",
                    "is": "Sjálfgefið fast merki",
                    "el": "Προεπιλεγμένο στατικό λογότυπο",
                    "tr": "Varsayılan statik logo",
                    "hu": "Alapértelmezett statikus logó",
                    "hr": "Zadani statički logotip",
                    "pl": "Domyślne logo statyczne",
                    "sk": "Predvolené statické logo",
                    "cs": "Výchozí statické logo",
                    "lb": "Standard statesche Logo",
                ]
            ),
            LogoData()
        ),
        #previewVariant(
            tr(
                "Linked Logo Destination",
                [
                    "de": "Verlinktes Logo-Ziel",
                    "fr": "Destination du logo avec lien",
                    "es": "Destino del logotipo con enlace",
                    "it": "Destinazione del logo collegata",
                    "pt": "Destino do logotipo com link",
                    "nl": "Gekoppelde logobestemming",
                    "da": "Linket logodestination",
                    "sv": "Länkad logotypdestination",
                    "nb": "Koblet logodestinasjon",
                    "fi": "Linkitetty logon kohde",
                    "is": "Tengdur áfangastaður merkis",
                    "el": "Συνδεδεμένος προορισμός λογοτύπου",
                    "tr": "Bağlantılı logo hedefi",
                    "hu": "Hivatkozott logócél",
                    "hr": "Povezano odredište logotipa",
                    "pl": "Docelowy link z logo",
                    "sk": "Cieľ odkazu s logom",
                    "cs": "Cíl odkazu s logem",
                    "lb": "Verlinkt Logo-Zil",
                ]
            ),
            LogoData(destination: "/")
        ),
    ]

    func makeHtml(ctx: LogoData) -> String {
        let html = renderFragments(Logo(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Logo")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { Logo(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
