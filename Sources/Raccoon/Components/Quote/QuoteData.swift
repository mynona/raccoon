/// Configuration data for the `Quote` blockquote component.
public struct QuoteData: Sendable {

    public let quote: LocalizedText
    public let citation: LocalizedText?
    public let hasQuotationMarks: Bool

    /// Creates a new configuration instance for `Quote`.
    ///
    /// - Parameters:
    ///   - quote: Body text of the quotation.
    ///   - citation: Optional author, speaker, or source citation.
    ///   - hasQuotationMarks: Whether to visually render quotation marks.
    public init(
        quote: LocalizedText,
        citation: LocalizedText?,
        hasQuotationMarks: Bool = true
    ) {
        self.quote = quote
        self.citation = citation
        self.hasQuotationMarks = hasQuotationMarks
    }
}
