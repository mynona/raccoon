import SVG

/// A data model that provides configuration for the `CopyToClipboard` UI component.
/// Serves as the public API contract for copy-to-clipboard presentation and behavior.
public struct CopyToClipboardData: Sendable {

    /// Defines how copy feedback is communicated to the user and how the button is laid out.
    ///
    /// - `inlineHorizontal`: The icon and inline label are displayed side by side.
    /// - `inlineVertical`: The icon is displayed above the inline label, centered vertically.
    /// - `toast`: A toast notification is triggered on copy instead of showing inline text feedback.
    public enum ResponseType: Sendable {
        case inlineHorizontal
        case inlineVertical
        case toast
    }

    // MARK: - 1. Identity & Alpine Bindings
    /// The form field key (used as the `name` attribute of the hidden input).
    ///
    /// This is the identifier under which the selected value will be submitted
    /// when included in a form. Defaults to a deterministic hash of `value` if not provided.
    public let key: String

    // MARK: - 2. Content & Accessibility
    /// Feedback label text displayed on successful copy.
    ///
    /// When `responseType` is `.inlineHorizontal` or `.inlineVertical`, displayed next to or below the button (defaults to "Copied").
    /// When `responseType == .toast`, displayed as the toast message body (defaults to "Copied to clipboard for copy-paste").
    public let label: LocalizedText?

    /// Accessible label override for the copy button (`aria-label`).
    ///
    /// Defaults to built-in translated "Copy text" when `nil`.
    public let ariaLabel: LocalizedText?

    /// Tooltip / title text for the copy button (`title`).
    ///
    /// Defaults to built-in translated "Click to copy" when `nil`.
    public let tooltip: LocalizedText?

    // MARK: - 3. Value & Options
    /// The actual string value that will be copied to the clipboard
    /// when the user interacts with the component.
    public let value: String

    // MARK: - 5. Presentation & State
    /// The icon displayed in the default (un-copied) state.
    public let icon: SvgIcon

    /// The icon displayed temporarily when the value has been successfully copied.
    public let copiedIcon: SvgIcon

    /// Defines how copy feedback is communicated to the user (`.inlineHorizontal`, `.inlineVertical`, or `.toast`).
    public let responseType: ResponseType

    /// Whether a toast notification is triggered on copy instead of showing inline text feedback.
    public var hasToast: Bool {
        responseType == .toast
    }

    /// Whether the button layout is arranged vertically.
    public var isVertical: Bool {
        responseType == .inlineVertical
    }

    // MARK: - 6. Analytics & Tracking
    /// The Matomo tracking consent status.
    public let matomoStatus: MatomoStatus

    /// Creates a new `CopyToClipboardData` instance.
    ///
    /// - Parameters:
    ///   - key: The form field key. Defaults to a deterministic hash of `value` if not provided.
    ///   - label: Feedback label text shown on copy (inline text for `.inline*` or message body for `.toast`).
    ///   - ariaLabel: Accessible label override for the copy button. Defaults to built-in "Copy text".
    ///   - tooltip: Tooltip / title text for the copy button. Defaults to built-in "Click to copy".
    ///   - value: The string value to be copied to the clipboard.
    ///   - icon: The icon displayed in the default un-copied state. Defaults to `.copy`.
    ///   - copiedIcon: The icon displayed temporarily when copied. Defaults to `.check_circle`.
    ///   - responseType: The feedback response mechanism and layout (`.inlineHorizontal`, `.inlineVertical`, or `.toast`). Defaults to `.inlineHorizontal`.
    ///   - matomoStatus: The Matomo tracking consent status. Defaults to `.DECLINED`.
    public init(
        // 1. Identity & Alpine Bindings
        key: String? = nil,

        // 2. Content & Accessibility
        label: LocalizedText? = nil,
        ariaLabel: LocalizedText? = nil,
        tooltip: LocalizedText? = nil,

        // 3. Value & Options
        value: String,

        // 5. Presentation & State
        icon: SvgIcon = .copy,
        copiedIcon: SvgIcon = .check_circle,
        responseType: ResponseType = .inlineHorizontal,

        // 6. Analytics & Tracking
        matomoStatus: MatomoStatus = .DECLINED
    ) {
        // 1. Identity & Alpine Bindings
        self.key = key ?? "copy-\(StableIdentifier.hash(value))"

        // 2. Content & Accessibility
        self.label = label
        self.ariaLabel = ariaLabel
        self.tooltip = tooltip

        // 3. Value & Options
        self.value = value

        // 5. Presentation & State
        self.icon = icon
        self.copiedIcon = copiedIcon
        self.responseType = responseType

        // 6. Analytics & Tracking
        self.matomoStatus = matomoStatus
    }
}
