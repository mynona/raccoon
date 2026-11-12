/// Configuration data for the `ErrorSummary` component.
public struct ErrorSummaryData: Sendable {

    // MARK: - 1. Identity & Alpine Bindings
    public let id: String

    // MARK: - 4. Feedback & Validation
    public let entries: [FormErrorEntry]

    /// Creates a new configuration instance for `ErrorSummary`.
    ///
    /// - Parameters:
    ///   - id: Unique DOM identifier of the summary. The heading id is derived from it (`<id>-heading`).
    ///   - entries: One entry per field with a problem. The count in the heading is the number of entries.
    ///     With no entries the summary is rendered `hidden`, so a script can fill it later.
    public init(
        // 1. Identity & Alpine Bindings
        id: String,

        // 4. Feedback & Validation
        entries: [FormErrorEntry] = []
    ) {
        // 1. Identity & Alpine Bindings
        self.id = id

        // 4. Feedback & Validation
        self.entries = entries
    }
}
