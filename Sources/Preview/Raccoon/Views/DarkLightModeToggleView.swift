import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct DarkLightModeToggleView: TemplateRepresentable {

    let variants: [PreviewVariant<DarkLightModeToggleData>] = [
        #previewVariant(
            """
            // With default context
            """,
            DarkLightModeToggleData()
        ),
        #previewVariant(
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

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { DarkLightModeToggle(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
