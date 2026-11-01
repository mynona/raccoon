import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct GlossaryEntryView: TemplateRepresentable {

    let variants: [PreviewVariant<GlossaryEntryData>] = [
        #previewVariant(
            """
            // Default
            """,
            GlossaryEntryData(
                term: "Product Thinking",
                definition:
                    "Solving the *right* problems by deeply understanding user needs and business context.",
                hasInitial: true
            )
        ),
        #previewVariant(
            """
            // Default
            """,
            GlossaryEntryData(
                term: "Product Thinking",
                definition:
                    "Solving the *right* problems by deeply understanding user needs and business context.",
                hasInitial: false
            )
        ),
    ]

    func makeHtml(ctx: GlossaryEntryData) -> String {
        let html = renderFragments(GlossaryEntry(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Glossary Entry")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { GlossaryEntry(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
