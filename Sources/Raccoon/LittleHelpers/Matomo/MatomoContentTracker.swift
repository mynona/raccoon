
import Foundation

/// Matomo Content Tracker
///
/// Naming (same everywhere, so the reports can be compared):
/// - `name`: the area or block, lowercase kebab-case (`header.menu`, `footer.menu`, `page.article`, `cookie-banner`).
/// - `piece`: `<type>.<item>`, see `MatomoContentTracker.piece(_:_:)`: what was clicked.
/// - `target`: the destination path of a link, otherwise empty. Never a label.
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

    /// Lowercase kebab-case form of `text` (`[a-z0-9-]`, at most 60 characters), for names and pieces:
    /// `"5. Your right to your data"` becomes `"5-your-right-to-your-data"`.
    public static func slug(_ text: String) -> String {
        let folded = text
            .replacingOccurrences(of: "ß", with: "ss")
            .folding(options: [.diacriticInsensitive, .caseInsensitive], locale: nil)
            .lowercased()
        var result = ""
        var lastWasSeparator = true
        for scalar in folded.unicodeScalars {
            if (scalar >= "a" && scalar <= "z") || (scalar >= "0" && scalar <= "9") {
                result.unicodeScalars.append(scalar)
                lastWasSeparator = false
            } else if !lastWasSeparator {
                result.append("-")
                lastWasSeparator = true
            }
        }
        while result.hasSuffix("-") { result.removeLast() }
        if result.count > 60 {
            result = String(result.prefix(60))
            while result.hasSuffix("-") { result.removeLast() }
        }
        return result
    }

    /// Piece of a content block: `<type>.<item>`, for example `tab.foundation` or `button.accept`.
    /// Types: `button`, `link`, `toggle`, `tab`, `section`, `tag`, `pill`, `step`. The item says what was clicked
    /// (the label of a tab or an accordion section, the slug of an article, the action of a button); leave it out
    /// only when the block has a single element of that type. Item parts are slugged, dots separate further parts.
    public static func piece(_ type: String, _ item: String? = nil) -> String {
        guard let item else { return type }
        let parts = item.split(separator: ".", omittingEmptySubsequences: true).map { slug(String($0)) }
            .filter { !$0.isEmpty }
        return parts.isEmpty ? type : ([type] + parts).joined(separator: ".")
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
