import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct LinkListView: TemplateRepresentable {

    let variants: [(String, LinkListData)] = [
        (
            """
            // Default
            """,
            LinkListData(
                links: [
                    "Getting started": "/start",
                    "Documentation": "/docs",
                    "Blog": "/blog",
                    "DeadLink": nil,
                ],
                icon: .arrow_right_circle,
                contentTracker: tracker
            )
        ),
        (
            """
            // Multiline wrapping
            """,
            LinkListData(
                links: [
                    "Comprehensive Guide to Building Distributed Microservices with Swift, Vapor and Modern Cloud Architecture Patterns":
                        "/guide",
                    "Short Link": "/short",
                ],
                icon: .arrow_right_circle,
                contentTracker: tracker
            )
        ),
    ]

    func makeHtml(ctx: LinkListData) -> String {
        let html = renderFragments(LinkList(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("LinkList")

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { LinkList(ctx).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
