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

    /// A renamed or missing JS file breaks a component silently in the browser, so every script path that
    /// the library or the Preview app references must exist in `Public`. Library scripts carry the
    /// `raccoon-` prefix, Preview scripts the `preview-` prefix.
    @Test("every referenced script file exists and has the expected prefix")
    func referencedScriptsExist() throws {
        let root = URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .deletingLastPathComponent()
        let reference = try Regex(#""/(js|js-preview)/([A-Za-z0-9._-]+\.js)""#)

        var problems: [String] = []
        for folder in ["Sources/Raccoon", "Sources/Preview"] {
            let files = try #require(
                FileManager.default.enumerator(
                    at: root.appendingPathComponent(folder),
                    includingPropertiesForKeys: nil
                )
            )
            for case let file as URL in files where file.pathExtension == "swift" {
                let text = try String(contentsOf: file, encoding: .utf8)
                for match in text.matches(of: reference) {
                    let directory = String(match.output[1].substring ?? "")
                    let name = String(match.output[2].substring ?? "")
                    let path = root.appendingPathComponent("Public/\(directory)/\(name)").path
                    if !FileManager.default.fileExists(atPath: path) {
                        problems.append("\(file.lastPathComponent): /\(directory)/\(name) does not exist")
                    }
                    let prefix = directory == "js" ? "raccoon-" : "preview-"
                    if !name.hasPrefix(prefix) {
                        problems.append("\(file.lastPathComponent): /\(directory)/\(name) must start with \(prefix)")
                    }
                }
            }
        }
        #expect(problems.isEmpty, "\(problems)")
    }
}
