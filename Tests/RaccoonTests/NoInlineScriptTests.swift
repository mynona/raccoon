import Foundation
import Testing

@Suite("Library renders no inline script")
struct NoInlineScriptTests {

    /// Raccoon is a public library: a consumer must be able to use a strict Content-Security-Policy
    /// without a nonce. Components therefore only emit `<script src="...">`.
    /// The only `Script(content)` is the JSON data block of `I18n` (`type="application/json"`, never executed).
    @Test("no component creates a script with inline content")
    func noInlineScriptContent() throws {
        let sources = URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .appendingPathComponent("Sources/Raccoon")
        let allowedFiles: Set<String> = ["I18n.swift"]
        let inlineScript = try Regex(#"\bScript\(\s*[^)\s]"#)

        var offenders: [String] = []
        let files = try #require(
            FileManager.default.enumerator(
                at: sources,
                includingPropertiesForKeys: nil
            )
        )
        for case let file as URL in files where file.pathExtension == "swift" {
            guard !allowedFiles.contains(file.lastPathComponent) else {
                continue
            }
            let text = try String(contentsOf: file, encoding: .utf8)
            if text.contains(inlineScript) {
                offenders.append(file.lastPathComponent)
            }
        }
        #expect(offenders.isEmpty, "Inline Script(...) in: \(offenders)")
    }
}
