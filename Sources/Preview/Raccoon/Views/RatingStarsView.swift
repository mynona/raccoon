import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct RatingStarsView: TemplateRepresentable {

    static let previewCategories = [
        OptionValue(title: tr("Content", de: "Inhalt", fr: "Contenu", es: "Contenido", it: "Contenuto"), value: "content"),
        OptionValue(title: tr("Design", de: "Design", fr: "Design", es: "Diseño", it: "Design"), value: "design"),
        OptionValue(title: tr("Bug / Issue", de: "Fehler / Problem", fr: "Bogue / Problème", es: "Error / Problema", it: "Bug / Problema"), value: "bug"),
        OptionValue(title: tr("Other", de: "Sonstiges", fr: "Autre", es: "Otro", it: "Altro"), value: "other"),
    ]

    let variants: [PreviewVariant<RatingData>] = [
        #previewVariant(
            tr(
                "Five Stars Rating with Error Handling",
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
                ratingType: .fiveStars,
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

                showComponentTitle("Rating (Stars)")

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
