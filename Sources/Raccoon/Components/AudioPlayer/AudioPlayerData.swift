/// Configuration data for the `AudioPlayer` component.
public struct AudioPlayerData: Sendable {
    public let title: String?
    public let disclaimer: String?
    public let linkToTheAudioFile: String
    public let hasProgressBar: Bool
    public let matomoStatus: MatomoStatus

    /// Creates a new configuration instance for `AudioPlayer`.
    ///
    /// - Parameters:
    ///   - title: Optional title of the audio track.
    ///   - disclaimer: Optional disclaimer text shown with the player.
    ///   - linkToTheAudioFile: URL of the audio file to play.
    ///   - hasProgressBar: Whether to display a playback progress bar.
    ///   - matomoStatus: Matomo analytics tracking consent status.
    public init(
        title: String? = nil,
        disclaimer: String? = nil,
        linkToTheAudioFile: String,
        hasProgressBar: Bool = true,
        matomoStatus: MatomoStatus = .DECLINED
    ) {
        self.title = title
        self.disclaimer = disclaimer
        self.linkToTheAudioFile = linkToTheAudioFile
        self.hasProgressBar = hasProgressBar
        self.matomoStatus = matomoStatus
    }
}
