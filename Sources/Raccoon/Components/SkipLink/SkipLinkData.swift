import Foundation

/// Configuration data for `SkipLink`. Serves as the public API contract.
public struct SkipLinkData: Sendable {

    // MARK: - 2. Content & Accessibility
    /// `nil` shows the built-in, translated "Jump directly to the main content".
    public let text: LocalizedText?
    public let targetId: String

    /// Creates a new configuration instance for `SkipLink`.
    ///
    /// - Parameters:
    ///   - text: Visible link text and accessible label. Defaults to the built-in, translated "Jump directly to the main content".
    ///   - targetId: HTML element ID (without `#`) to jump to. Defaults to `"main"`.
    public init(
        // 2. Content & Accessibility
        text: LocalizedText? = nil,
        targetId: String = "main"
    ) {
        // 2. Content & Accessibility
        self.text = text
        self.targetId = targetId
    }
}
