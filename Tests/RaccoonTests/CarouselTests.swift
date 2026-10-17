import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("Carousel")
struct CarouselTests {

    @Test("renders carousel container and alpine state")
    func rendersCarouselContainer() async throws {

        let items = [
            CarouselItem(
                id: "item-1",
                src: "/img1.jpg",
                alt: "First image",
                caption: "Caption 1"
            ),
            CarouselItem(
                id: "item-2",
                src: "/img2.jpg",
                alt: "Second image",
                caption: "Caption 2"
            ),
        ]
        let data = CarouselData(id: "carousel-1", carouselItems: items)
        let html = renderHTML(Carousel(data).render())

        #expect(html.contains("x-data=\""))
        // Regression: slides JSON must be HTML-entity-escaped since it's embedded inside a
        // double-quoted x-data attribute (the renderer does not escape attribute values).
        #expect(
            html.contains("&quot;imgSrc&quot;:&quot;/img1.jpg&quot;")
                || html.contains("&quot;imgSrc&quot;:&quot;\\/img1.jpg&quot;")
        )
        #expect(html.contains("&quot;imgAlt&quot;:&quot;First image&quot;"))
        #expect(html.contains("&quot;imgCaption&quot;:&quot;Caption 1&quot;"))
        #expect(html.contains("&quot;imgId&quot;:&quot;item-1&quot;"))
        #expect(html.contains("x-show=\"showCarousel\""))
        #expect(!html.contains("\"imgSrc\":"))
    }

    @Test("renders navigation buttons and close button")
    func rendersNavigationAndCloseButtons() async throws {

        let items = [
            CarouselItem(
                id: "item-1",
                src: "/img1.jpg",
                alt: "First image",
                caption: "Caption 1"
            )
        ]
        let data = CarouselData(id: "carousel-single", carouselItems: items)
        let html = renderHTML(Carousel(data).render())

        #expect(html.contains("aria-label=\"Close image gallery\""))
        #expect(html.contains("aria-label=\"previous slide\""))
        #expect(html.contains("aria-label=\"next slide\""))
        #expect(html.contains("x-ref=\"closeCarousel\""))
    }

    @Test("renders keyboard hints and shortcuts")
    func rendersKeyboardHints() async throws {

        let items = [
            CarouselItem(
                id: "item-1",
                src: "/img1.jpg",
                alt: "First image",
                caption: "Caption 1"
            )
        ]
        let data = CarouselData(id: "carousel-keys", carouselItems: items)
        let html = renderHTML(Carousel(data).render())

        #expect(
            html.contains(
                "@keyup.escape.window=\"showCarousel &amp;&amp; close()\""
            )
                || html.contains(
                    "@keyup.escape.window=\"showCarousel && close()\""
                )
        )
        #expect(
            html.contains(
                "@keyup.right.window=\"showCarousel &amp;&amp; next()\""
            ) || html.contains("@keyup.right.window=\"showCarousel && next()\"")
        )
        #expect(
            html.contains(
                "@keyup.left.window=\"showCarousel &amp;&amp; previous()\""
            )
                || html.contains(
                    "@keyup.left.window=\"showCarousel && previous()\""
                )
        )
    }

    @Test(
        "close button and escape key both route through close() so focus is restored"
    )
    func closeRoutesThroughCloseMethod() async throws {

        let items = [
            CarouselItem(
                id: "item-1",
                src: "/img1.jpg",
                alt: "First image",
                caption: "Caption 1"
            )
        ]
        let data = CarouselData(id: "carousel-close", carouselItems: items)
        let html = renderHTML(Carousel(data).render())

        #expect(html.contains("x-on:click=\"close()\""))
        #expect(!html.contains("showCarousel = false"))
    }

    @Test("escapes or handles nil captions and alts in slides JSON")
    func handlesNilCaptionsAndAlts() async throws {

        let items = [
            CarouselItem(
                id: "item-nil",
                src: "/img.jpg",
                alt: nil,
                caption: nil
            )
        ]
        let data = CarouselData(id: "carousel-nil", carouselItems: items)
        let html = renderHTML(Carousel(data).render())

        #expect(html.contains("&quot;imgAlt&quot;:&quot;&quot;"))
        #expect(html.contains("&quot;imgCaption&quot;:&quot;&quot;"))
    }

    @Test("renders script tag for carousel.js")
    func rendersScriptTag() async throws {

        let data = CarouselData(id: "carousel-script", carouselItems: [])
        let html = renderHTML(Carousel(data).render())

        #expect(html.contains("src=\"/js/carousel.js\""))
    }

    @Test("renders matomo tracking attributes when accepted")
    func rendersMatomoTrackingAttributes() async throws {

        let data = CarouselData(
            id: "carousel-matomo",
            carouselItems: [
                CarouselItem(
                    id: "c-1",
                    src: "/img1.jpg",
                    alt: "1",
                    caption: "1"
                )
            ],
            matomoStatus: .ACCEPTED
        )
        let html = renderHTML(Carousel(data).render())

        #expect(html.contains("data-track-content"))
        #expect(html.contains("data-content-name=\"carousel\""))
        #expect(html.contains("data-content-piece=\"button.close\""))
        #expect(html.contains("data-content-piece=\"button.previous\""))
        #expect(html.contains("data-content-piece=\"button.next\""))
        #expect(html.contains("data-content-target=\"\""))
    }

    @Test("omits matomo tracking attributes when declined")
    func omitsMatomoTrackingAttributes() async throws {

        let data = CarouselData(
            id: "carousel-matomo-declined",
            carouselItems: [],
            matomoStatus: .DECLINED
        )
        let html = renderHTML(Carousel(data).render())

        #expect(!html.contains("data-track-content"))
        #expect(!html.contains("data-content-name=\"carousel\""))
    }

    @Test("renders picture and source elements in slides template")
    func rendersPictureAndSourceElements() async throws {

        let data = CarouselData(
            id: "carousel-picture",
            carouselItems: [
                CarouselItem(
                    id: "slide-1",
                    src: "/img.jpg",
                    alt: "Alt",
                    caption: "Caption"
                )
            ]
        )
        let html = renderHTML(Carousel(data).render())

        #expect(html.contains("<picture>"))
        #expect(html.contains("</picture>"))
        #expect(html.contains("<source"))
        #expect(html.contains("type=\"image/avif\""))
        #expect(html.contains("type=\"image/webp\""))
        #expect(html.contains("x-bind:srcset=\"slide.avifSrcSet || false\""))
        #expect(html.contains("x-bind:srcset=\"slide.webpSrcSet || false\""))
        #expect(
            html.contains(
                "onerror=\"this.onerror=null; this.closest('picture')?.querySelectorAll('source').forEach(s =&gt; s.remove());\""
            )
                || html.contains(
                    "onerror=\"this.onerror=null; this.closest('picture')?.querySelectorAll('source').forEach(s => s.remove());\""
                )
        )
    }

    @Test("derives S3 alternative sources in jsonSlides when isS3Image is true")
    func derivesS3AlternativesInJsonSlides() async throws {
        let items = [
            CarouselItem(
                id: "0160CBFD-23CE-40E8-88E8-4317FCD54BB0",
                src:
                    "https://raumnebenan-images.s3.eu-central-1.amazonaws.com/blog/0160CBFD-23CE-40E8-88E8-4317FCD54BB0.png",
                alt: "Responsive S3 slide",
                caption: "Caption",
                isS3Image: true
            )
        ]
        let data = CarouselData(id: "carousel-s3", carouselItems: items)

        #expect(data.jsonSlides.contains("avifSrcSet"))
        #expect(data.jsonSlides.contains("webpSrcSet"))
        #expect(
            data.jsonSlides.contains(
                "0160CBFD-23CE-40E8-88E8-4317FCD54BB0-576w.avif 576w"
            )
        )
        #expect(
            data.jsonSlides.contains(
                "0160CBFD-23CE-40E8-88E8-4317FCD54BB0-1280w.webp 1280w"
            )
        )
    }

    @Test(
        "suppresses S3 alternative sources in jsonSlides when isS3Image is false"
    )
    func suppressesS3AlternativesWhenIsS3ImageIsFalse() async throws {
        let items = [
            CarouselItem(
                id: "0160CBFD-23CE-40E8-88E8-4317FCD54BB0",
                src:
                    "https://raumnebenan-images.s3.eu-central-1.amazonaws.com/blog/0160CBFD-23CE-40E8-88E8-4317FCD54BB0.png",
                alt: "Non-S3 slide",
                caption: "Caption",
                isS3Image: false
            )
        ]
        let data = CarouselData(id: "carousel-no-s3", carouselItems: items)

        #expect(!data.jsonSlides.contains("avifSrcSet"))
        #expect(!data.jsonSlides.contains("webpSrcSet"))
        #expect(!data.jsonSlides.contains("processed"))
    }

    @Test("renders onerror fallback handler on carousel slide image")
    func rendersOnErrorFallbackHandlerInSlide() async throws {

        let data = CarouselData(
            id: "carousel-onerror",
            carouselItems: [
                CarouselItem(
                    id: "slide-1",
                    src: "/img.jpg",
                    alt: "Alt",
                    caption: "Caption"
                )
            ]
        )
        let html = renderHTML(Carousel(data).render())

        #expect(
            html.contains(
                "this.closest('picture')?.querySelectorAll('source').forEach(s =&gt; s.remove());"
            )
                || html.contains(
                    "this.closest('picture')?.querySelectorAll('source').forEach(s => s.remove());"
                )
        )
        #expect(html.contains("this.onerror=null;"))
    }
}
