/// Configuration data for the `ByMeACoffee` button component.
public struct ByMeACoffeeData: Sendable {

    public let dataSlug: String
    public let imageSrc: String
    public let imageHeight: Int
    public let imageWidth: Int
    public let matomoStatus: MatomoStatus

    /// Creates a new configuration instance for `ByMeACoffee`.
    ///
    /// - Parameters:
    ///   - dataSlug: The creator slug on Buy Me a Coffee.
    ///   - imageSrc: Source URL of the widget badge image.
    ///   - imageHeight: Rendered height in pixels.
    ///   - imageWidth: Rendered width in pixels.
    ///   - matomoStatus: Matomo tracking consent status.
    public init(
        dataSlug: String,
        imageSrc: String,
        imageHeight: Int = 60,
        imageWidth: Int = 210,
        matomoStatus: MatomoStatus = .DECLINED
    ) {
        self.dataSlug = dataSlug
        self.imageSrc = imageSrc
        self.imageHeight = imageHeight
        self.imageWidth = imageWidth
        self.matomoStatus = matomoStatus
    }
}
