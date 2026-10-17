import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct LabelView: TemplateRepresentable {

    let variants: [(String, LabelData)] = [
        (
            """
            // Required
            """,
            LabelData(
                id: "field-1",
                title: "Full name",
                isRequired: true
            )
        ),
        (
            """
            // Optional
            """,
            LabelData(
                id: "field-2",
                title: "Middle name",
                position: .right,
                isRequired: false
            )
        ),
        (
            """
            // Optional
            """,
            LabelData(
                id: "field-3",
                title: "Label",
                position: .left,
                size: .xl,
                isRequired: true,
                xhtml: "'xhtml-test'"
            )
        ),
    ]

    func makeHtml(ctx: LabelData) -> String {
        let html = renderFragments(Label(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Label")

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { Label(ctx).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
