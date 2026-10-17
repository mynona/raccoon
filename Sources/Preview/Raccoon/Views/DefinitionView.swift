import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct DefinitionView: TemplateRepresentable {

    let variants: [(String, DefinitionData)] = [
        (
            """
            // Default
            """,
            DefinitionData(
                term: "Product Thinking",
                definition:
                    "Solving the right problems by deeply understanding user needs and business context.",
                icon: .book
            )
        )
    ]

    func makeHtml(ctx: DefinitionData) -> String {
        let html = renderFragments(Definition(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Definition")

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { Definition(ctx).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
