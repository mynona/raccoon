import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct RatingView: TemplateRepresentable {

    let variants: [PreviewVariant<RatingData>] = [
        #previewVariant(
            """
            // .thumbsUpDown
            //
            // When the user has successfully submitted the widget
            // we store the uuid in the local storage that the user
            // is not prompted for this uuid again to provide feedback
            """,
            RatingData(
                id: "897c1000-0000-0000-0000-000000000000",
                url: "/success",
                ratingType: .thumbsUpDown
            )
        ),
        #previewVariant(
            """
            // .fiveStars
            //
            // This will trigger the error view
            """,
            RatingData(
                id: "111c1000-0000-0000-0000-000000000000",
                url: "/error",
                ratingType: .fiveStars
            )
        ),
    ]

    func makeHtml(ctx: RatingData) -> String {
        let html = renderFragments(Rating(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Rating")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { Rating(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
