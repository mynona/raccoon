import HTML
import Raccoon
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("Glossary")
struct GlossaryTests {

    @Test("renders dl container with dt and dd for each entry")
    func rendersDlContainerWithDtAndDd() async throws {

        let entries = [
            GlossaryEntryData(term: "Beta", definition: "Second version"),
            GlossaryEntryData(term: "Alpha", definition: "First version"),
        ]
        let glossaryData = GlossaryData(entries: entries, hasSearch: false)

        let html = renderHTML(Glossary(glossaryData).render())

        #expect(html.contains("<dl>"))
        #expect(html.contains("<dt class=\"sr-only\">Alpha</dt>"))
        #expect(html.contains("<dt class=\"sr-only\">Beta</dt>"))
        #expect(html.contains("<dd>"))
        #expect(!html.contains("name=\"glossarySearchInput\""))
    }

    @Test(
        "renders search input, clear button, and alpine filter when hasSearch is true"
    )
    func rendersSearchInputWhenHasSearchIsTrue() async throws {

        let entries = [
            GlossaryEntryData(term: "Beta", definition: "Second version"),
            GlossaryEntryData(term: "Alpha", definition: "First version"),
        ]
        let glossaryData = GlossaryData(
            id: "my-glossary",
            searchPlaceholder: "Filter terms",
            searchAriaLabel: "Filter glossary terms",
            noResultsText: "Nothing found",
            entries: entries,
            hasSearch: true
        )

        let html = renderHTML(Glossary(glossaryData).render())

        #expect(html.contains("id=\"my-glossary\""))
        #expect(
            html.contains(
                "x-data=\"{ search: '', terms: ['alpha', 'beta'] }\""
            )
        )
        #expect(html.contains("name=\"glossarySearchInput\""))
        #expect(html.contains("placeholder=\"Filter terms\""))
        #expect(html.contains("aria-label=\"Filter glossary terms\""))
        #expect(html.contains("x-model=\"search\""))
        #expect(html.contains("x-ref=\"searchInput\""))
        #expect(html.contains("aria-label=\"Clear search\""))
        #expect(html.contains("x-show=\"search.length > 0\""))
        #expect(
            html.contains(
                "x-show=\"!search.trim() || 'alpha'.includes(search.trim().toLowerCase())\""
            )
        )
        #expect(
            html.contains(
                "x-show=\"!search.trim() || 'beta'.includes(search.trim().toLowerCase())\""
            )
        )
        #expect(html.contains("Nothing found"))
    }

    @Test("omits search bar and alpine attributes when hasSearch is false")
    func omitsSearchWhenHasSearchIsFalse() async throws {

        let entries = [
            GlossaryEntryData(term: "Beta", definition: "Second version")
        ]
        let glossaryData = GlossaryData(entries: entries, hasSearch: false)

        let html = renderHTML(Glossary(glossaryData).render())

        #expect(!html.contains("name=\"glossarySearchInput\""))
        #expect(!html.contains("x-data="))
        #expect(!html.contains("x-model="))
    }

    @Test("sorts entries alphabetically regardless of initial order")
    func sortsEntriesAlphabetically() async throws {

        let entries = [
            GlossaryEntryData(term: "Zeta", definition: "Last"),
            GlossaryEntryData(term: "Apple", definition: "First"),
            GlossaryEntryData(term: "Mango", definition: "Middle"),
        ]
        let glossaryData = GlossaryData(entries: entries)

        let sorted = glossaryData.entriesSortedAlphabetically
        #expect(sorted.map(\.term) == ["Apple", "Mango", "Zeta"])

        let html = renderHTML(Glossary(glossaryData).render())
        let appleRange = html.range(of: "Apple")?.lowerBound
        let mangoRange = html.range(of: "Mango")?.lowerBound
        let zetaRange = html.range(of: "Zeta")?.lowerBound

        #expect(appleRange != nil && mangoRange != nil && zetaRange != nil)
        if let a = appleRange, let m = mangoRange, let z = zetaRange {
            #expect(a < m)
            #expect(m < z)
        }
    }

    @Test(
        "renders h2 section titles for alphabetical register without accordion keyboard keys"
    )
    func rendersAlphabeticalRegisterH2WithoutAccordionKeys() async throws {

        let entries = [
            GlossaryEntryData(term: "Apple", definition: "Fruit"),
            GlossaryEntryData(term: "Avocado", definition: "Berry"),
            GlossaryEntryData(term: "Banana", definition: "Yellow fruit"),
        ]
        let glossaryData = GlossaryData(entries: entries)

        let html = renderHTML(Glossary(glossaryData).render())

        // Check H2 section headers exist for A and B
        #expect(
            html.contains("<h2 class=\"\(GlossaryStyles.sectionTitle)\">A</h2>")
        )
        #expect(
            html.contains("<h2 class=\"\(GlossaryStyles.sectionTitle)\">B</h2>")
        )

        // Check that redundant keyboard shortcut kbd icon is omitted from accordions
        #expect(!html.contains("<kbd"))
    }
}
