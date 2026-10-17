public struct DeleteModalData: Sendable {

    public let deletionRedirect: String
    public let csrfToken: String?

    public init(
        deletionRedirect: String,
        csrfToken: String?

    ) {
        self.deletionRedirect = deletionRedirect
        self.csrfToken = csrfToken
    }
}
