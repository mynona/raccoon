import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct HelperTextView: TemplateRepresentable {

    let variants: [PreviewVariant<HelperTextData>] = [
        #previewVariant(
            "Standard Helper Text",
            HelperTextData(
                id: "helper",
                text: tr(
                    "This is a helper text.",
                    de: "Dies ist ein Hilfetext.",
                    fr: "Ceci est un texte d'aide.",
                    es: "Este es un texto de ayuda.",
                    it: "Questo è un testo di aiuto."
                )
            )
        )
    ]

    func makeHtml(ctx: HelperTextData) -> String {
        let html = renderFragments(HelperText(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("HelperText")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { HelperText(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
