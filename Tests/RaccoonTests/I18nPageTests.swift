import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

private func count(of needle: String, in haystack: String) -> Int {
    haystack.components(separatedBy: needle).count - 1
}

/// Page-level checks (G2): many components on one page share one store and one dictionary.
@Suite("I18nPage")
struct I18nPageTests {

    private let tracker = MatomoContentTracker(
        name: "page",
        piece: "test",
        target: "#"
    )

    /// A form with 10 fields and a list with 50 buttons, followed by the page scripts.
    private func page(language: String) -> String {
        I18n.render(language: language, collectsUsedKeys: true) {
            var elements: [any Element] = []
            for index in 0..<10 {
                elements += InputField(
                    InputFieldData(
                        id: "field-\(index)",
                        label: LabelData(
                            id: "field-\(index)",
                            title: LocalizedText(verbatim: "Field \(index)"),
                            isRequired: true
                        )
                    )
                )
                .render()
            }
            for index in 0..<50 {
                elements += ActionButton(
                    ActionButtonData(
                        id: "button-\(index)",
                        buttonType: .icon,
                        contentTracker: tracker
                    )
                )
                .render()
            }
            elements += I18n.scripts()
            return renderHTML(elements)
        }
    }

    @Test("one store script and one dictionary, each used key once")
    func oneStoreOneDictionary() {
        for language in ["en", "de"] {
            let html = page(language: language)
            #expect(count(of: "src=\"/js/i18n.js\"", in: html) == 1)
            #expect(count(of: "data-raccoon-i18n", in: html) == 1)
            // The dictionary is a data block, not an executable inline script
            #expect(html.contains("<script type=\"application/json\""))
            #expect(!html.contains("i.register"))
            // The data block is written before the store script
            #expect(
                html.range(of: "data-raccoon-i18n")!.lowerBound
                    < html.range(of: "src=\"/js/i18n.js\"")!.lowerBound
            )
            // Both built-in keys that the page used are registered, once
            #expect(count(of: "\"label\":{", in: html) == 1)
            #expect(count(of: "\"actionbutton\":{", in: html) == 1)
            #expect(
                count(of: "\"en\":{\"required\":\"(required)\"}", in: html) == 1
            )
            #expect(count(of: "\"en\":{\"action\":\"Action\"}", in: html) == 1)
        }
    }

    @Test(
        "the page is rendered in the page language and needs no further request"
    )
    func renderedInPageLanguage() {
        let html = page(language: "de")
        #expect(
            count(
                of: "data-i18n=\"label.required\">(erforderlich)</span>",
                in: html
            ) == 10
        )
        #expect(count(of: "aria-label=\"Aktion\"", in: html) == 50)
        // Only the store is loaded: no per-language or per-component dictionary files
        #expect(count(of: "/js/i18n", in: html) == 1)
        #expect(!html.contains("/js/i18n/"))
    }

    @Test(
        "a page without translatable texts and without collecting registers nothing"
    )
    func noKeysNoDictionaryEntries() {
        let html = I18n.render(language: "de", collectsUsedKeys: true) {
            renderHTML(I18n.scripts())
        }
        #expect(html.contains("data-raccoon-i18n>{}</script>"))
    }

    @Test(
        "the dictionary for 60 translatable components stays under 2 KB (2 keys in 20 languages)"
    )
    func dictionaryIsSmall() {
        let html = page(language: "de")
        let start = html.range(of: "<script type=\"application/json\"")!
            .lowerBound
        #expect(html[start...].utf8.count < 2000)
    }
}
