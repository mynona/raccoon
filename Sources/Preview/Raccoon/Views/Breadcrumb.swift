import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct BreadcrumbView: TemplateRepresentable {

    let variants: [PreviewVariant<BreadcrumbData>] = [
        #previewVariant(
            tr(
                "Path Links",
                [
                    "de": "Pfad-Links",
                    "fr": "Liens de chemin",
                    "es": "Enlaces de ruta",
                    "it": "Collegamenti di percorso",
                    "pt": "Links de caminho",
                    "nl": "Padlinks",
                    "da": "Stilinks",
                    "sv": "Sökvägslänkar",
                    "nb": "Stilenker",
                    "fi": "Polkulinkit",
                    "is": "Slóðatenglar",
                    "el": "Σύνδεσμοι διαδρομής",
                    "tr": "Yol bağlantıları",
                    "hu": "Útvonal-hivatkozások",
                    "hr": "Veze putanje",
                    "pl": "Linki ścieżki",
                    "sk": "Odkazy cesty",
                    "cs": "Odkazy cesty",
                    "lb": "Pad-Linken",
                ]
            ),
            BreadcrumbData(
                paths: DemoData.breadcrumbPaths
            )
        ),
        #previewVariant(
            tr(
                "Path Links with Home & Matomo",
                [
                    "de": "Pfad-Links mit Home & Matomo",
                    "fr": "Liens de chemin avec Accueil et Matomo",
                    "es": "Enlaces de ruta con Inicio y Matomo",
                    "it": "Collegamenti di percorso con Home e Matomo",
                    "pt": "Links de caminho com Início e Matomo",
                    "nl": "Padlinks met Home & Matomo",
                    "da": "Stilinks med Hjem og Matomo",
                    "sv": "Sökvägslänkar med Hem och Matomo",
                    "nb": "Stilenker med Hjem og Matomo",
                    "fi": "Polkulinkit Kotisivulla ja Matomolla",
                    "is": "Slóðatenglar með Heimasíðu og Matomo",
                    "el": "Σύνδεσμοι διαδρομής με Αρχική & Matomo",
                    "tr": "Ana sayfa ve Matomo ile yol bağlantıları",
                    "hu": "Útvonal-hivatkozások Kezdőlappal és Matomóval",
                    "hr": "Veze putanje s Početnom i Matomom",
                    "pl": "Linki ścieżki ze stroną główną i Matomo",
                    "sk": "Odkazy cesty s Domovom a Matomom",
                    "cs": "Odkazy cesty s Domovem a Matomem",
                    "lb": "Pad-Linke mat Home & Matomo",
                ]
            ),
            BreadcrumbData(
                paths: DemoData.breadcrumbPaths,
                hasHome: true,
                matomoStatus: .ACCEPTED
            )
        ),
    ]

    func makeHtml(ctx: BreadcrumbData) -> String {
        let html = renderFragments(Breadcrumb(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Breadcrumb")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { Breadcrumb(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
