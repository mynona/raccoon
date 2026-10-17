import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct ReferencesView: TemplateRepresentable {

    let variants: [(String, ReferencesData)] = [
        (
            """
            // Default
            """,
            ReferencesData(
                title: "References",
                contentAsMarkdown:
                    "* Norman, D. (2013). *The Design of Everyday Things*. Basic Books.\n* Gothelf, J. (2013). *Lean UX*. O'Reilly Media."
            )
        )
    ]

    func makeHtml(ctx: ReferencesData) -> String {
        let html = renderFragments(References(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("References")

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { References(ctx).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
