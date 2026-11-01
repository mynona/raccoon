import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("References")
struct ReferencesTests {

    @Test("renders provided heading")
    func rendersHeading() async throws {

        let html = renderHTML(
            References(
                ReferencesData(
                    title: "References",
                    contentAsMarkdown: "1. Source one."
                )
            )
            .render()
        )
        #expect(html.contains("References"))
    }

    @Test("falls back to default heading when title is empty")
    func fallsBackToDefaultHeadingWhenTitleEmpty() async throws {

        let html = renderHTML(
            References(
                ReferencesData(
                    title: "",
                    contentAsMarkdown: "1. Source one."
                )
            )
            .render()
        )
        #expect(html.contains("References and further reading"))
    }

    @Test("renders markdown content")
    func rendersMarkdownContent() async throws {

        let html = renderHTML(
            References(
                ReferencesData(
                    title: "References",
                    contentAsMarkdown:
                        "1. Norman, D. *The Design of Everyday Things*."
                )
            )
            .render()
        )
        #expect(html.contains("Norman, D."))
    }

    @Test("renders container div")
    func rendersContainer() async throws {

        let html = renderHTML(
            References(
                ReferencesData(title: "Refs", contentAsMarkdown: "1. A.")
            )
            .render()
        )
        #expect(html.contains("<div"))
    }

    // MARK: localization

    @Test(
        "a blank title shows the built-in translated heading; a given title stays"
    )
    func localizedHeading() {
        let blank = ReferencesData(title: "  ", contentAsMarkdown: "1. A.")
        let german = I18n.render(language: "de") {
            renderHTML(References(blank).render())
        }
        #expect(german.contains("Quellen und weiterführende Literatur"))
        #expect(german.contains("data-i18n=\"references.title\""))

        let own = ReferencesData(
            title: LocalizedText(
                en: "Sources",
                translations: ["de": "Quellen"]
            ),
            contentAsMarkdown: "1. A."
        )
        let custom = I18n.render(language: "de") {
            renderHTML(References(own).render())
        }
        #expect(custom.contains(">Quellen</p>"))

        let plain = renderHTML(
            References(
                ReferencesData(title: "Refs", contentAsMarkdown: "1. A.")
            )
            .render()
        )
        #expect(!plain.contains("data-i18n"))
    }
}
