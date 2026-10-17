import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct QuoteView: TemplateRepresentable {

    let variants: [(String, QuoteData)] = [
        (
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
        (
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
        (
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

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { Quote(ctx).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
