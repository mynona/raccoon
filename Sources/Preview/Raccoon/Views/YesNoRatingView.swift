import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct YesNoRatingView: TemplateRepresentable {

    let variants: [PreviewVariant<YesNoRatingData>] = [
        #previewVariant(
            tr(
                "Standard Yes/No Article Rating",
                [
                    "de": "Standard Ja/Nein Artikel-Bewertung",
                    "fr": "Évaluation standard de l'article Oui/Non",
                    "es": "Valoración estándar de artículo Sí/No",
                    "it": "Valutazione standard dell'articolo Sì/No",
                    "pt": "Avaliação padrão do artigo Sim/Não",
                    "nl": "Standaard Ja/Nee artikel-beoordeling",
                    "da": "Standard Ja/Nej artikelbedømmelse",
                    "sv": "Standard Ja/Nej artikelbetyg",
                    "nb": "Standard Ja/Nei artikkelvurdering",
                    "fi": "Kyllä/Ei-artikkelinarviointi",
                    "is": "Hefðbundið Já/Nei greinamat",
                    "el": "Τυπική αξιολόγηση άρθρου Ναι/Όχι",
                    "tr": "Standart Evet/Hayır makale değerlendirmesi",
                    "hu": "Hagyományos Igen/Nem cikkértékelés",
                    "hr": "Standardno ocjenjivanje članka Da/Ne",
                    "pl": "Standardowa ocena artykułu Tak/Nie",
                    "sk": "Štandardné hodnotenie článku Áno/Nie",
                    "cs": "Standardní hodnocení článku Ano/Ne",
                    "lb": "Standard Jo/Nee Artikel-Bewäertung",
                ]
            ),
            YesNoRatingData(
                id: "900c1000-0000-0000-0000-000000000000",
                url: "/preview/rating-feedback"
            )
        ),
        #previewVariant(
            tr(
                "Yes/No Rating with Error Handling",
                [
                    "de": "Ja/Nein Bewertung mit Fehlerbehandlung",
                    "fr": "Évaluation Oui/Non avec gestion des erreurs",
                    "es": "Valoración Sí/No con gestión de errores",
                    "it": "Valutazione Sì/No con gestione errori",
                    "pt": "Avaliação Sim/Não com tratamento de erros",
                    "nl": "Ja/Nee beoordeling met foutafhandeling",
                    "da": "Ja/Nej bedømmelse med fejlhåndtering",
                    "sv": "Ja/Nej betyg med felhantering",
                    "nb": "Ja/Nei vurdering med feilhåndtering",
                    "fi": "Kyllä/Ei-arviointi virheenkäsittelyllä",
                    "is": "Já/Nei mat með villumeðhöndlun",
                    "el": "Αξιολόγηση Ναι/Όχι με διαχείριση σφαλμάτων",
                    "tr": "Hata işlemeli Evet/Hayır değerlendirmesi",
                    "hu": "Igen/Nem értékelés hibakezeléssel",
                    "hr": "Da/Ne ocjenjivanje s obradom pogrešaka",
                    "pl": "Ocena Tak/Nie z obsługą błędów",
                    "sk": "Hodnotenie Áno/Nie s ošetrením chýb",
                    "cs": "Hodnocení Ano/Ne s ošetřením chyb",
                    "lb": "Jo/Nee Bewäertung mat Feelerbehandlung",
                ]
            ),
            YesNoRatingData(
                id: "901c1000-0000-0000-0000-000000000000",
                url: "/error"
            )
        ),
    ]

    func makeHtml(ctx: YesNoRatingData) -> String {
        let html = renderFragments(YesNoRating(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("YesNoRating")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { YesNoRating(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
