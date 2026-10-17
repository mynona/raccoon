import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct RatingFloatingView: TemplateRepresentable {

    let variants: [(String, RatingData)] = [
        (
            """
            // Floating rating widget
            // Stays fixed at the bottom of the viewport
            """,
            RatingData(
                id: "floating-123",
                url: "/success",
                ratingType: .thumbsUpDown,
                isFloating: true,
                isShownOnScroll: false
            )
        ),
        (
            """
            // Floating rating widget on scroll
            // Revealed once the user has scrolled through 85% of the page
            """,
            RatingData(
                id: "floating-scroll-124",
                url: "/success",
                ratingType: .thumbsUpDown,
                isFloating: true,
                isShownOnScroll: true
            )
        ),
    ]

    func makeHtml(ctx: RatingData) -> String {
        let html = renderFragments(
            Rating(ctx.withFloating(true)).render()
        )
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Rating Floating")

                // Set Matomo cookie
                Script(
                    """
                    document.cookie = "raumnebenan-matomo=declined; path=/";
                    """
                )

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div {
                            Rating(ctx.withFloating(true)).render()
                        }
                        .class("mb-4 mt-12 relative")
                    }
                }

            }
            .class("mt-4 space-y-6 relative")

        }
        .render()
    }
}
