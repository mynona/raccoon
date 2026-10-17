import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct SpacerView: TemplateRepresentable {

    let variants: [(String, SpacerData)] = (1...10)
        .map { n in
            (
                """
                // Space \(n)
                """,
                SpacerData(space: UInt(n))
            )
        }

    func makeHtml(ctx: SpacerData) -> String {
        let html = renderFragments(Spacer(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Spacer")

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { Spacer(ctx).render() }
                            .class("mb-4 mt-12 bg-blue-900")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
