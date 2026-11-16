import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct RatingView: TemplateRepresentable {

    static let previewCategories = [
        OptionValue(title: tr("Content", de: "Inhalt", fr: "Contenu", es: "Contenido", it: "Contenuto"), value: "content"),
        OptionValue(title: tr("Design", de: "Design", fr: "Design", es: "Diseño", it: "Design"), value: "design"),
        OptionValue(title: tr("Bug / Issue", de: "Fehler / Problem", fr: "Bogue / Problème", es: "Error / Problema", it: "Bug / Problema"), value: "bug"),
        OptionValue(title: tr("Other", de: "Sonstiges", fr: "Autre", es: "Otro", it: "Altro"), value: "other"),
    ]

    let variants: [PreviewVariant<RatingData>] = [
        #previewVariant(
            tr(
                "Thumbs Up/Down Binary Rating with Categories",
                [
                    "de": "Daumen hoch/runter binäre Bewertung mit Kategorien",
                    "fr": "Évaluation binaire pouce vers le haut/bas avec catégories",
                    "es": "Valoración binaria pulgar arriba/abajo con categorías",
                    "it": "Valutazione binaria pollice su/giù con categorie",
                    "pt": "Avaliação binária polegar para cima/para baixo com categorias",
                    "nl": "Duim omhoog/omlaag binaire beoordeling met categorieën",
                    "da": "Tommelfinger op/ned binær bedømmelse med kategorier",
                    "sv": "Tumme upp/ner binär bedömning med kategorier",
                    "nb": "Tommel opp/ned binær vurdering med kategorier",
                    "fi": "Peukku ylös/alas binaarinen arviointi kategorioilla",
                    "is": "Þumall upp/niður tvíundarmat með flokkum",
                    "el": "Δυαδική αξιολόγηση με αντίχειρα πάνω/κάτω με κατηγορίες",
                    "tr": "Başparmak yukarı/aşağı ikili değerlendirme kategorilerle",
                    "hu": "Hüvelykujj fel/le bináris értékelés kategóriákkal",
                    "hr": "Binarno ocjenjivanje palac gore/dolje s kategorijama",
                    "pl": "Ocena binarna kciuk w górę/w dół z kategoriami",
                    "sk": "Binárne hodnotenie palec hore/dole s kategóriami",
                    "cs": "Binární hodnocení palec nahoru/dolů s kategoriemi",
                    "lb": "Daum erop/erof binär Bewäertung mat Kategorien",
                ]
            ),
            RatingData(
                id: "897c1000-0000-0000-0000-000000000000",
                url: "/preview/rating-feedback",
                ratingType: .thumbsUpDown,
                categoryOptions: previewCategories,
                hasCategory: true
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

                showComponentTitle("Rating (Thumbs)")

                // Set cookie so the floating widget is permitted to display in preview
                Script().src("/js-preview/preview-matomo-declined.js")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { Rating(variant.data).render() }
                            .class("mb-4 mt-6")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
