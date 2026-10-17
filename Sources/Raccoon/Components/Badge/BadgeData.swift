/// Configuration data for the `Badge` component.
public struct BadgeData: Sendable {

    public let id: String
    public let title: String
    public let counter: Int?
    public let isLink: Bool
    public let tagUrlPrefix: String
    public let hasHyphenFormatting: Bool
    public let matomoStatus: MatomoStatus

    /// Creates a new configuration instance for `Badge`.
    ///
    /// - Parameters:
    ///   - id: Unique identifier for the badge.
    ///   - title: Text title displayed inside the badge.
    ///   - counter: Optional numeric counter displayed next to the title.
    ///   - tagUrlPrefix: Base URL prefix used when badge is rendered as a link.
    ///   - isLink: Whether the badge renders as an interactive link.
    ///   - hasHyphenFormatting: Whether spaces in title are converted to hyphens for URLs.
    ///   - matomoStatus: Matomo tracking consent status.
    public init(
        id: String,
        title: String,
        counter: Int? = nil,
        tagUrlPrefix: String = "/tags/",
        isLink: Bool = false,
        hasHyphenFormatting: Bool = true,
        matomoStatus: MatomoStatus = .DECLINED
    ) {
        self.id = id
        self.title = title
        self.counter = counter
        self.isLink = isLink
        self.tagUrlPrefix = tagUrlPrefix
        self.hasHyphenFormatting = hasHyphenFormatting
        self.matomoStatus = matomoStatus
    }
}
