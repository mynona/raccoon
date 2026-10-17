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
}
