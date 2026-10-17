import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct HelperTextView: TemplateRepresentable {

    let variants: [(String, HelperTextData)] = [
        (
            """
            // With helper text
            """,
            HelperTextData(
                id: "helper",
                text: "This is a helper text."
            )
        )
    ]

    func makeHtml(ctx: HelperTextData) -> String {
        let html = renderFragments(HelperText(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("HelperText")

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { HelperText(ctx).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
