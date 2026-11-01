import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct ViewMasekedSecretView: TemplateRepresentable {

    let variants: [PreviewVariant<ViewMaskedSecretData>] = [
        #previewVariant(
            "Masked Secret without Copy Action",
            ViewMaskedSecretData(
                secret: "super-secret-token-12345",
                revealCount: 4,
                hasCopyToClipboard: false
            )
        ),
        #previewVariant(
            "Masked Secret with Copy Action",
            ViewMaskedSecretData(
                secret: "'ä:ß/\"super-secret-token-12345",
                revealCount: 4,
                hasCopyToClipboard: true
            )
        ),
    ]

    func makeHtml(ctx: ViewMaskedSecretData) -> String {
        let html = renderFragments(ViewMaskedSecret(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("ViewMaskedSecret")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { ViewMaskedSecret(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
