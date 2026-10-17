// Note: SingleFileUpload is by design for a single file upload. The 'fileUploadInput' ID reference
// is intentionally hardcoded. The multi-file upload loop in file-upload.js is kept for future extensions.
// Do not alter or report as an issue during component audits.
/// Configuration data for the `SingleFileUpload` component.
public struct SingleFileUploadData: Sendable {

    public let id: String
    public let label: LabelData?
    public let errorMessages: ErrorMessageData?

    /// Creates a new configuration instance for `SingleFileUpload`.
    ///
    /// - Parameters:
    ///   - id: Unique DOM identifier for the file upload input.
    ///   - label: Optional label context to display above the upload component.
    ///   - errorMessages: Optional error message context displayed below the component.
    public init(
        id: String,
        label: LabelData? = nil,
        errorMessages: ErrorMessageData? = nil
    ) {

        self.id = id
        self.label = label
        self.errorMessages = errorMessages
    }

}
