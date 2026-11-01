import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct QuoteView: TemplateRepresentable {

    let variants: [PreviewVariant<QuoteData>] = [
        #previewVariant(
            """
            // With citation
            """,
            QuoteData(
                quote:
                    "Design is not just what it looks like and feels like. Design is how it works.",
                citation: "Steve Jobs",
                hasQuotationMarks: true
            )
        ),
        #previewVariant(
            """
            // With citation but no quotation marks
            """,
            QuoteData(
                quote:
                    "Design is *not* just what it looks like and feels like. Design is **how** it works.",
                citation: "Steve Jobs",
                hasQuotationMarks: false
            )
        ),
        #previewVariant(
            """
            // No citation
            """,
            QuoteData(quote: "Ship early, learn fast.", citation: nil)
        ),
    ]

    func makeHtml(ctx: QuoteData) -> String {
        let html = renderFragments(Quote(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Quote")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { Quote(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
