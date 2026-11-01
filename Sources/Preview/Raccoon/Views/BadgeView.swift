import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct BadgeView: TemplateRepresentable {

    let variants: [PreviewVariant<BadgeData>] = [
        #previewVariant(
            """
            //
            """,
            BadgeData(
                id: "badge-1",
                title: "New"
            )
        ),
        #previewVariant(
            """
            //
            """,
            BadgeData(
                id: "badge-2",
                title: "Messages",
                counter: 5
            )
        ),
        #previewVariant(
            """
            //
            """,
            BadgeData(
                id: "badge-3",
                title: "Article",
                counter: 100,
                isLink: true
            )
        ),
    ]

    func makeHtml(ctx: BadgeData) -> String {
        let html = renderFragments(Badge(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Badge")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { Badge(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
