import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("Definition")
struct DefinitionTests {

    @Test("renders the term")
    func rendersTerm() async throws {

        let html = renderHTML(
            Definition(
                DefinitionData(
                    term: "Idempotent",
                    definition:
                        "An operation that can be applied multiple times without changing the result."
                )
            )
            .render()
        )
        #expect(html.contains("Idempotent"))
    }

    @Test("renders the definition text")
    func rendersDefinition() async throws {

        let html = renderHTML(
            Definition(
                DefinitionData(
                    term: "REST",
                    definition: "Representational State Transfer."
                )
            )
            .render()
        )
        #expect(html.contains("Representational State Transfer."))
    }

    @Test("renders a container div")
    func rendersContainer() async throws {

        let html = renderHTML(
            Definition(
                DefinitionData(
                    term: "API",
                    definition: "Application Programming Interface."
                )
            )
            .render()
        )
        #expect(html.contains("<div"))
    }

    @Test("renders custom icon and markdown in definition")
    func rendersCustomIconAndMarkdown() async throws {

        let html = renderHTML(
            Definition(
                DefinitionData(
                    term: "GraphQL",
                    definition:
                        "A **query language** for APIs with [docs](https://graphql.org).",
                    icon: .info
                )
            )
            .render()
        )
        #expect(html.contains("<section"))
        #expect(html.contains("<dl"))
        #expect(html.contains("<dt"))
        #expect(html.contains("<dd"))
        #expect(html.contains("<strong>query language</strong>"))
        #expect(html.contains("href=\"https://graphql.org\""))
        #expect(html.contains("GraphQL"))
    }
}
