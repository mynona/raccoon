import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct RatingView: TemplateRepresentable {

    let variants: [PreviewVariant<RatingData>] = [
        #previewVariant(
            tr(
                "Thumbs Up/Down Binary Rating",
                [
                    "de": "Daumen hoch/runter binäre Bewertung",
                    "fr": "Évaluation binaire pouce vers le haut/bas",
                    "es": "Valoración binaria pulgar arriba/abajo",
                    "it": "Valutazione binaria pollice su/giù",
                    "pt": "Avaliação binária polegar para cima/para baixo",
                    "nl": "Duim omhoog/omlaag binaire beoordeling",
                    "da": "Tommelfinger op/ned binær bedømmelse",
                    "sv": "Tumme upp/ner binär bedömning",
                    "nb": "Tommel opp/ned binær vurdering",
                    "fi": "Peukku ylös/alas binaarinen arviointi",
                    "is": "Þumall upp/niður tvíundarmat",
                    "el": "Δυαδική αξιολόγηση με αντίχειρα πάνω/κάτω",
                    "tr": "Başparmak yukarı/aşağı ikili değerlendirme",
                    "hu": "Hüvelykujj fel/le bináris értékelés",
                    "hr": "Binarno ocjenjivanje palac gore/dolje",
                    "pl": "Ocena binarna kciuk w górę/w dół",
                    "sk": "Binárne hodnotenie palec hore/dole",
                    "cs": "Binární hodnocení palec nahoru/dolů",
                    "lb": "Daum erop/erof binär Bewäertung",
                ]
            ),
            RatingData(
                id: "897c1000-0000-0000-0000-000000000000",
                url: "/success",
                ratingType: .thumbsUpDown
            )
        ),
        #previewVariant(
            tr(
                "Five Stars with Error Handling",
                [
                    "de": "Fünf Sterne mit Fehlerbehandlung",
                    "fr": "Cinq étoiles avec gestion des erreurs",
                    "es": "Cinco estrellas con gestión de errores",
                    "it": "Cinque stelle con gestione errori",
                    "pt": "Cinco estrelas com tratamento de erros",
                    "nl": "Vijf sterren met foutafhandeling",
                    "da": "Fem stjerner med fejlhåndtering",
                    "sv": "Fem stjärnor med felhantering",
                    "nb": "Fem stjerner med feilhåndtering",
                    "fi": "Viisi tähteä virheenkäsittelyllä",
                    "is": "Fimm stjörnur með villumeðhöndlun",
                    "el": "Πέντε αστέρια με διαχείριση σφαλμάτων",
                    "tr": "Hata işlemeli beş yıldız",
                    "hu": "Öt csillag hibakezeléssel",
                    "hr": "Pet zvjezdica s obradom pogrešaka",
                    "pl": "Pięć gwiazdek z obsługą błędów",
                    "sk": "Päť hviezdičiek s ošetrením chýb",
                    "cs": "Pět hvězdiček s ošetřením chyb",
                    "lb": "Fënnef Stären mat Feelerbehandlung",
                ]
            ),
            RatingData(
                id: "111c1000-0000-0000-0000-000000000000",
                url: "/error",
                ratingType: .fiveStars
            )
        ),
    ]

    func makeHtml(ctx: RatingData) -> String {
        let html = renderFragments(Rating(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Rating")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { Rating(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
