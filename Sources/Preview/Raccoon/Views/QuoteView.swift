import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct QuoteView: TemplateRepresentable {

    let variants: [PreviewVariant<QuoteData>] = [
        #previewVariant(
            tr(
                "With Citation and Quotation Marks",
                [
                    "de": "Mit Zitatangabe und Anführungszeichen",
                    "fr": "Avec citation et guillemets",
                    "es": "Con cita y comillas",
                    "it": "Con citazione e virgolette",
                    "pt": "Com citação e aspas",
                    "nl": "Met citaat en aanhalingstekens",
                    "da": "Med citat og anførselstegn",
                    "sv": "Med citat och citattecken",
                    "nb": "Med sitat og anførselstegn",
                    "fi": "Lainauksella ja lainausmerkeillä",
                    "is": "Með tilvitnun og gæsalöppum",
                    "el": "Με παράθεμα και εισαγωγικά",
                    "tr": "Alıntı ve tırnak işaretleri ile",
                    "hu": "Idézettel és idézőjelekkel",
                    "hr": "S citatom i navodnicima",
                    "pl": "Z cytatem i cudzysłowami",
                    "sk": "S citátom a úvodzovkami",
                    "cs": "S citátem a uvozovkami",
                    "lb": "Mat Zitatugab an Uféierungszeechen",
                ]
            ),
            QuoteData(
                quote:
                    tr(
                        "Design is not just what it looks like and feels like. Design is how it works.",
                        de:
                            "Design ist nicht nur, wie etwas aussieht und sich anfühlt. Design ist, wie es funktioniert.",
                        fr:
                            "Le design, ce n'est pas seulement l'apparence et la sensation. Le design, c'est le fonctionnement.",
                        es:
                            "El diseño no es solo cómo se ve y cómo se siente. El diseño es cómo funciona.",
                        it:
                            "Il design non è solo come appare e come ci si sente. Il design è come funziona."
                    ),
                citation: "Steve Jobs",
                hasQuotationMarks: true
            )
        ),
        #previewVariant(
            tr(
                "With Citation Without Quotation Marks",
                [
                    "de": "Mit Zitatangabe ohne Anführungszeichen",
                    "fr": "Avec citation sans guillemets",
                    "es": "Con cita sin comillas",
                    "it": "Con citazione senza virgolette",
                    "pt": "Com citação sem aspas",
                    "nl": "Met citaat zonder aanhalingstekens",
                    "da": "Med citat uden anførselstegn",
                    "sv": "Med citat utan citattecken",
                    "nb": "Med sitat uten anførselstegn",
                    "fi": "Lainauksella ilman lainausmerkkejä",
                    "is": "Með tilvitnun án gæsalappa",
                    "el": "Με παράθεμα χωρίς εισαγωγικά",
                    "tr": "Tırnak işaretsiz alıntı ile",
                    "hu": "Idézettel idézőjelek nélkül",
                    "hr": "S citatom bez navodnika",
                    "pl": "Z cytatem bez cudzysłowów",
                    "sk": "S citátom bez úvodzoviek",
                    "cs": "S citátem bez uvozovek",
                    "lb": "Mat Zitatugab ouni Uféierungszeechen",
                ]
            ),
            QuoteData(
                quote:
                    tr(
                        "Design is *not* just what it looks like and feels like. Design is **how** it works.",
                        de:
                            "Design ist *nicht* nur, wie etwas aussieht und sich anfühlt. Design ist, **wie** es funktioniert.",
                        fr:
                            "Le design, ce n'est *pas* seulement l'apparence et la sensation. Le design, c'est **le fonctionnement**.",
                        es:
                            "El diseño *no* es solo cómo se ve y cómo se siente. El diseño es **cómo** funciona.",
                        it:
                            "Il design *non* è solo come appare e come ci si sente. Il design è **come** funziona."
                    ),
                citation: "Steve Jobs",
                hasQuotationMarks: false
            )
        ),
        #previewVariant(
            tr(
                "Quote Only Without Citation",
                [
                    "de": "Nur Zitat ohne Quellenangabe",
                    "fr": "Citation seule sans source",
                    "es": "Solo cita sin referencia",
                    "it": "Solo citazione senza fonte",
                    "pt": "Apenas citação sem fonte",
                    "nl": "Alleen citaat zonder bronvermelding",
                    "da": "Kun citat uden kildehenvisning",
                    "sv": "Endast citat utan källhänvisning",
                    "nb": "Kun sitat uten kildeangivelse",
                    "fi": "Vain lainaus ilman lähdeviitettä",
                    "is": "Aðeins tilvitnun án heimildar",
                    "el": "Μόνο παράθεμα χωρίς αναφορά",
                    "tr": "Kaynak gösterilmeden yalnızca alıntı",
                    "hu": "Csak idézet forrás nélkül",
                    "hr": "Samo citat bez navođenja izvora",
                    "pl": "Tylko cytat bez podania źródła",
                    "sk": "Iba citát bez uvedenia zdroja",
                    "cs": "Pouze citát bez uvedení zdroje",
                    "lb": "Nëmmen Zitat ouni Quellenugab",
                ]
            ),
            QuoteData(
                quote: tr(
                    "Ship early, learn fast.",
                    de: "Früh ausliefern, schnell lernen.",
                    fr: "Livrer tôt, apprendre vite.",
                    es: "Lanza pronto, aprende rápido.",
                    it: "Rilascia presto, impara in fretta."
                ),
                citation: nil
            )
        ),
    ]

    func makeHtml(ctx: QuoteData) -> String {
        let html = renderFragments(Quote(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Quote")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { Quote(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
