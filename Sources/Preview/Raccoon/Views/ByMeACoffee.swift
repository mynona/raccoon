import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct ByMeACoffeeView: TemplateRepresentable {

    let variants: [PreviewVariant<ByMeACoffeeData>] = [
        #previewVariant(
            """
            // With default data
            """,
            ByMeACoffeeData(
                dataSlug: "support-kaeru",
                imageSrc: "/images/bmc-yellow.png",
                imageHeight: 60,
                imageWidth: 210
            )
        ),
        #previewVariant(
            """
            // With Matomo
            """,
            ByMeACoffeeData(
                dataSlug: "support-kaeru",
                imageSrc: "/images/bmc-yellow.png",
                imageHeight: 60,
                imageWidth: 210,
                matomoStatus: .ACCEPTED
            )
        ),
    ]

    func makeHtml(ctx: ByMeACoffeeData) -> String {
        let html = renderFragments(ByMeACoffee(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("ByMeACoffee")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { ByMeACoffee(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
