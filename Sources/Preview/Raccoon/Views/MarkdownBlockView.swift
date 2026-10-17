import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct MarkdownBlockView: TemplateRepresentable {

    let variants: [(String, MarkdownBlockData)] = [
        (
            """
            // hasProse == true
            """,
            MarkdownBlockData(
                markdown: DemoData.markdownText,
                isProse: true
            )
        ),
        (
            """
            // hasProse == false

            MarkdownBlockData(
                markdown: md, 
                hasProse: false
            )
            """,
            MarkdownBlockData(
                markdown: DemoData.markdownText,
                isProse: false
            )
        ),
    ]

    func makeHtml(ctx: MarkdownBlockData) -> String {
        let html = renderFragments(MarkdownBlock(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("MarkdownBlock")

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { MarkdownBlock(ctx).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
