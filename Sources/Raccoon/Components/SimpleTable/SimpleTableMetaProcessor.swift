import Foundation

/// A pure, deterministic schema‑normalization helper used to prepare
/// table metadata and row data before it is passed into Alpine.js.
///
/// This processor is responsible for:
/// - decoding the raw CMS-provided JSON strings (`meta` and `rows`)
/// - applying structural extensions (e.g., auto‑generated index column)
/// - ensuring column/row symmetry
/// - re‑encoding the normalized structures back into JSON
///
/// It performs **no rendering logic** and has **no UI concerns**.
/// If decoding or encoding fails, the caller can decide how to handle it.
public struct SimpleTableMetaProcessor {

    /// Normalizes and extends the table schema based on the CMS-provided
    /// `meta` and `rows` JSON strings.
    ///
    /// - Parameters:
    ///   - meta: A JSON string describing table metadata (columns, flags, etc.)
    ///   - rows: A JSON string describing the table rows.
    ///
    /// - Returns: A tuple containing normalized `meta` and `rows` JSON strings.
    ///
    /// - Throws: Any decoding or encoding error encountered during processing.
    ///
    /// This function is intentionally fallible so the caller (e.g. `SimpleTableData`)
    /// can return `nil` and suppress rendering if the configuration is invalid.
    public static func process(meta: String, rows: String) throws -> (
        meta: String, rows: String
    ) {

        struct Column: Codable {
            let key: String
            let label: String
            let type: String
            let align: String
            let sortable: Bool
            let hideable: Bool?
        }

        struct Meta: Codable {
            var hasIndexColumn: Bool?
            var hasColumnConfigurator: Bool?
            var hasSearch: Bool?
            var hasCopyToClipboard: Bool?
            var storageKey: String?
            var columns: [Column]
        }

        // Decode CMS JSON into Swift structures
        var metaObj = try JSONDecoder().decode(Meta.self, from: Data(meta.utf8))
        var rowsArray = try JSONDecoder()
            .decode([[String: String]].self, from: Data(rows.utf8))

        // Normalize hasColumnConfigurator: default = true
        let configuratorEnabled = metaObj.hasColumnConfigurator ?? true
        metaObj.hasColumnConfigurator = configuratorEnabled

        let searchEnabled = metaObj.hasSearch ?? true
        metaObj.hasSearch = searchEnabled

        let copyEnabled = metaObj.hasCopyToClipboard ?? true
        metaObj.hasCopyToClipboard = copyEnabled

        let indexEnabled = metaObj.hasIndexColumn ?? false

        if indexEnabled {

            // Add synthetic index column if missing
            if !metaObj.columns.contains(where: { $0.key == "id" }) {
                let indexCol = Column(
                    key: "id",
                    label: "#",
                    type: "number",
                    align: "left",
                    sortable: true,
                    hideable: true
                )
                metaObj.columns.insert(indexCol, at: 0)
            }

            // Inject sequential id values into rows
            for i in 0..<rowsArray.count where rowsArray[i]["id"] == nil {
                rowsArray[i]["id"] = String(i + 1)
            }
        }
        else {
            // Normalize omitted indexcolumn to explicit false
            metaObj.hasIndexColumn = false
        }

        // Encode normalized structures back into JSON
        let metaData = try jsonEncoder.encode(metaObj)
        let rowsData = try jsonEncoder.encode(rowsArray)

        return (
            meta: String(decoding: metaData, as: UTF8.self),
            rows: String(decoding: rowsData, as: UTF8.self)
        )
    }

    private static let jsonEncoder = JSONEncoder()
}
