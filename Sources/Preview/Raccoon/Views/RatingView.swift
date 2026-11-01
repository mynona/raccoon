import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct RatingView: TemplateRepresentable {

    let variants: [PreviewVariant<RatingData>] = [
        #previewVariant(
            "Thumbs Up/Down Binary Rating",
            RatingData(
                id: "897c1000-0000-0000-0000-000000000000",
                url: "/success",
                ratingType: .thumbsUpDown
            )
        ),
        #previewVariant(
            "Five Stars with Error Handling",
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
