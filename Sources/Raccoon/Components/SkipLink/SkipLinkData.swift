import Foundation

/// Configuration data for `SkipLink`. Serves as the public API contract.
public struct SkipLinkData: Sendable {

    // MARK: - 2. Content & Accessibility
    public let text: String
    public let targetId: String
    public let hreflang: String?

    /// Creates a new configuration instance for `SkipLink`.
    ///
    /// - Parameters:
    ///   - text: Visible link text and accessible label. Defaults to `"Jump directly to the main content"`.
    ///   - targetId: HTML element ID (without `#`) to jump to. Defaults to `"main"`.
    ///   - hreflang: Language tag for the target anchor. Defaults to `AppValues.lang`.
    public init(
        // 2. Content & Accessibility
        text: String = "Jump directly to the main content",
        targetId: String = "main",
        hreflang: String? = AppValues.lang
    ) {
        // 2. Content & Accessibility
        self.text = text
        self.targetId = targetId
        self.hreflang = hreflang
    }
}
