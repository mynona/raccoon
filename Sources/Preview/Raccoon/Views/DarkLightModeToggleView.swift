import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct DarkLightModeToggleView: TemplateRepresentable {

    let variants: [(String, DarkLightModeToggleData)] = [
        (
            """
            // With default context
            """,
            DarkLightModeToggleData()
        ),
        (
            """
            // With id and Matomo tracking enabled
            """,
            DarkLightModeToggleData(
                id: "darkLightModeToggle",
                matomoStatus: .ACCEPTED
            )
        ),
    ]

    func makeHtml(ctx: DarkLightModeToggleData) -> String {
        let html = renderFragments(DarkLightModeToggle(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Dark Light Mode Toggle")

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { DarkLightModeToggle(ctx).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
