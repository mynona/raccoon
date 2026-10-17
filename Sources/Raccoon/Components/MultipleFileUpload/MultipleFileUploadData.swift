public struct MultipleFileUploadData: Sendable {

    public let id: String
    public let label: LabelData?
    public let errorMessages: ErrorMessageData?

    public init(
        id: String = "multipleFileUploadInput",
        label: LabelData? = nil,
        errorMessages: ErrorMessageData? = nil
    ) {
        self.id = id
        self.label = label
        self.errorMessages = errorMessages
    }

}
