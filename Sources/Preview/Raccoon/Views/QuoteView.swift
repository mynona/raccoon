import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct QuoteView: TemplateRepresentable {

    let variants: [PreviewVariant<QuoteData>] = [
        #previewVariant(
            "With Citation and Quotation Marks",
            QuoteData(
                quote:
                    tr(
                        "Design is not just what it looks like and feels like. Design is how it works.",
                        de:
                            "Design ist nicht nur, wie etwas aussieht und sich anfühlt. Design ist, wie es funktioniert.",
                        fr:
                            "Le design, ce n'est pas seulement l'apparence et la sensation. Le design, c'est le fonctionnement.",
                        es:
                            "El diseño no es solo cómo se ve y cómo se siente. El diseño es cómo funciona.",
                        it:
                            "Il design non è solo come appare e come ci si sente. Il design è come funziona."
                    ),
                citation: "Steve Jobs",
                hasQuotationMarks: true
            )
        ),
        #previewVariant(
            "With Citation Without Quotation Marks",
            QuoteData(
                quote:
                    tr(
                        "Design is *not* just what it looks like and feels like. Design is **how** it works.",
                        de:
                            "Design ist *nicht* nur, wie etwas aussieht und sich anfühlt. Design ist, **wie** es funktioniert.",
                        fr:
                            "Le design, ce n'est *pas* seulement l'apparence et la sensation. Le design, c'est **le fonctionnement**.",
                        es:
                            "El diseño *no* es solo cómo se ve y cómo se siente. El diseño es **cómo** funciona.",
                        it:
                            "Il design *non* è solo come appare e come ci si sente. Il design è **come** funziona."
                    ),
                citation: "Steve Jobs",
                hasQuotationMarks: false
            )
        ),
        #previewVariant(
            "Quote Only Without Citation",
            QuoteData(
                quote: tr(
                    "Ship early, learn fast.",
                    de: "Früh ausliefern, schnell lernen.",
                    fr: "Livrer tôt, apprendre vite.",
                    es: "Lanza pronto, aprende rápido.",
                    it: "Rilascia presto, impara in fretta."
                ),
                citation: nil
            )
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
