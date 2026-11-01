import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct MarkdownBlockView: TemplateRepresentable {

    let variants: [PreviewVariant<MarkdownBlockData>] = [
        #previewVariant(
            tr(
                "Rendered Prose Content",
                [
                    "de": "Gerenderter Prose-Inhalt",
                    "fr": "Contenu prose rendu",
                    "es": "Contenido en prosa procesado",
                    "it": "Contenuto in prosa renderizzato",
                    "pt": "Conteúdo em prosa renderizado",
                    "nl": "Gerenderde proza-inhoud",
                    "da": "Gengivet prosa-indhold",
                    "sv": "Renderat prosainnehåll",
                    "nb": "Gjengitt prosainnhold",
                    "fi": "Renderöity proosasisältö",
                    "is": "Myndað textaefni",
                    "el": "Αποδοθέν περιεχόμενο πεζού κειμένου",
                    "tr": "İşlenmiş düz metin içeriği",
                    "hu": "Megjelenített prózai tartalom",
                    "hr": "Prikazani prozni sadržaj",
                    "pl": "Wyrenderowana treść prozatorska",
                    "sk": "Vykreslený prozaický obsah",
                    "cs": "Vykreslený prozaický obsah",
                    "lb": "Gerenderte Prose-Inhalt",
                ]
            ),
            MarkdownBlockData(
                markdown: DemoData.markdownText,
                isProse: true
            )
        )
    ]

    func makeHtml(ctx: MarkdownBlockData) -> String {
        let html = renderFragments(MarkdownBlock(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("MarkdownBlock")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { MarkdownBlock(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
