import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct ViewMasekedSecretView: TemplateRepresentable {

    let variants: [(String, ViewMaskedSecretData)] = [
        (
            """
            // Without copy
            """,
            ViewMaskedSecretData(
                secret: "super-secret-token-12345",
                revealCount: 4,
                hasCopyToClipboard: false
            )
        ),
        (
            """
            // With copy
            """,
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

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { ViewMaskedSecret(ctx).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
