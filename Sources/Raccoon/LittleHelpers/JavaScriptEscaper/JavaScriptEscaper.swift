import Foundation

/// Safe serialization and escaping helpers for JavaScript/Alpine expressions.
public enum JavaScriptEscaper {
    private static let jsonEncoder = JSONEncoder()

    /// Serializes a Swift value to a valid JSON string literal (with quotes).
    /// If encoding fails, returns `""`.
    public static func jsonStringLiteral(_ value: String) -> String {
        guard let data = try? jsonEncoder.encode(value),
            let json = String(data: data, encoding: .utf8)
        else {
            return "\"\""
        }
        return json
    }

    /// Serializes any Encodable value to a JSON string.
    /// Returns fallback on failure.
    public static func jsonEncode<T: Encodable>(
        _ value: T,
        fallback: String = "null"
    ) -> String {
        guard let data = try? jsonEncoder.encode(value),
            let json = String(data: data, encoding: .utf8)
        else {
            return fallback
        }
        return json
    }

    /// Escapes a string so it can be safely embedded in a JavaScript single-quoted string literal (`'...'`).
    public static func escapeSingleQuotedString(_ value: String) -> String {
        value
            .replacingOccurrences(of: "\\", with: "\\\\")
            .replacingOccurrences(of: "'", with: "\\'")
            .replacingOccurrences(of: "\n", with: "\\n")
            .replacingOccurrences(of: "\r", with: "\\r")
            .replacingOccurrences(of: "\u{2028}", with: "\\u2028")
            .replacingOccurrences(of: "\u{2029}", with: "\\u2029")
    }

    /// Produces a single-quoted JS string literal (with surrounding quotes), safe to embed inside
    /// double-quoted HTML attributes (e.g. `x-data="..."`), since the HTML renderer does not
    /// HTML-escape attribute values. Prefer this over `jsonStringLiteral` for Alpine attribute values.
    public static func alpineStringLiteral(_ value: String) -> String {
        "'\(escapeSingleQuotedString(value))'"
    }

    /// HTML-entity-escapes a string so raw JSON/text (which may contain literal `"`) can be
    /// embedded as content inside a double-quoted HTML attribute (e.g. a JSON array passed to
    /// `x-data="..."`). The HTML renderer used in this project does not escape attribute values,
    /// so an embedded `"` would otherwise terminate the attribute early. Browsers decode entities
    /// before Alpine reads the attribute value, so this is transparent to JS/JSON parsing.
    public static func htmlAttributeEscape(_ value: String) -> String {
        value
            .replacingOccurrences(of: "&", with: "&amp;")
            .replacingOccurrences(of: "\"", with: "&quot;")
            .replacingOccurrences(of: "'", with: "&#39;")
            .replacingOccurrences(of: "<", with: "&lt;")
            .replacingOccurrences(of: ">", with: "&gt;")
    }
}
