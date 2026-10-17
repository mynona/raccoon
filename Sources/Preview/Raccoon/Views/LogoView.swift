import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct LogoView: TemplateRepresentable {

    let variants: [(String, LogoData)] = [
        (
            """
            // With default context
            """,
            LogoData()
        ),
        (
            """
            // inverted (decomissioned)
            """,
            LogoData(destination: "/")
        ),
    ]

    func makeHtml(ctx: LogoData) -> String {
        let html = renderFragments(Logo(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Logo")

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { Logo(ctx).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
