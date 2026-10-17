
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

    /// - Parameters:
    ///   - name: A name that represents a content block. Visible in Matomo reports.
    ///   - piece: The actual content that was displayed.
    ///   - target: The URL or anchor the user was led to after interacting with the content block.
    public init(
        name: String,
        piece: String,
        target: String
    ) {
        self.name = name
        self.piece = piece
        self.target = target
    }

}
