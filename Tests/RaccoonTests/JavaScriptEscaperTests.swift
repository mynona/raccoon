import Foundation
import Raccoon
import Testing

@testable import Raccoon

@Suite("JavaScriptEscaper")
struct JavaScriptEscaperTests {

    private struct SampleModel: Codable, Equatable {
        let name: String
        let count: Int
        let active: Bool
    }

    @Test("jsonStringLiteral encodes standard strings with quotes")
    func testJsonStringLiteralStandard() {
        #expect(JavaScriptEscaper.jsonStringLiteral("hello") == "\"hello\"")
        #expect(JavaScriptEscaper.jsonStringLiteral("") == "\"\"")
        #expect(JavaScriptEscaper.jsonStringLiteral("42") == "\"42\"")
    }

    @Test("jsonStringLiteral correctly escapes special characters")
    func testJsonStringLiteralSpecialCharacters() {
        let input = "quote: \"hello\", backslash: \\, newline: \n, tab: \t"
        let encoded = JavaScriptEscaper.jsonStringLiteral(input)
        let data = encoded.data(using: .utf8)!
        let decoded = try? JSONDecoder().decode(String.self, from: data)
        #expect(decoded == input)
    }

    @Test("jsonStringLiteral preserves unicode and emojis")
    func testJsonStringLiteralUnicode() {
        let input = "Raccoon 🦝 & café"
        let encoded = JavaScriptEscaper.jsonStringLiteral(input)
        let data = encoded.data(using: .utf8)!
        let decoded = try? JSONDecoder().decode(String.self, from: data)
        #expect(decoded == input)
    }

    @Test("jsonEncode encodes Codable objects correctly")
    func testJsonEncodeObjects() throws {
        let model = SampleModel(name: "Test", count: 7, active: true)
        let json = JavaScriptEscaper.jsonEncode(model)
        let data = json.data(using: .utf8)!
        let decoded = try JSONDecoder().decode(SampleModel.self, from: data)
        #expect(decoded == model)
    }

    @Test("jsonEncode encodes primitive collections")
    func testJsonEncodeCollections() throws {
        let array = [1, 2, 3]
        let json = JavaScriptEscaper.jsonEncode(array)
        let data = json.data(using: .utf8)!
        let decoded = try JSONDecoder().decode([Int].self, from: data)
        #expect(decoded == array)
    }

    @Test("escapeSingleQuotedString escapes quotes, backslashes, and newlines")
    func testEscapeSingleQuotedString() {
        #expect(JavaScriptEscaper.escapeSingleQuotedString("O'Reilly") == "O\\'Reilly")
        #expect(JavaScriptEscaper.escapeSingleQuotedString("path\\to\\file") == "path\\\\to\\\\file")
        #expect(JavaScriptEscaper.escapeSingleQuotedString("line1\nline2") == "line1\\nline2")
        #expect(JavaScriptEscaper.escapeSingleQuotedString("line1\r\nline2") == "line1\\r\\nline2")
        #expect(JavaScriptEscaper.escapeSingleQuotedString("u\u{2028}v\u{2029}w") == "u\\u2028v\\u2029w")
    }

    @Test("alpineStringLiteral wraps escaped content in single quotes")
    func testAlpineStringLiteral() {
        #expect(JavaScriptEscaper.alpineStringLiteral("hello") == "'hello'")
        #expect(JavaScriptEscaper.alpineStringLiteral("O'Connor") == "'O\\'Connor'")
        #expect(JavaScriptEscaper.alpineStringLiteral("") == "''")
    }

    @Test("htmlAttributeEscape escapes HTML entities")
    func testHtmlAttributeEscape() {
        #expect(JavaScriptEscaper.htmlAttributeEscape("a & b") == "a &amp; b")
        #expect(JavaScriptEscaper.htmlAttributeEscape("value=\"test\"") == "value=&quot;test&quot;")
        #expect(JavaScriptEscaper.htmlAttributeEscape("it's") == "it&#39;s")
        #expect(JavaScriptEscaper.htmlAttributeEscape("<div>") == "&lt;div&gt;")
    }
}
