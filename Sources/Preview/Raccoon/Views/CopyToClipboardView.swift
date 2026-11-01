import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct CopyToClipboardView: TemplateRepresentable {

    let variants: [PreviewVariant<CopyToClipboardData>] = [
        #previewVariant(
            tr(
                "Horizontal Layout",
                [
                    "de": "Horizontales Layout",
                    "fr": "Disposition horizontale",
                    "es": "Diseño horizontal",
                    "it": "Disposizione orizzontale",
                    "pt": "Layout horizontal",
                    "nl": "Horizontale indeling",
                    "da": "Vandret layout",
                    "sv": "Horisontell layout",
                    "nb": "Horisontalt oppsett",
                    "fi": "Vaakasuuntainen asettelu",
                    "is": "Lárétt uppsetning",
                    "el": "Οριζόντια διάταξη",
                    "tr": "Yatay düzen",
                    "hu": "Vízszintes elrendezés",
                    "hr": "Vodoravni raspored",
                    "pl": "Układ poziomy",
                    "sk": "Horizontálne rozloženie",
                    "cs": "Horizontální rozvržení",
                    "lb": "Horizontaalt Layout",
                ]
            ),
            CopyToClipboardData(
                value: "sk-abc123XYZ",
                orientation: .horizontal
            )
        ),
        #previewVariant(
            tr(
                "Vertical Layout",
                [
                    "de": "Vertikales Layout",
                    "fr": "Disposition verticale",
                    "es": "Diseño vertical",
                    "it": "Disposizione verticale",
                    "pt": "Layout vertical",
                    "nl": "Verticale indeling",
                    "da": "Lodret layout",
                    "sv": "Vertikal layout",
                    "nb": "Vertikalt oppsett",
                    "fi": "Pystysuuntainen asettelu",
                    "is": "Lóðrétt uppsetning",
                    "el": "Κάθετη διάταξη",
                    "tr": "Dikey düzen",
                    "hu": "Függőleges elrendezés",
                    "hr": "Okomiti raspored",
                    "pl": "Układ pionowy",
                    "sk": "Vertikálne rozloženie",
                    "cs": "Vertikální rozvržení",
                    "lb": "Vertikaalt Layout",
                ]
            ),
            CopyToClipboardData(
                value: "sk-abc123XYZ",
                orientation: .vertical
            )
        ),
    ]

    func makeHtml(ctx: CopyToClipboardData) -> String {
        let html = renderFragments(CopyToClipboard(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("CopyToClipboard")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { CopyToClipboard(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
