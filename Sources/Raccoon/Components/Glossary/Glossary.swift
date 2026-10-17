import HTML
import SGML
import SVG
import WebBuilders

public struct Glossary: TemplateRepresentable {
    let data: GlossaryData
    typealias styles = GlossaryStyles

    public init(
        _ data: GlossaryData
    ) {
        self.data = data
    }

    @Builder<Element>
    private func showSearchField() -> [Element] {
        Div {
            SearchField(
                SearchFieldData(
                    name: "glossarySearchInput",
                    bindModel: "search",
                    bindRef: "searchInput",
                    placeholder: data.searchPlaceholder,
                    ariaLabel: data.searchAriaLabel
                )
            )
            .render()
        }
        .class("mb-8")
    }

    @Builder<Element>
    private func showNoResultsNotice() -> [Element] {
        Div {
            P(data.noResultsText)
                .addClass(styles.textColorNoResults)
        }
        .setAttribute(
            name: "x-show",
            value:
                "search.trim().length > 0 && !terms.some(t => t.includes(search.trim().toLowerCase()))"
        )
        .flagAttribute("x-cloak")
        .addClass(styles.noResultsContainer)
    }

    private struct AlphabetSection {
        let letter: String
        let entries: [GlossaryEntryData]
    }

    private var groupedSections: [AlphabetSection] {
        var sections: [AlphabetSection] = []
        for entry in data.entriesSortedAlphabetically {
            let letter =
                entry.term.first { !$0.isWhitespace }
                .map { String($0).uppercased() } ?? "#"
            if let lastIndex = sections.indices.last,
                sections[lastIndex].letter == letter
            {
                sections[lastIndex] = AlphabetSection(
                    letter: letter,
                    entries: sections[lastIndex].entries + [entry]
                )
            }
            else {
                sections.append(
                    AlphabetSection(letter: letter, entries: [entry])
                )
            }
        }
        return sections
    }

    @Builder<Element>
    private func renderSectionHeader(_ section: AlphabetSection) -> [Element] {
        Div {
            H2(section.letter)
                .addClass(styles.sectionTitle)
        }
        .class(styles.sectionHeaderContainer)
    }

    @Builder<Element>
    private func renderEntries() -> [Element] {
        Div {
            for section in groupedSections {
                let sectionTermsLiteral =
                    "["
                    + section.entries
                    .map {
                        JavaScriptEscaper.alpineStringLiteral(
                            $0.term.lowercased()
                        )
                    }
                    .joined(separator: ", ") + "]"

                let sectionElement = Div {
                    renderSectionHeader(section)
                    Dl {
                        for entry in section.entries {
                            let termLiteral =
                                JavaScriptEscaper.alpineStringLiteral(
                                    entry.term.lowercased()
                                )

                            if data.hasSearch {
                                Div {
                                    Dt(entry.term)
                                        .class("sr-only")
                                    Dd {
                                        GlossaryEntry(
                                            GlossaryEntryData(
                                                id: entry.id,
                                                term: entry.term,
                                                definition: entry.definition,
                                                icon: nil,  // forced override
                                                hasInitial: false,  // no icon/key in accordion since H2 letter is introduced
                                                matomoStatus: entry.matomoStatus
                                            )
                                        )
                                        .render()
                                    }
                                }
                                .setAttribute(
                                    name: "x-show",
                                    value:
                                        "!search.trim() || \(termLiteral).includes(search.trim().toLowerCase())"
                                )
                            }
                            else {
                                Dt(entry.term)
                                    .class("sr-only")
                                Dd {
                                    GlossaryEntry(
                                        GlossaryEntryData(
                                            id: entry.id,
                                            term: entry.term,
                                            definition: entry.definition,
                                            icon: nil,  // forced override
                                            hasInitial: false,  // no icon/key in accordion since H2 letter is introduced
                                            matomoStatus: entry.matomoStatus
                                        )
                                    )
                                    .render()
                                }
                            }
                        }
                    }
                }

                if data.hasSearch {
                    sectionElement
                        .setAttribute(
                            name: "x-show",
                            value:
                                "!search.trim() || \(sectionTermsLiteral).some(t => t.includes(search.trim().toLowerCase()))"
                        )
                }
                else {
                    sectionElement
                }
            }
        }
    }

    @Builder<Element>
    public func render() -> [Element] {
        DebugComment("Glossary")

        let termsArrayLiteral =
            "["
            + data.entriesSortedAlphabetically
            .map { JavaScriptEscaper.alpineStringLiteral($0.term.lowercased()) }
            .joined(separator: ", ") + "]"

        let xDataExpression = "{ search: '', terms: \(termsArrayLiteral) }"

        Section {
            if data.hasSearch {
                showSearchField()
                renderEntries()
                showNoResultsNotice()
            }
            else {
                renderEntries()
            }
        }
        .ariaLabel("Glossary")
        .if(data.id != nil) {
            $0.id(data.id!)
        }
        .if(data.hasSearch) {
            $0.setAttribute(name: "x-data", value: xDataExpression)
        }
    }
}
