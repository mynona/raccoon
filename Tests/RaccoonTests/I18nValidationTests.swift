import Foundation
import Testing

@testable import Raccoon

/// Validates the built-in translations (`Translations.all`) against the Swift code that uses them.
/// Pure functions on values and text, so every check is testable with fixtures.
enum I18nValidator {
    typealias Tables = [String: [String: [String: String]]]

    /// Central list of supported base languages. Add a language here to extend the system.
    static let supportedLanguages = ["en", "de", "fr", "es", "it"]

    /// Keys that are only used in hand-written Alpine expressions (invisible to the Swift scan).
    /// Add a Swift comment next to the usage when adding a key here.
    static let allowedUnusedKeys: Set<String> = ["carousel.slide"]

    private static func matches(_ pattern: String, in text: String)
        -> [NSTextCheckingResult]
    {
        // swiftlint:disable:next force_try
        let regex = try! NSRegularExpression(pattern: pattern)
        return regex.matches(
            in: text,
            range: NSRange(text.startIndex..., in: text)
        )
    }

    private static func group(
        _ match: NSTextCheckingResult,
        _ index: Int,
        in text: String
    ) -> String {
        Range(match.range(at: index), in: text).map { String(text[$0]) } ?? ""
    }

    static func placeholders(_ text: String) -> [String] {
        matches(#"\{\{(\w+)\}\}"#, in: text).map { group($0, 1, in: text) }
            .sorted()
    }

    static func validate(
        tables: Tables,
        swiftSources: [String: String]
    ) -> [String] {
        var issues: [String] = []

        for namespace in tables.keys.sorted() {
            if namespace.range(
                of: #"^[a-z][a-z0-9]*$"#,
                options: .regularExpression
            ) == nil {
                issues.append(
                    "\(namespace): the namespace must be lowercase letters and digits"
                )
            }
            for key in tables[namespace]!.keys.sorted() {
                let full = "\(namespace).\(key)"
                let entries = tables[namespace]![key]!
                guard let english = entries["en"] else {
                    issues.append("\(full): missing English (en)")
                    continue
                }
                for language in entries.keys.sorted()
                where !supportedLanguages.contains(language) {
                    issues.append(
                        "\(full): invalid or unsupported language \"\(language)\""
                    )
                }
                for language in supportedLanguages where language != "en" {
                    guard let text = entries[language] else {
                        issues.append("\(full).\(language) missing")
                        continue
                    }
                    if placeholders(text) != placeholders(english) {
                        issues.append(
                            "\(full).\(language) placeholders differ from English"
                        )
                    }
                }
                for language in entries.keys.sorted()
                where entries[language]!.trimmingCharacters(in: .whitespaces)
                    .isEmpty
                {
                    issues.append("\(full).\(language) is empty")
                }
            }
        }

        // Cross-check the Swift side: every built-in LocalizedText key must exist and its English default must match.
        var usedKeys = Set<String>()
        let usage =
            #"LocalizedText\(\s*"(\w+)\.(\w+)"\s*,\s*"((?:[^"\\]|\\.)*)""#
        for file in swiftSources.keys.sorted() {
            let source = swiftSources[file]!
            for match in matches(usage, in: source) {
                let namespace = group(match, 1, in: source)
                let key = group(match, 2, in: source)
                let raw = group(match, 3, in: source)
                let prefix = source[
                    ..<Range(match.range, in: source)!.lowerBound
                ]
                let line = prefix.filter { $0 == "\n" }.count + 1
                usedKeys.insert("\(namespace).\(key)")
                if raw.contains("\\(") {
                    issues.append(
                        "\(file):\(line): \(namespace).\(key): use {{name}} placeholders, not Swift interpolation"
                    )
                    continue
                }
                let english = raw.replacingOccurrences(of: "\\\"", with: "\"")
                    .replacingOccurrences(of: "\\\\", with: "\\")
                guard let registered = tables[namespace]?[key]?["en"] else {
                    issues.append(
                        "\(file):\(line): \(namespace).\(key) is not defined in the translations"
                    )
                    continue
                }
                if registered != english {
                    issues.append(
                        "\(file):\(line): \(namespace).\(key): Swift default differs from the en translation"
                    )
                }
            }
        }
        for namespace in tables.keys.sorted() {
            for key in tables[namespace]!.keys.sorted() {
                let full = "\(namespace).\(key)"
                if !usedKeys.contains(full) && !allowedUnusedKeys.contains(full)
                {
                    issues.append("\(full) is not used by any LocalizedText")
                }
            }
        }
        return issues
    }
}

@Suite("I18nValidation")
struct I18nValidationTests {

    private static let root = URL(fileURLWithPath: #filePath)
        .deletingLastPathComponent().deletingLastPathComponent()
        .deletingLastPathComponent()

    private static func readSwiftFiles(in directory: String) -> [String: String]
    {
        let url = root.appendingPathComponent(directory)
        guard
            let enumerator = FileManager.default.enumerator(
                at: url,
                includingPropertiesForKeys: nil
            )
        else { return [:] }
        var result: [String: String] = [:]
        for case let file as URL in enumerator
        where file.pathExtension == "swift" {
            result[
                file.path.replacingOccurrences(of: root.path + "/", with: "")
            ] =
                try? String(contentsOf: file, encoding: .utf8)
        }
        return result
    }

    @Test("the built-in translations match the Swift code")
    func repositoryIsValid() {
        let issues = I18nValidator.validate(
            tables: Translations.all,
            swiftSources: Self.readSwiftFiles(in: "Sources/Raccoon")
                .merging(Self.readSwiftFiles(in: "Sources/Preview")) { first, _ in first }
        )
        #expect(
            issues.isEmpty,
            Comment(rawValue: issues.joined(separator: "\n"))
        )
    }

    // MARK: fixtures: every check must fire

    private static func entry(
        de: String? = "Pause",
        fr: String? = "Pause",
        extra: [String: String] = [:]
    ) -> [String: String] {
        var result = ["en": "Pause", "es": "Pausa", "it": "Pausa"]
        if let de { result["de"] = de }
        if let fr { result["fr"] = fr }
        return result.merging(extra) { _, new in new }
    }

    private func issues(
        _ entries: [String: String],
        namespace: String = "audio",
        swift: String = #"let t = LocalizedText("audio.pause", "Pause")"#
    ) -> [String] {
        I18nValidator.validate(
            tables: [namespace: ["pause": entries]],
            swiftSources: ["Sources/Raccoon/Audio.swift": swift]
        )
    }

    @Test("a correct table has no issues")
    func validFixture() {
        #expect(issues(Self.entry()).isEmpty)
    }

    @Test("detects a missing translation")
    func missingLanguage() {
        #expect(
            issues(Self.entry(de: nil))
                .contains { $0.contains("audio.pause.de missing") }
        )
    }

    @Test("detects missing English")
    func missingEnglish() {
        var entries = Self.entry()
        entries["en"] = nil
        #expect(issues(entries).contains { $0.contains("missing English") })
    }

    @Test("detects an unsupported language")
    func unsupportedLanguage() {
        #expect(
            issues(Self.entry(extra: ["ja": "x"]))
                .contains { $0.contains("unsupported language \"ja\"") }
        )
    }

    @Test("detects differing placeholders")
    func placeholdersDiffer() {
        let result = I18nValidator.validate(
            tables: [
                "audio": [
                    "page": [
                        "en": "Page {{number}}", "de": "Seite",
                        "fr": "Page {{number}}",
                        "es": "Página {{number}}", "it": "Pagina {{number}}",
                    ]
                ]
            ],
            swiftSources: [
                "Sources/Raccoon/Audio.swift":
                    #"LocalizedText("audio.page", "Page {{number}}")"#
            ]
        )
        #expect(
            result.contains { $0.contains("audio.page.de placeholders differ") }
        )
    }

    @Test("detects empty values")
    func emptyValue() {
        #expect(
            issues(Self.entry(de: " "))
                .contains { $0.contains("audio.pause.de is empty") }
        )
    }

    @Test("detects an invalid namespace")
    func invalidNamespace() {
        #expect(
            issues(Self.entry(), namespace: "Audio-Player", swift: "")
                .contains { $0.contains("namespace must be lowercase") }
        )
    }

    @Test("detects Swift keys that are not defined or differ from en")
    func swiftSide() {
        let undefined = issues(
            Self.entry(),
            swift: #"LocalizedText("audio.play", "Play")"#
        )
        #expect(undefined.contains { $0.contains("audio.play is not defined") })
        let differs = issues(
            Self.entry(),
            swift: #"LocalizedText("audio.pause", "Stop")"#
        )
        #expect(
            differs.contains {
                $0.contains("Swift default differs from the en translation")
            }
        )
        #expect(
            differs.first { $0.contains("Swift default") }?
                .contains("Audio.swift:1:") == true
        )
    }

    @Test("detects Swift interpolation instead of placeholders")
    func interpolation() {
        let result = issues(
            Self.entry(),
            swift: #"LocalizedText("audio.pause", "Page \(number)")"#
        )
        #expect(result.contains { $0.contains("not Swift interpolation") })
    }

    @Test("detects keys that no Swift code uses, except allow-listed keys")
    func unusedKeys() {
        #expect(
            issues(Self.entry(), swift: "")
                .contains { $0.contains("audio.pause is not used") }
        )
        let allowed = I18nValidator.validate(
            tables: ["carousel": ["slide": Self.entry()]],
            swiftSources: [:]
        )
        #expect(!allowed.contains { $0.contains("carousel.slide is not used") })
    }
}
