import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct CarouselView: TemplateRepresentable {

    let galleryS3 = CarouselData(
        id: "carousel-gallery-s3",
        carouselItems: [
            CarouselItem(
                id: "0160CBFD-23CE-40E8-88E8-4317FCD54BB0",
                src:
                    "https://raumnebenan-images.s3.eu-central-1.amazonaws.com/blog/0160CBFD-23CE-40E8-88E8-4317FCD54BB0.png",
                alt: "S3 responsive carousel example",
                caption: "S3 processed blog image (AVIF & WebP)",
                isS3Image: true
            )
        ]
    )

    let galleryOne = CarouselData(
        id: "carousel-gallery-one",
        carouselItems: [
            CarouselItem(
                id: "sample-teal",
                src: "/images/sample-teal.svg",
                alt: "Plain teal sample image",
                caption: "Sample 1 – teal",
                isS3Image: false
            ),
            CarouselItem(
                id: "sample-amber",
                src: "/images/sample-amber.svg",
                alt: "Plain amber sample image",
                caption: "Sample 2 – amber",
                isS3Image: false
            ),
        ]
    )

    let galleryTwo = CarouselData(
        id: "carousel-gallery-two",
        carouselItems: [
            CarouselItem(
                id: "sample-indigo",
                src: "/images/sample-indigo.svg",
                alt: "Plain indigo sample image",
                caption: "Sample 3 – indigo",
                isS3Image: false
            ),
            CarouselItem(
                id: "sample-rose",
                src: "/images/sample-rose.svg",
                alt: "Plain rose sample image",
                caption: "Sample 4 – rose",
                isS3Image: false
            ),
        ]
    )

    func makeHtml(ctx: CarouselData) -> String {
        escapeHTML(prettyHTML(renderFragments(Carousel(ctx).render())))
    }

    @Builder<Element>
    func showTriggers(_ data: CarouselData) -> [Element] {
        P(
            "Open a slide, then close the carousel with Escape or the close button — focus must return to the trigger you used (visible focus ring)."
        )
        .class("mb-2 text-sm text-gray-950 dark:text-gray-400")

        Ul {
            for item in data.carouselItems {
                Li {
                    Button {
                        Img(src: item.src, alt: item.alt ?? "")
                            .width(240)
                            .height(150)
                            .loading(.lazy)
                            .class("w-60 h-auto")
                    }
                    .type(.button)
                    .setAttribute(
                        name: "@click",
                        value:
                            "window.dispatchEvent(new CustomEvent('showCarousel', { detail: '\(item.id)' }));"
                    )
                    .ariaLabel("Open \(item.caption ?? item.id) in carousel")
                    .class("cursor-pointer")
                    .addClass(CommonStyles.focusDefault)
                }
            }
        }
        .class("flex flex-row flex-wrap gap-4 mb-4")
        .setAttribute(name: "x-data", value: "{}")
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Carousel")

                for (label, data) in [
                    (
                        "// S3 Processed Gallery – automatic AVIF & WebP alternatives",
                        galleryS3
                    ),
                    ("// Gallery one", galleryOne),
                    (
                        "// Gallery two – second instance on the same page",
                        galleryTwo
                    ),
                ] {

                    showVariantTitle(label, data)

                    showComponentPreview(
                        data: label,
                        html: makeHtml(ctx: data)
                    ) {
                        showTriggers(data)
                    }

                }

            }
            .class("mt-4 space-y-6")

            Carousel(galleryS3).render()
            Carousel(galleryOne).render()
            Carousel(galleryTwo).render()

        }
        .render()

    }
}
