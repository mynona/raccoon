import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct CopyToClipboardView: TemplateRepresentable {

    let variants: [PreviewVariant<CopyToClipboardData>] = [
        #previewVariant(
            """
            // Horizontal
            """,
            CopyToClipboardData(
                value: "sk-abc123XYZ",
                orientation: .horizontal
            )
        ),
        #previewVariant(
            """
            // Vertical
            """,
            CopyToClipboardData(
                value: "sk-abc123XYZ",
                orientation: .vertical
            )
        ),
    ]

    func makeHtml(ctx: CopyToClipboardData) -> String {
        let html = renderFragments(CopyToClipboard(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("CopyToClipboard")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { CopyToClipboard(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
