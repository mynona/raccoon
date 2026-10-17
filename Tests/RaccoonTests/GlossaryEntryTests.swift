import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("GlossaryEntry")
struct GlossaryEntryTests {

    @Test("renders the term in glossary format")
    func rendersTerm() async throws {

        let html = renderHTML(
            GlossaryEntry(
                GlossaryEntryData(
                    term: "Product Thinking",
                    definition: "Solving the right problems."
                )
            )
            .render()
        )
        #expect(html.contains("Product Thinking"))
    }

    @Test("renders the definition markdown content")
    func rendersDefinition() async throws {

        let html = renderHTML(
            GlossaryEntry(
                GlossaryEntryData(
                    term: "Test Term",
                    definition: "This is a **bold** definition."
                )
            )
            .render()
        )
        #expect(html.contains("bold"))
        #expect(html.contains("definition"))
    }

    @Test("renders with different icons")
    func rendersWithDifferentIcons() async throws {

        let icons: [SvgIcon] = [
            .book, .question_circle, .lightbulb, .info_circle,
        ]
        for icon in icons {
            let html = renderHTML(
                GlossaryEntry(
                    GlossaryEntryData(
                        term: "Term",
                        definition: "Definition",
                        icon: icon
                    )
                )
                .render()
            )
            #expect(html.contains("svg"))
        }

        // Test with icon: nil does not render leading icon
        let htmlNoIcon = renderHTML(
            GlossaryEntry(
                GlossaryEntryData(
                    term: "No Icon Term",
                    definition: "Definition",
                    icon: nil
                )
            )
            .render()
        )
        #expect(htmlNoIcon.contains("No Icon Term"))
    }

    @Test("respects matomo tracking status")
    func respectsMatomoStatus() async throws {

        let htmlAccepted = renderHTML(
            GlossaryEntry(
                GlossaryEntryData(
                    term: "Tracked Term",
                    definition: "Tracked definition",
                    matomoStatus: .ACCEPTED
                )
            )
            .render()
        )
        #expect(htmlAccepted.contains("data-track-content"))

        let htmlDeclined = renderHTML(
            GlossaryEntry(
                GlossaryEntryData(
                    term: "Untracked Term",
                    definition: "Untracked definition",
                    matomoStatus: .DECLINED
                )
            )
            .render()
        )
        #expect(!htmlDeclined.contains("data-track-content"))
    }

    @Test("deliberately renders label in mono font")
    func rendersLabelInMonoFont() async throws {

        let html = renderHTML(
            GlossaryEntry(
                GlossaryEntryData(
                    term: "Mono Term",
                    definition: "Definition"
                )
            )
            .render()
        )
        #expect(html.contains("font-mono"))
    }

    @Test("renders section element with correct classes")
    func rendersSectionWithClasses() async throws {

        let html = renderHTML(
            GlossaryEntry(
                GlossaryEntryData(
                    term: "Glossary Entry",
                    definition: "Entry definition"
                )
            )
            .render()
        )
        #expect(html.contains("<div"))
        #expect(html.contains("px-4"))
        #expect(html.contains("mb-10"))
        #expect(html.contains("mt-10"))
    }

    @Test("renders with glossary container styles")
    func rendersWithContainerStyles() async throws {

        let html = renderHTML(
            GlossaryEntry(
                GlossaryEntryData(
                    term: "Style Test",
                    definition: "Testing styles"
                )
            )
            .render()
        )
        #expect(html.contains("print:bg-white"))
        #expect(html.contains("bg-black/5"))
        #expect(html.contains("dark:bg-white/5"))
    }

    @Test("renders comment for accessibility")
    func rendersComment() async throws {

        let html = renderHTML(
            GlossaryEntry(
                GlossaryEntryData(
                    term: "Test",
                    definition: "Definition"
                )
            )
            .render()
        )
        #expect(html.contains("<!--"))
        #expect(html.contains("Glossary Entry"))
    }

    @Test("renders with empty definition")
    func rendersWithEmptyDefinition() async throws {

        let html = renderHTML(
            GlossaryEntry(
                GlossaryEntryData(
                    term: "Empty",
                    definition: ""
                )
            )
            .render()
        )
        #expect(html.contains("Empty"))
    }

    @Test("renders with special characters in term")
    func rendersWithSpecialCharactersTerm() async throws {

        let html = renderHTML(
            GlossaryEntry(
                GlossaryEntryData(
                    term: "API & REST",
                    definition: "Application Programming Interface."
                )
            )
            .render()
        )
        #expect(html.contains("API"))
        #expect(html.contains("REST"))
    }

    @Test("renders with long term and definition")
    func rendersWithLongContent() async throws {

        let longTerm =
            "Very Long Glossary Term That Might Span Multiple Concepts"
        let longDefinition =
            "This is a comprehensive definition that explains the concept in detail. It may span multiple lines and contain various formatting elements to ensure the glossary renders correctly."

        let html = renderHTML(
            GlossaryEntry(
                GlossaryEntryData(
                    term: longTerm,
                    definition: longDefinition
                )
            )
            .render()
        )
        #expect(html.contains(longTerm))
        #expect(html.contains("comprehensive"))
    }

    @Test("renders initial keyboard key when hasInitial is true")
    func rendersInitialKeyboardKey() async throws {

        let html = renderHTML(
            GlossaryEntry(
                GlossaryEntryData(
                    term: "Swift",
                    definition: "Language",
                    hasInitial: true
                )
            )
            .render()
        )
        #expect(html.contains("<kbd"))
        #expect(html.contains(">S<"))
    }

    @Test("renders with markdown formatting in definition")
    func rendersWithMarkdownFormatting() async throws {

        let html = renderHTML(
            GlossaryEntry(
                GlossaryEntryData(
                    term: "Markdown Test",
                    definition:
                        "This has **bold**, *italic*, and `code` formatting."
                )
            )
            .render()
        )
        #expect(html.contains("bold"))
        #expect(html.contains("italic"))
        #expect(html.contains("code"))
    }

    @Test("renders multiple glossary entries")
    func rendersMultipleEntries() async throws {

        let entry1 = GlossaryEntry(
            GlossaryEntryData(
                term: "First Term",
                definition: "First definition"
            )
        )
        .render()

        let entry2 = GlossaryEntry(
            GlossaryEntryData(
                term: "Second Term",
                definition: "Second definition"
            )
        )
        .render()

        let html = renderHTML(entry1 + entry2)
        #expect(html.contains("First Term"))
        #expect(html.contains("Second Term"))
        #expect(html.contains("First definition"))
        #expect(html.contains("Second definition"))
    }

    @Test("renders default icon when not specified")
    func rendersDefaultIcon() async throws {

        let html = renderHTML(
            GlossaryEntry(
                GlossaryEntryData(
                    term: "Test",
                    definition: "Definition"
                )
            )
            .render()
        )
        // Default icon should be question_circle, should still render svg
        #expect(html.contains("svg"))
    }

    @Test("renders with unicode characters")
    func rendersWithUnicodeCharacters() async throws {

        let html = renderHTML(
            GlossaryEntry(
                GlossaryEntryData(
                    term: "Café ☕",
                    definition: "Definition with emoji 🚀 and special chars."
                )
            )
            .render()
        )
        #expect(html.contains("Café"))
        #expect(html.contains("☕"))
        #expect(html.contains("🚀"))
    }
}
