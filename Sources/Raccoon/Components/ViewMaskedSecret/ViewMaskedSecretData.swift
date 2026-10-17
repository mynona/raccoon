/// Data object for configuring the `ViewMaskedSecret` component.
///
/// This struct defines the behavior of the masked secret view,
/// including how much of the secret is revealed, how long it stays visible,
/// and whether copy-to-clipboard functionality is enabled.
public struct ViewMaskedSecretData: Sendable {

    /// The raw secret string to be displayed.
    ///
    /// This value may represent sensitive information such as
    /// an API key, token, or password. It will be masked in the UI
    /// except for the last `revealCount` characters when hidden.
    public let secret: String

    /// The number of characters at the end of the secret
    /// that remain visible when the secret is masked.
    ///
    /// Defaults to `3`. For example, a secret `"abcdef"`
    /// with `revealCount = 3` will be shown as `"•••def"`.
    public let revealCount: Int

    /// The duration (in milliseconds) that the secret
    /// remains visible after being revealed.
    ///
    /// Defaults to `3000` (3 seconds). After this time,
    /// the secret will automatically be masked again.
    public let revealDuration: Int

    /// A flag indicating whether the copy-to-clipboard
    /// button should be displayed.
    ///
    /// Defaults to `true`. If set to `false`, the user
    /// will not see the copy button and cannot copy the secret.
    public let hasCopyToClipboard: Bool

    /// Creates a new configuration for the `ViewMaskedSecret` component.
    ///
    /// - Parameters:
    ///   - secret: The raw secret string to display.
    ///   - revealCount: How many characters at the end remain visible when masked. Defaults to `3`.
    ///   - revealDuration: How long (ms) the secret stays visible after reveal. Defaults to `3000`.
    ///   - hasCopyToClipboard: Whether the copy-to-clipboard button is shown. Defaults to `true`.
    public init(
        secret: String,
        revealCount: Int = 3,
        revealDuration: Int = 3000,
        hasCopyToClipboard: Bool = true
    ) {
        self.secret = secret
        self.revealCount = revealCount
        self.revealDuration = revealDuration
        self.hasCopyToClipboard = hasCopyToClipboard
    }
}
