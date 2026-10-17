import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct InputListView: TemplateRepresentable {

    let variants: [(String, InputListData)] = [
        (
            """
            // Default
            """,
            InputListData(
                id: "refs",
                label: LabelData(id: "refs", title: "References"),
                values: ["https://vapor.codes", "https://swift.org"],
                validationType: .url
            )
        )
    ]

    func makeHtml(ctx: InputListData) -> String {
        let html = renderFragments(InputList(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("InputList")

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { InputList(ctx).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
