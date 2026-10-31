import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("LanguageSwitcher")
struct LanguageSwitcherTests {

    let languages = [
        LanguageOption(code: "en", name: "English"),
        LanguageOption(code: "de-AT", name: "Deutsch"),
    ]

    @Test("renders globe icon, native names and lang attributes")
    func rendersOptions() {
        let html = renderHTML(
            LanguageSwitcher(LanguageSwitcherData(languages: languages))
                .render()
        )
        #expect(html.contains("src=\"/js/languageswitcher.js\""))
        #expect(html.contains("src=\"/js/dropdown.js\""))
        #expect(html.contains("languageSwitcher({ fallback: 'en'"))
        #expect(html.contains("@dropdown-change"))
        #expect(html.contains("Deutsch"))
        #expect(html.contains("lang=\"de\""))
        #expect(!html.contains("de-AT"))
        #expect(html.contains("bi-globe") || html.contains("<svg"))
    }

    @Test("language code is reduced to the primary subtag")
    func primarySubtag() {
        #expect(LanguageOption(code: "en-GB", name: "English").code == "en")
        #expect(LanguageOption(code: "DE_at", name: "Deutsch").code == "de")
    }

    @Test("fallback is en if available, otherwise first language")
    func fallback() {
        let de = [LanguageOption(code: "de", name: "Deutsch")]
        #expect(LanguageSwitcherData(languages: de).initialCode == "de")
        #expect(LanguageSwitcherData(languages: languages).initialCode == "en")
    }

    @Test("dropdown renders optional icon only when set")
    func dropdownIcon() {
        let options = [OptionValue(title: "A", value: "a")]
        let without = renderHTML(
            Dropdown(DropdownData(id: "d", options: options)).render()
        )
        let with = renderHTML(
            Dropdown(DropdownData(id: "d", options: options, icon: .globe))
                .render()
        )
        #expect(!without.contains("gap-2"))
        #expect(with.contains("gap-2"))
    }
}
