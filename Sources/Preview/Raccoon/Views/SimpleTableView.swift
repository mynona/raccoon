import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct SimpleTableView: TemplateRepresentable {

    let variants: [(String, SimpleTableData)] = [
        (
            """
            // Growth Loops (raumnebenan.de)
            SimpleTableData(meta: meta, rows: rows, caption: \"Types of Growth Loops\")
            """,
            SimpleTableData(
                meta: DemoData.simpleTableMeta,
                rows: DemoData.simpleTableRows,
                caption: "Types of Growth Loops"
            )
        )
    ]

    func makeHtml(ctx: SimpleTableData) -> String {
        let html = renderFragments(SimpleTable(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("SimpleTable")

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { SimpleTable(ctx).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
