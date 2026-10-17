/// Represents a single slide item in a carousel.
public struct CarouselItem: Sendable {
    public let id: String
    public let src: String
    public let alt: String?
    public let caption: String?
    public let isS3Image: Bool

    /// Creates a new `CarouselItem`.
    ///
    /// - Parameters:
    ///   - id: Unique identifier for the slide.
    ///   - src: Image source URL.
    ///   - alt: Optional accessible image description.
    ///   - caption: Optional image caption displayed on the slide.
    ///   - isS3Image: Whether the image is hosted on S3 and should automatically serve alternative AVIF and WebP sources.
    public init(
        id: String,
        src: String,
        alt: String?,
        caption: String?,
        isS3Image: Bool = true
    ) {
        self.id = id
        self.src = src
        self.alt = alt
        self.caption = caption
        self.isS3Image = isS3Image
    }
}

/// Configuration data for the `Carousel` component.
public struct CarouselData: Sendable {
    public let id: String
    public let carouselItems: [CarouselItem]
    public let matomoStatus: MatomoStatus

    var jsonSlides: String {
        struct CarouselSlidePayload: Encodable {
            let imgSrc: String
            let imgAlt: String
            let imgCaption: String
            let imgId: String
            let avifSrcSet: String?
            let webpSrcSet: String?
        }
        let payloads = self.carouselItems.map { item in
            let effectiveSources =
                item.isS3Image
                ? ImageSourcesData.deriveFromBlogLink(item.src)
                : []

            let avifSrcSet = effectiveSources.first(where: {
                $0.type == "image/avif"
            })?
            .srcSet
            let webpSrcSet = effectiveSources.first(where: {
                $0.type == "image/webp"
            })?
            .srcSet

            return CarouselSlidePayload(
                imgSrc: item.src,
                imgAlt: item.alt ?? "",
                imgCaption: item.caption ?? "",
                imgId: item.id,
                avifSrcSet: avifSrcSet,
                webpSrcSet: webpSrcSet
            )
        }
        return JavaScriptEscaper.jsonEncode(payloads, fallback: "[]")
    }

    /// Creates a new configuration instance for `Carousel`.
    ///
    /// - Parameters:
    ///   - id: Unique identifier for the carousel container.
    ///   - carouselItems: Array of slides to display.
    ///   - matomoStatus: Matomo tracking consent status.
    public init(
        id: String,
        carouselItems: [CarouselItem],
        matomoStatus: MatomoStatus = .DECLINED
    ) {
        self.id = id
        self.carouselItems = carouselItems
        self.matomoStatus = matomoStatus
    }
}
