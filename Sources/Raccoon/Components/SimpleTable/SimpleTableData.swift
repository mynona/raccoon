/// Configuration data for the `SimpleTable` component.
public struct SimpleTableData: Sendable {

    public let meta: String
    public let rows: String
    public let caption: String?

    public var json: String? {
        do {
            let processed = try SimpleTableMetaProcessor.process(
                meta: meta,
                rows: rows
            )

            let raw = """
                {
                  "meta": \(processed.meta),
                  "rows": \(processed.rows)
                }
                """

            return raw.replacingOccurrences(of: "\"", with: "'")

        }
        catch {
            // JSON generation failed
            return nil
        }
    }

    /// Creates a new configuration instance for `SimpleTable`.
    ///
    /// - Parameters:
    ///   - meta: Column metadata string defining table headers and keys.
    ///   - rows: Row data formatted as delimiter-separated strings.
    ///   - caption: Optional accessible caption title for the table.
    public init(
        meta: String,
        rows: String,
        caption: String?
    ) {
        self.meta = meta
        self.rows = rows
        self.caption = caption
    }

}
