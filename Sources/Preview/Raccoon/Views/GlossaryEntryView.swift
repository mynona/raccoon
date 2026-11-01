import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct GlossaryEntryView: TemplateRepresentable {

    let variants: [PreviewVariant<GlossaryEntryData>] = [
        #previewVariant(
            tr(
                "With Initial Letter Badge",
                [
                    "de": "Mit Anfangsbuchstaben-Badge",
                    "fr": "Avec badge de lettre initiale",
                    "es": "Con insignia de letra inicial",
                    "it": "Con badge lettera iniziale",
                    "pt": "Com emblema de letra inicial",
                    "nl": "Met beginletter-badge",
                    "da": "Med forbogstavs-badge",
                    "sv": "Med initialbokstavsbricka",
                    "nb": "Med forbokstav-badge",
                    "fi": "Alkukirjainmerkillä",
                    "is": "Með upphafsstafamerki",
                    "el": "Με σήμα αρχικού γράμματος",
                    "tr": "İlk harf rozetli",
                    "hu": "Kezdőbetűs jelvénnyel",
                    "hr": "Sa značkom početnog slova",
                    "pl": "Z odznaką pierwszej litery",
                    "sk": "S odznakom začiatočného písmena",
                    "cs": "S odznakem počátečního písmene",
                    "lb": "Mat Ufanksbuschtawen-Badge",
                ]
            ),
            GlossaryEntryData(
                term: tr(
                    "Product Thinking",
                    de: "Produktdenken",
                    fr: "Réflexion produit",
                    es: "Pensamiento de producto",
                    it: "Pensiero di prodotto"
                ),
                definition:
                    tr(
                        "Solving the *right* problems by deeply understanding user needs and business context.",
                        de:
                            "Die *richtigen* Probleme lösen, indem man Nutzerbedürfnisse und den Geschäftskontext genau versteht.",
                        fr:
                            "Résoudre les *bons* problèmes en comprenant en profondeur les besoins des utilisateurs et le contexte métier.",
                        es:
                            "Resolver los problemas *correctos* comprendiendo a fondo las necesidades de los usuarios y el contexto de negocio.",
                        it:
                            "Risolvere i problemi *giusti* comprendendo a fondo i bisogni degli utenti e il contesto aziendale."
                    ),
                hasInitial: true
            )
        ),
        #previewVariant(
            tr(
                "Without Initial Letter",
                [
                    "de": "Ohne Anfangsbuchstaben",
                    "fr": "Sans lettre initiale",
                    "es": "Sin letra inicial",
                    "it": "Senza lettera iniziale",
                    "pt": "Sem letra inicial",
                    "nl": "Zonder beginletter",
                    "da": "Uden forbogstav",
                    "sv": "Utan initialbokstav",
                    "nb": "Uten forbokstav",
                    "fi": "Ilman alkukirjainta",
                    "is": "Án upphafsstafs",
                    "el": "Χωρίς αρχικό γράμμα",
                    "tr": "İlk harf olmadan",
                    "hu": "Kezdőbetű nélkül",
                    "hr": "Bez početnog slova",
                    "pl": "Bez pierwszej litery",
                    "sk": "Bez začiatočného písmena",
                    "cs": "Bez počátečního písmene",
                    "lb": "Ouni Ufanksbuschtaf",
                ]
            ),
            GlossaryEntryData(
                term: tr(
                    "Product Thinking",
                    de: "Produktdenken",
                    fr: "Réflexion produit",
                    es: "Pensamiento de producto",
                    it: "Pensiero di prodotto"
                ),
                definition:
                    tr(
                        "Solving the *right* problems by deeply understanding user needs and business context.",
                        de:
                            "Die *richtigen* Probleme lösen, indem man Nutzerbedürfnisse und den Geschäftskontext genau versteht.",
                        fr:
                            "Résoudre les *bons* problèmes en comprenant en profondeur les besoins des utilisateurs et le contexte métier.",
                        es:
                            "Resolver los problemas *correctos* comprendiendo a fondo las necesidades de los usuarios y el contexto de negocio.",
                        it:
                            "Risolvere i problemi *giusti* comprendendo a fondo i bisogni degli utenti e il contesto aziendale."
                    ),
                hasInitial: false
            )
        ),
    ]

    func makeHtml(ctx: GlossaryEntryData) -> String {
        let html = renderFragments(GlossaryEntry(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Glossary Entry")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { GlossaryEntry(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
