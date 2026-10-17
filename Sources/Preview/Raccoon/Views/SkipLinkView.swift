import HTML
import Raccoon
import SGML
import Vapor
import WebBuilders

struct SkipLinkView: TemplateRepresentable {

    let variants: [(String, SkipLinkData)] = [
        (
            """
            // Default configuration
            """,
            SkipLinkData()
        ),
        (
            """
            // Custom target and text
            """,
            SkipLinkData(
                text: "Skip to article main content",
                targetId: "article-content"
            )
        ),
    ]

    func makeHtml(ctx: SkipLinkData) -> String {
        let html = renderFragments(SkipLink(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("SkipLink")

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div {
                            P(
                                "Tab to or focus the link below to see the skip link style:"
                            )
                            .class(
                                "mb-2 text-sm text-gray-500 dark:text-gray-400"
                            )
                            SkipLink(ctx).render()
                        }
                        .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
