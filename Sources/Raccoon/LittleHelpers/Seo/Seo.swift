import Foundation

/// Represents metadata used for Search Engine Optimization (SEO) and social media sharing.
public struct Seo: Codable, Sendable {

    /// The meta title of the page, used in browser tabs and search engine results.
    public let title: String?

    /// The meta description of the page, used by search engines to summarize content.
    public let description: String?

    /// The canonical URL of the page, indicating the preferred version for indexing.
    /// This value is also set as callerPage for redirects
    public let url: String?

    /// The Open Graph content type (e.g., website, article), used by social media platforms.
    public let type: OgType?

    /// The image URL used for previews on social media platforms.
    public let image: String?

    /// The type of social media card (e.g., summary, summary_large_image).
    public let card: String?

    /// The domain name associated with the content, used in Open Graph metadata.
    public let domain: String?

    /// Instructions for search engine crawlers (e.g., "index, follow").
    public let robots: String?

    /// Structured data in JSON-LD format to enhance search engine understanding.
    public let jsonLD: String?

    /// The publication date of the content, relevant for articles and blog posts.
    public let published_time: Date?

    /// The last modification date of the content.
    public let modified_time: Date?

    /// Tags or keywords associated with the content, useful for categorization and SEO.
    public let tags: [String]?

    /// Initializes a new `Seo` object with optional metadata values.
    public init(
        title: String? = nil,
        description: String? = nil,
        url: String? = nil,
        type: OgType = .website,
        image: String? = nil,
        card: String? = nil,
        domain: String,
        published_time: Date? = nil,
        modified_time: Date? = nil,
        tags: [String]? = nil,
        robots: String? = nil,
        jsonLD: String? = nil
    ) {
        self.title = title
        self.description = description
        self.url = url
        self.type = type
        self.image = image
        self.card = card
        self.domain = domain
        self.published_time = published_time
        self.modified_time = modified_time
        self.tags = tags
        self.robots = robots
        self.jsonLD = jsonLD
    }
}
