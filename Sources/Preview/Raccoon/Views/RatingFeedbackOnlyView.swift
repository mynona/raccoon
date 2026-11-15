import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct RatingFeedbackOnlyView: TemplateRepresentable {

    static let previewCategories = [
        OptionValue(title: tr("Content", de: "Inhalt", fr: "Contenu", es: "Contenido", it: "Contenuto"), value: "content"),
        OptionValue(title: tr("Design", de: "Design", fr: "Design", es: "Diseño", it: "Design"), value: "design"),
        OptionValue(title: tr("Bug / Issue", de: "Fehler / Problem", fr: "Bogue / Problème", es: "Error / Problema", it: "Bug / Problema"), value: "bug"),
        OptionValue(title: tr("Other", de: "Sonstiges", fr: "Autre", es: "Otro", it: "Altro"), value: "other"),
    ]

    let variants: [PreviewVariant<RatingData>] = [
        #previewVariant(
            tr(
                "Feedback Only (No Rating, with Categories)",
                [
                    "de": "Nur Feedback (ohne Bewertung, mit Kategorien)",
                    "fr": "Retour uniquement (sans évaluation, avec catégories)",
                    "es": "Solo comentarios (sin valoración, con categorías)",
                    "it": "Solo feedback (senza valutazione, con categorie)",
                    "pt": "Apenas feedback (sem avaliação, com categorias)",
                    "nl": "Alleen feedback (geen beoordeling, met categorieën)",
                    "da": "Kun feedback (ingen bedømmelse, med kategorier)",
                    "sv": "Endast feedback (inget betyg, med kategorier)",
                    "nb": "Kun tilbakemelding (ingen vurdering, med kategorier)",
                    "fi": "Vain palaute (ei arviota, kategorioilla)",
                    "is": "Aðeins endurgjöf (engin einkunn, með flokkum)",
                    "el": "Μόνο σχόλια (χωρίς αξιολόγηση, με κατηγορίες)",
                    "tr": "Yalnızca geri bildirim (derecelendirme yok, kategoriler var)",
                    "hu": "Csak visszajelzés (értékelés nélkül, kategóriákkal)",
                    "hr": "Samo povratne informacije (bez ocjene, s kategorijama)",
                    "pl": "Tylko opinia (bez oceny, z kategoriami)",
                    "sk": "Iba spätná väzba (bez hodnotenia, s kategóriami)",
                    "cs": "Pouze zpětná vazba (bez hodnocení, s kategoriemi)",
                    "lb": "Nëmme Feedback (ouni Bewäertung, mat Kategorien)",
                ]
            ),
            RatingData(
                id: "222c1000-0000-0000-0000-000000000000",
                url: "/preview/rating-feedback",
                categoryOptions: previewCategories,
                hasCategory: true,
                hasLikertRating: false
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

                showComponentTitle("Rating (Feedback Only)")

                // Set cookie so the floating widget is permitted to display in preview
                Script().src("/js-preview/matomo-declined.js")

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
