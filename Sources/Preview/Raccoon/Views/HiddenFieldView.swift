import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct HiddenFieldView: TemplateRepresentable {

    let variants: [(String, HiddenFieldData)] = [
        (
            """
            // With default context
            """,
            HiddenFieldData(
                id: "hidden-key",
                value: "hidden-value",
                state: .enabled
            )
        )
    ]

    func makeHtml(ctx: HiddenFieldData) -> String {
        let html = renderFragments(HiddenField(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("HiddenField")

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { HiddenField(ctx).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
