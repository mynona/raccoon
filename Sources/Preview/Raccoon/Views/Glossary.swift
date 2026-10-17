import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct GlossaryView: TemplateRepresentable {

    let variants: [(String, GlossaryData)] = [
        (
            """
            // Default (with in-page search)
            """,
            GlossaryData(
                entries: [
                    GlossaryEntryData(
                        term: "Alpinum",
                        definition:
                            "Anlage mit Alpenpflanzen"
                    ),
                    GlossaryEntryData(
                        term: "API",
                        definition:
                            "Application Programming Interface – eine Schnittstelle zur Kommunikation zwischen Softwaresystemen."
                    ),
                    GlossaryEntryData(
                        term: "Accordion",
                        definition:
                            "Ein UI-Element, mit dem Inhalte ein- und ausgeklappt werden können."
                    ),
                    GlossaryEntryData(
                        term: "beinhalten",
                        definition:
                            "Das Wort *beinhalten* sollte nicht zwischen *n* und *h* getrennt werden."
                    ),
                    GlossaryEntryData(
                        term: "Build-Tool",
                        definition:
                            "Software zur Automatisierung der Erstellung von ausführbaren Programmen aus Quellcode."
                    ),
                    GlossaryEntryData(
                        term: "Heliskiing",
                        definition:
                            "Abfahrt von einem Berggipfel, zu dem der Skiläufer mit einem Helikopter gebracht worden ist."
                    ),
                    GlossaryEntryData(
                        term: "Hotfix",
                        definition:
                            "Eine dringende Fehlerbehebung, die direkt in die Produktionsumgebung eingespielt wird."
                    ),
                    GlossaryEntryData(
                        term: "Logout",
                        definition:
                            "Das Ausloggen"
                    ),
                    GlossaryEntryData(
                        term: "Lazy Loading",
                        definition:
                            "Ein Entwurfsmuster, bei dem Ressourcen erst dann geladen werden, wenn sie tatsächlich benötigt werden."
                    ),
                    GlossaryEntryData(
                        term: "Tribute-Band",
                        definition:
                            "Musikband, die eine berühmte Band nachahmt."
                    ),
                ],
                hasSearch: true
            ),
        ),
        (
            """
            // Without Search
            """,
            GlossaryData(
                entries: [
                    GlossaryEntryData(
                        term: "Alpinum",
                        definition:
                            "Anlage mit Alpenpflanzen"
                    ),
                    GlossaryEntryData(
                        term: "API",
                        definition:
                            "Application Programming Interface – Schnittstelle."
                    ),
                    GlossaryEntryData(
                        term: "Heliskiing",
                        definition:
                            "Abfahrt von einem Berggipfel, zu dem der Skiläufer mit einem Helikopter gebracht worden ist."
                    ),
                    GlossaryEntryData(
                        term: "Logout",
                        definition:
                            "Das Ausloggen"
                    ),
                ],
                hasSearch: false
            ),
        ),
    ]

    func makeHtml(ctx: GlossaryData) -> String {
        let html = renderFragments(Glossary(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Glossary")

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { Glossary(ctx).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
