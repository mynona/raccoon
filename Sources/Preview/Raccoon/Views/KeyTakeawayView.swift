import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct KeyTakeawayView: TemplateRepresentable {

    let variants: [(String, KeyTakeawaysData)] = [
        (
            """
            // Default
            """,
            KeyTakeawaysData(
                title: "Key Takeaways",
                contentAsMarkdown:
                    "- Start with user problems, not solutions.\n- Validate early and often.\n- Measure outcomes, not outputs.",
                icon: .lightbulb
            )
        )
    ]

    func makeHtml(ctx: KeyTakeawaysData) -> String {
        let html = renderFragments(KeyTakeaways(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("KeyTakeaways")

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { KeyTakeaways(ctx).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
