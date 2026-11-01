import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct DefinitionView: TemplateRepresentable {

    let variants: [PreviewVariant<DefinitionData>] = [
        #previewVariant(
            tr(
                "Term with Icon",
                [
                    "de": "Begriff mit Icon",
                    "fr": "Terme avec icône",
                    "es": "Término con icono",
                    "it": "Termine con icona",
                    "pt": "Termo com ícone",
                    "nl": "Term met pictogram",
                    "da": "Begreb med ikon",
                    "sv": "Term med ikon",
                    "nb": "Begrep med ikon",
                    "fi": "Termi kuvakkeella",
                    "is": "Hugtak með tákni",
                    "el": "Όρος με εικονίδιο",
                    "tr": "Simgeli terim",
                    "hu": "Kifejezés ikonnal",
                    "hr": "Pojam s ikonom",
                    "pl": "Termin z ikoną",
                    "sk": "Pojem s ikonou",
                    "cs": "Pojem s ikonou",
                    "lb": "Begrëff mat Ikon",
                ]
            ),
            DefinitionData(
                term: tr(
                    "Product Thinking",
                    de: "Produktdenken",
                    fr: "Réflexion produit",
                    es: "Pensamiento de producto",
                    it: "Pensiero di prodotto"
                ),
                definition:
                    tr(
                        "Solving the right problems by deeply understanding user needs and business context.",
                        de:
                            "Die richtigen Probleme lösen, indem man Nutzerbedürfnisse und den Geschäftskontext genau versteht.",
                        fr:
                            "Résoudre les bons problèmes en comprenant en profondeur les besoins des utilisateurs et le contexte métier.",
                        es:
                            "Resolver los problemas correctos comprendiendo a fondo las necesidades de los usuarios y el contexto de negocio.",
                        it:
                            "Risolvere i problemi giusti comprendendo a fondo i bisogni degli utenti e il contesto aziendale."
                    ),
                icon: .book
            )
        )
    ]

    func makeHtml(ctx: DefinitionData) -> String {
        let html = renderFragments(Definition(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Definition")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { Definition(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
