import HTML
import SGML
import WebBuilders

public enum AccordionContent: Sendable {
    case html(String)
    case markdown(String)
    case element([any SGML.Element])

    public static func element(
        @Builder<SGML.Element> _ content: () -> [any SGML.Element]
    ) -> AccordionContent {
        .element(content())
    }

    public var isEmpty: Bool {
        switch self {
        case .html(let html): html.isEmpty
        case .markdown(let markdown): markdown.isEmpty
        case .element(let elements): elements.isEmpty
        }
    }
}

public struct AccordionData: Sendable {

    // MARK: - 1. Identity & Alpine Bindings
    /// If no value provided it will use StableIdentifier(hash: label)
    public let id: String?

    // MARK: - 2. Content & Accessibility
    public let label: String

    // MARK: - 3. Value & Options
    public let content: AccordionContent

    // MARK: - 5. Presentation & State
    public let icon: SvgIcon?
    public let keyboardKey: String?
    public let isLabelMonospaced: Bool
    public let isContentSansSerif: Bool
    public let hasBorder: Bool

    // MARK: - 6. Analytics & Tracking
    public let matomoStatus: MatomoStatus

    /// Creates a new configuration instance for `Accordion` with an `AccordionContent` payload.
    ///
    /// - Parameters:
    ///   - id: Optional identifier. Falls back to a hash of the label if omitted.
    ///   - label: Header label text for the accordion section.
    ///   - content: Content payload (`html`, `markdown`, or `element`).
    ///   - icon: Optional SVG icon to display alongside the label.
    ///   - keyboardKey: Optional keyboard shortcut key indicator.
    ///   - isLabelMonospaced: Whether the label uses a monospaced font.
    ///   - isContentSansSerif: Whether the body content uses sans-serif typography.
    ///   - hasBorder: Whether a border is rendered around the accordion.
    ///   - matomoStatus: Matomo analytics tracking consent status.
    public init(
        id: String? = nil,
        label: String,
        content: AccordionContent,
        icon: SvgIcon? = nil,
        keyboardKey: String? = nil,
        isLabelMonospaced: Bool = false,
        isContentSansSerif: Bool = false,
        hasBorder: Bool = true,
        matomoStatus: MatomoStatus = .DECLINED
    ) {
        self.id = id
        self.label = label
        self.content = content
        self.icon = icon
        self.keyboardKey = keyboardKey
        self.isLabelMonospaced = isLabelMonospaced
        self.isContentSansSerif = isContentSansSerif
        self.hasBorder = hasBorder
        self.matomoStatus = matomoStatus
    }

    /// Creates a new configuration instance for `Accordion` using a `@Builder` element closure.
    ///
    /// - Parameters:
    ///   - id: Optional identifier. Falls back to a hash of the label if omitted.
    ///   - label: Header label text for the accordion section.
    ///   - content: Builder closure returning an array of HTML/SGML elements.
    ///   - icon: Optional SVG icon to display alongside the label.
    ///   - keyboardKey: Optional keyboard shortcut key indicator.
    ///   - isLabelMonospaced: Whether the label uses a monospaced font.
    ///   - isContentSansSerif: Whether the body content uses sans-serif typography.
    ///   - hasBorder: Whether a border is rendered around the accordion.
    ///   - matomoStatus: Matomo analytics tracking consent status.
    public init(
        id: String? = nil,
        label: String,
        @Builder<SGML.Element> content: () -> [any SGML.Element],
        icon: SvgIcon? = nil,
        keyboardKey: String? = nil,
        isLabelMonospaced: Bool = false,
        isContentSansSerif: Bool = false,
        hasBorder: Bool = true,
        matomoStatus: MatomoStatus = .DECLINED
    ) {
        self.id = id
        self.label = label
        self.content = .element(content())
        self.icon = icon
        self.keyboardKey = keyboardKey
        self.isLabelMonospaced = isLabelMonospaced
        self.isContentSansSerif = isContentSansSerif
        self.hasBorder = hasBorder
        self.matomoStatus = matomoStatus
    }
}
