import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct BadgeView: TemplateRepresentable {

    let variants: [PreviewVariant<BadgeData>] = [
        #previewVariant(
            tr(
                "Text Only",
                [
                    "de": "Nur Text",
                    "fr": "Texte seul",
                    "es": "Solo texto",
                    "it": "Solo testo",
                    "pt": "Apenas texto",
                    "nl": "Alleen tekst",
                    "da": "Kun tekst",
                    "sv": "Endast text",
                    "nb": "Kun tekst",
                    "fi": "Vain teksti",
                    "is": "Aðeins texti",
                    "el": "Μόνο κείμενο",
                    "tr": "Yalnızca metin",
                    "hu": "Csak szöveg",
                    "hr": "Samo tekst",
                    "pl": "Tylko tekst",
                    "sk": "Iba text",
                    "cs": "Pouze text",
                    "lb": "Nëmmen Text",
                ]
            ),
            BadgeData(
                id: "badge-1",
                title: tr(
                    "New",
                    de: "Neu",
                    fr: "Nouveau",
                    es: "Nuevo",
                    it: "Nuovo"
                )
            )
        ),
        #previewVariant(
            tr(
                "With Counter",
                [
                    "de": "Mit Zähler",
                    "fr": "Avec compteur",
                    "es": "Con contador",
                    "it": "Con contatore",
                    "pt": "Com contador",
                    "nl": "Met teller",
                    "da": "Med tæller",
                    "sv": "Med räknare",
                    "nb": "Med teller",
                    "fi": "Laskurilla",
                    "is": "Með teljara",
                    "el": "Με μετρητή",
                    "tr": "Sayaç ile",
                    "hu": "Számlálóval",
                    "hr": "S brojačem",
                    "pl": "Z licznikiem",
                    "sk": "S počítadlom",
                    "cs": "S počítadlem",
                    "lb": "Mat Zielt",
                ]
            ),
            BadgeData(
                id: "badge-2",
                title: tr(
                    "Messages",
                    de: "Nachrichten",
                    fr: "Messages",
                    es: "Mensajes",
                    it: "Messaggi"
                ),
                counter: 5
            )
        ),
        #previewVariant(
            tr(
                "Interactive Link Badge",
                [
                    "de": "Interaktives Link-Badge",
                    "fr": "Badge de lien interactif",
                    "es": "Insignia de enlace interactiva",
                    "it": "Badge di collegamento interattivo",
                    "pt": "Distintivo de link interativo",
                    "nl": "Interactieve linkbadge",
                    "da": "Interaktivt linkbadge",
                    "sv": "Interaktiv länkbadge",
                    "nb": "Interaktivt lenkebadge",
                    "fi": "Vuorovaikutteinen linkkimerkki",
                    "is": "Gagnvirkt tenglamerki",
                    "el": "Διαδραστικό σήμα συνδέσμου",
                    "tr": "Etkileşimli bağlantı rozeti",
                    "hu": "Interaktív hivatkozásjelvény",
                    "hr": "Interaktivna značka veze",
                    "pl": "Interaktywna odznaka linku",
                    "sk": "Interaktívny odznak odkazu",
                    "cs": "Interaktivní odznak odkazu",
                    "lb": "Interaktivt Link-Badge",
                ]
            ),
            BadgeData(
                id: "badge-3",
                title: tr(
                    "Article",
                    de: "Artikel",
                    fr: "Article",
                    es: "Artículo",
                    it: "Articolo"
                ),
                counter: 100,
                isLink: true
            )
        ),
    ]

    func makeHtml(ctx: BadgeData) -> String {
        let html = renderFragments(Badge(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Badge")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { Badge(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
