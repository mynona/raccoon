/// Represents Open Graph (OG) content types used by social media platforms to format shared content.
/// Conforms to `String`, `Codable` and `Sendable`.
public enum OgType: String, Codable, Sendable {

    /// Indicates a general website or homepage.
    case website = "website"

    /// Indicates an article or blog post.
    case article = "article"

    /// Indicates a story-type format, often used for ephemeral or narrative content.
    case story = "story"
}
