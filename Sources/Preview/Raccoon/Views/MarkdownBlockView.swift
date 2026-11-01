import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct MarkdownBlockView: TemplateRepresentable {

    let variants: [PreviewVariant<MarkdownBlockData>] = [
        #previewVariant(
            """
            // hasProse == true
            """,
            MarkdownBlockData(
                markdown: LocalizedText(verbatim: DemoData.markdownText),
                isProse: true
            )
        )
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

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { MarkdownBlock(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
