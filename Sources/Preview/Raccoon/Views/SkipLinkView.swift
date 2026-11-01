import HTML
import Raccoon
import SGML
import Vapor
import WebBuilders

struct SkipLinkView: TemplateRepresentable {

    let variants: [PreviewVariant<SkipLinkData>] = [
        #previewVariant(
            """
            // Default configuration
            """,
            SkipLinkData()
        ),
        #previewVariant(
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

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div {
                            P(
                                "Tab to or focus the link below to see the skip link style:"
                            )
                            .class(
                                "mb-2 text-sm text-gray-500 dark:text-gray-400"
                            )
                            SkipLink(variant.data).render()
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
