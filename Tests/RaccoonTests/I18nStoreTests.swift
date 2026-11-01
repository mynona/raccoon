import Foundation
import Testing

/// Pins down the contract of `Public/js/i18n.js` without running JavaScript (no Node, no `.mjs`).
/// Behavior in a real DOM (language switch, fallbacks) is checked manually in the Preview app.
@Suite("I18nStore")
struct I18nStoreTests {

    private static let source: String = {
        let root = URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent().deletingLastPathComponent()
            .deletingLastPathComponent()
        let url = root.appendingPathComponent("Public/js/i18n.js")
        return (try? String(contentsOf: url, encoding: .utf8)) ?? ""
    }()

    @Test("the store file exists and is not empty")
    func fileExists() {
        #expect(!Self.source.isEmpty)
    }

    @Test("exposes the public API used by Swift-rendered markup")
    func publicAPI() {
        #expect(Self.source.contains("RaccoonI18n"))
        for member in ["register:", "t:", "pick:"] {
            #expect(
                Self.source.contains(member),
                "missing API member \(member)"
            )
        }
    }

    @Test("reads all markers that LocalizedText renders")
    func markers() {
        // Attribute markers are built as 'data-i18n-' + name
        for marker in [
            "data-i18n", "data-i18n-vars", "'data-i18n-'", "aria-label",
            "title", "placeholder", "alt",
        ] {
            #expect(Self.source.contains(marker), "missing marker \(marker)")
        }
    }

    @Test("follows <html lang> and ignores a second include")
    func languageAndIdempotence() {
        #expect(Self.source.contains("documentElement"))
        #expect(Self.source.contains("MutationObserver"))
        #expect(Self.source.contains("window.RaccoonI18n"))
    }

    @Test("never inserts variables as HTML")
    func noInnerHTML() {
        #expect(!Self.source.contains("innerHTML"))
        #expect(!Self.source.contains("insertAdjacentHTML"))
    }

    @Test("loads nothing on demand: translations come from the page")
    func noOnDemandLoading() {
        #expect(!Self.source.contains("createElement('script')"))
        #expect(!Self.source.contains("override:"))
    }

    @Test("reads the markers of consumer texts")
    func consumerTexts() {
        #expect(Self.source.contains("-values"))
        #expect(Self.source.contains("function pick("))
    }

    @Test("makes Alpine expressions that call t() or pick() reactive")
    func alpineReactivity() {
        #expect(Self.source.contains("Alpine.reactive"))
        #expect(Self.source.contains("function notify()"))
    }

    @Test("the language getter is reactive for Alpine expressions")
    func languageIsTracked() {
        #expect(Self.source.contains("get language()"))
        let getter =
            Self.source.components(separatedBy: "get language()").last ?? ""
        #expect(getter.prefix(120).contains("track();"))
    }
}
