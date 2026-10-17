import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct CopyToClipboardView: TemplateRepresentable {

    let variants: [(String, CopyToClipboardData)] = [
        (
            """
            // Horizontal
            """,
            CopyToClipboardData(
                value: "sk-abc123XYZ",
                orientation: .horizontal
            )
        ),
        (
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

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { CopyToClipboard(ctx).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
