/// Configuration data for the `FileList` component.
public struct FileListData: Sendable {
    public let uploadId: String?
    public let hasRemoveAction: Bool
    public let contentTracker: MatomoContentTracker?

    /// Creates a new configuration instance for `FileList`.
    ///
    /// - Parameters:
    ///   - uploadId: Optional identifier of the associated upload input.
    ///   - hasRemoveAction: Whether to show a remove button for each listed file.
    ///   - contentTracker: Matomo content tracking configuration.
    public init(
        uploadId: String? = nil,
        hasRemoveAction: Bool = true,
        contentTracker: MatomoContentTracker? = MatomoContentTracker(
            name: "file-upload",
            piece: "button.remove",
            target: ""
        )
    ) {
        self.uploadId = uploadId
        self.hasRemoveAction = hasRemoveAction
        self.contentTracker = contentTracker
    }
}
