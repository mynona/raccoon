import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct ReferencesView: TemplateRepresentable {

    let variants: [PreviewVariant<ReferencesData>] = [
        #previewVariant(
            tr(
                "Markdown References List",
                [
                    "de": "Markdown-Quellenliste",
                    "fr": "Liste de références Markdown",
                    "es": "Lista de referencias Markdown",
                    "it": "Elenco riferimenti Markdown",
                    "pt": "Lista de referências Markdown",
                    "nl": "Markdown-referentielijst",
                    "da": "Markdown-referenceliste",
                    "sv": "Markdown-referenslista",
                    "nb": "Markdown-referanseliste",
                    "fi": "Markdown-viiteluettelo",
                    "is": "Markdown-heimildalisti",
                    "el": "Λίστα παραπομπών Markdown",
                    "tr": "Markdown kaynak listesi",
                    "hu": "Markdown forráslista",
                    "hr": "Markdown popis referenci",
                    "pl": "Lista źródeł Markdown",
                    "sk": "Zoznam zdrojov Markdown",
                    "cs": "Seznam zdrojů Markdown",
                    "lb": "Markdown-Referenzlëscht",
                ]
            ),
            ReferencesData(
                title: tr(
                    "References",
                    de: "Quellen",
                    fr: "Références",
                    es: "Referencias",
                    it: "Riferimenti"
                ),
                contentAsMarkdown:
                    "* Norman, D. (2013). *The Design of Everyday Things*. Basic Books.\n* Gothelf, J. (2013). *Lean UX*. O'Reilly Media."
            )
        )
    ]

    func makeHtml(ctx: ReferencesData) -> String {
        let html = renderFragments(References(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("References")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { References(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
