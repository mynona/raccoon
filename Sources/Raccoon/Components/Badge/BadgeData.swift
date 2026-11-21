import SVG

/// Visual variant of a `Badge`.
public enum BadgeVariant: String, Sendable {
    /// Outlined tag look (default).
    case tag
    /// Filled, neutral status look.
    case neutral
    /// Filled, positive status look.
    case success
    /// Filled, negative status look.
    case error
}

/// Configuration data for the `Badge` component.
public struct BadgeData: Sendable {

    public let id: String?
    public let title: LocalizedText
    public let counter: Int?
    public let isLink: Bool
    public let tagUrlPrefix: String
    public let hasHyphenFormatting: Bool
    public let icon: SvgIcon?
    public let variant: BadgeVariant
    public let ariaLabel: LocalizedText?
    public let bindTitle: String?
    public let bindAriaLabel: String?

    /// Creates a new configuration instance for `Badge`.
    ///
    /// - Parameters:
    ///   - id: Optional DOM identifier. Omit it where the badge repeats, for example in table rows.
    ///   - title: Text title displayed inside the badge. The URL slug is built from its English text, so links are the same in every language.
    ///   - counter: Optional numeric counter displayed next to the title.
    ///   - tagUrlPrefix: Base URL prefix used when badge is rendered as a link.
    ///   - isLink: Whether the badge renders as an interactive link.
    ///   - hasHyphenFormatting: Whether spaces in title are converted to hyphens for URLs.
    ///   - icon: Icon shown before the title. Defaults to `#`; pass `nil` for none.
    ///   - variant: Visual variant (`tag`, `neutral`, `success`, `error`).
    ///   - ariaLabel: Accessible name of the group. Defaults to the "Articles tagged as" text of tag badges.
    ///   - bindTitle: Alpine expression that sets the title at runtime, for example `row['tag']` in a table cell. `title` is then only the server-side fallback.
    ///   - bindAriaLabel: Alpine expression that sets the accessible name of the group at runtime.
    public init(
        id: String? = nil,
        title: LocalizedText,
        counter: Int? = nil,
        tagUrlPrefix: String = "/tags/",
        isLink: Bool = false,
        hasHyphenFormatting: Bool = true,
        icon: SvgIcon? = .hash,
        variant: BadgeVariant = .tag,
        ariaLabel: LocalizedText? = nil,
        bindTitle: String? = nil,
        bindAriaLabel: String? = nil,
    ) {
        self.id = id
        self.title = title
        self.counter = counter
        self.isLink = isLink
        self.tagUrlPrefix = tagUrlPrefix
        self.hasHyphenFormatting = hasHyphenFormatting
        self.icon = icon
        self.variant = variant
        self.ariaLabel = ariaLabel
        self.bindTitle = bindTitle
        self.bindAriaLabel = bindAriaLabel
    }
}
