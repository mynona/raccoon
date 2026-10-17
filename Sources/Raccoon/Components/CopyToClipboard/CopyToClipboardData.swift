/// A data model that provides configuration for the `CopyToClipboard` UI component.
public struct CopyToClipboardData: Sendable {

    /// Defines the layout orientation of the copy button.
    ///
    /// - `horizontal`: The icon and label are displayed side by side.
    /// - `vertical`: The icon is displayed above the label, both centered horizontally.
    public enum Orientation: Sendable {
        case horizontal
        case vertical
    }

    /// The form field key (used as the `name` attribute of the hidden input).
    ///
    /// This is the identifier under which the selected value will be submitted
    /// when included in a form. Defaults to a deterministic hash of `value` if not provided.
    public let key: String

    /// The actual string value that will be copied to the clipboard
    /// when the user interacts with the component.
    public let value: String

    /// The orientation of the copy button layout.
    ///
    /// Determines whether the icon and label are arranged horizontally
    /// (side by side) or vertically (stacked).
    public let orientation: Orientation

    /// The Matomo tracking consent status.
    public let matomoStatus: MatomoStatus

    /// Creates a new `CopyToClipboardData` instance.
    ///
    /// - Parameters:
    ///   - key: The form field key. Defaults to a deterministic hash of `value` if not provided.
    ///   - value: The string value to be copied to the clipboard.
    ///   - orientation: The layout orientation of the button. Defaults to `.horizontal`.
    ///   - matomoStatus: The Matomo tracking consent status. Defaults to `.DECLINED`.
    public init(
        key: String? = nil,
        value: String,
        orientation: Orientation = .horizontal,
        matomoStatus: MatomoStatus = .DECLINED
    ) {
        self.key = key ?? "copy-\(StableIdentifier.hash(value))"
        self.value = value
        self.orientation = orientation
        self.matomoStatus = matomoStatus
    }
}
