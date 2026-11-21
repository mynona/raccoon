
/// Matomo Content Tracker
///
/// Link: https://developer.matomo.org/guides/content-tracking
public struct MatomoContentTracker: Codable, Sendable {

    /// A name that represents a content block. The name will be visible in reports. One name can belong to different content pieces.
    public let name: String

    /// This is the actual content that was displayed
    public let piece: String

    /// For instance the URL of a landing page where the user was led to after interacting with the content block. In a single page website it could be also the name of an anchor.
    public let target: String

    /// Whether the content block also reports an impression (it was seen). Clicks are always reported.
    /// Off by default: impressions of elements that are on every page carry no information.
    public let impression: Bool

    /// - Parameters:
    ///   - name: A name that represents a content block. Visible in Matomo reports.
    ///   - piece: The actual content that was displayed.
    ///   - target: The URL or anchor the user was led to after interacting with the content block.
    ///   - impression: Also report that the content block was seen, once per page view. Defaults to `false`.
    public init(
        name: String,
        piece: String,
        target: String,
        impression: Bool = false
    ) {
        self.name = name
        self.piece = piece
        self.target = target
        self.impression = impression
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.piece = try container.decode(String.self, forKey: .piece)
        self.target = try container.decode(String.self, forKey: .target)
        self.impression =
            try container.decodeIfPresent(Bool.self, forKey: .impression)
            ?? false
    }

}
