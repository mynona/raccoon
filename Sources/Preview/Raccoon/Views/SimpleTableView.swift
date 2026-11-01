import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct SimpleTableView: TemplateRepresentable {

    let variants: [PreviewVariant<SimpleTableData>] = [
        #previewVariant(
            """
            // Growth Loops
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

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { SimpleTable(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
