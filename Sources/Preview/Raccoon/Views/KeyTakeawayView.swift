import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct KeyTakeawayView: TemplateRepresentable {

    let variants: [PreviewVariant<KeyTakeawaysData>] = [
        #previewVariant(
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

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { KeyTakeaways(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
