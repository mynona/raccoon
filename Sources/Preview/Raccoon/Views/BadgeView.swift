import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct BadgeView: TemplateRepresentable {

    let variants: [(String, BadgeData)] = [
        (
            """
            //
            """,
            BadgeData(
                id: "badge-1",
                title: "New"
            )
        ),
        (
            """
            //
            """,
            BadgeData(
                id: "badge-2",
                title: "Messages",
                counter: 5
            )
        ),
        (
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

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { Badge(ctx).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
