import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct PaginationView: TemplateRepresentable {

    let variants: [PreviewVariant<PaginationData>] = [
        #previewVariant(
            """
            // Middle page (Page 4 of 10 selected: First | 2 | 3 | 4 | 5 | 6 | Last)
            """,
            PaginationData(
                tableOfContent: PaginationItem(
                    title: tr(
                        "Table of content",
                        de: "Inhaltsverzeichnis",
                        fr: "Table des matières",
                        es: "Tabla de contenido",
                        it: "Indice"
                    ),
                    order: 0,
                    friendly_url: "table-of-content-link"
                ),
                pages: (1...10)
                    .map { i in
                        PaginationItem(
                            title: tr(
                                "Chapter \(i)",
                                de: "Kapitel \(i)",
                                fr: "Chapitre \(i)",
                                es: "Capítulo \(i)",
                                it: "Capitolo \(i)"
                            ),
                            order: i,
                            friendly_url: "chapter-\(i)",
                            selected: i == 4
                        )
                    },
                hrefBase: "base-url"
            )
        ),
        #previewVariant(
            """
            // First page (Page 1 of 10 selected: no pages before, First button omitted)
            """,
            PaginationData(
                tableOfContent: PaginationItem(
                    title: tr(
                        "Table of content",
                        de: "Inhaltsverzeichnis",
                        fr: "Table des matières",
                        es: "Tabla de contenido",
                        it: "Indice"
                    ),
                    order: 0,
                    friendly_url: "table-of-content-link"
                ),
                pages: (1...10)
                    .map { i in
                        PaginationItem(
                            title: tr(
                                "Chapter \(i)",
                                de: "Kapitel \(i)",
                                fr: "Chapitre \(i)",
                                es: "Capítulo \(i)",
                                it: "Capitolo \(i)"
                            ),
                            order: i,
                            friendly_url: "chapter-\(i)",
                            selected: i == 1
                        )
                    },
                hrefBase: "base-url"
            )
        ),
        #previewVariant(
            """
            // Near start (Page 2 of 10 selected: only 1 page before)
            """,
            PaginationData(
                tableOfContent: nil,
                pages: (1...10)
                    .map { i in
                        PaginationItem(
                            title: tr(
                                "Chapter \(i)",
                                de: "Kapitel \(i)",
                                fr: "Chapitre \(i)",
                                es: "Capítulo \(i)",
                                it: "Capitolo \(i)"
                            ),
                            order: i,
                            friendly_url: "chapter-\(i)",
                            selected: i == 2
                        )
                    },
                hrefBase: "base-url"
            )
        ),
        #previewVariant(
            """
            // Last page (Page 10 of 10 selected: no pages after, Last button omitted)
            """,
            PaginationData(
                tableOfContent: nil,
                pages: (1...10)
                    .map { i in
                        PaginationItem(
                            title: tr(
                                "Chapter \(i)",
                                de: "Kapitel \(i)",
                                fr: "Chapitre \(i)",
                                es: "Capítulo \(i)",
                                it: "Capitolo \(i)"
                            ),
                            order: i,
                            friendly_url: "chapter-\(i)",
                            selected: i == 10
                        )
                    },
                hrefBase: "base-url"
            )
        ),
        #previewVariant(
            """
            // 2 pages (Page 1 selected: First omitted, Last shown)
            """,
            PaginationData(
                tableOfContent: nil,
                pages: [
                    PaginationItem(
                        title: tr(
                            "First",
                            de: "Erstes",
                            fr: "Premier",
                            es: "Primero",
                            it: "Primo"
                        ),
                        order: 1,
                        friendly_url: "first",
                        selected: true
                    ),
                    PaginationItem(
                        title: tr(
                            "Second",
                            de: "Zweites",
                            fr: "Deuxième",
                            es: "Segundo",
                            it: "Secondo"
                        ),
                        order: 2,
                        friendly_url: "second",
                        selected: false
                    ),
                ],
                hrefBase: "base-url"
            )
        ),
        #previewVariant(
            """
            // 100 pages (Page 42 selected: First | 40 | 41 | 42 | 43 | 44 | Last)
            """,
            PaginationData(
                tableOfContent: PaginationItem(
                    title: tr(
                        "Overview",
                        de: "Übersicht",
                        fr: "Aperçu",
                        es: "Resumen",
                        it: "Panoramica"
                    ),
                    order: 0,
                    friendly_url: "overview"
                ),
                pages: (1...100)
                    .map { i in
                        PaginationItem(
                            title: tr(
                                "Chapter \(i)",
                                de: "Kapitel \(i)",
                                fr: "Chapitre \(i)",
                                es: "Capítulo \(i)",
                                it: "Capitolo \(i)"
                            ),
                            order: i,
                            friendly_url: "chapter-\(i)",
                            selected: i == 42
                        )
                    },
                hrefBase: "base-url"
            )
        ),
        #previewVariant(
            """
            // Long Table of content title (> 15 characters, truncated)
            """,
            PaginationData(
                tableOfContent: PaginationItem(
                    title: tr(
                        "Comprehensive Table of Contents for Deep Dive",
                        de:
                            "Ausführliches Inhaltsverzeichnis für die Vertiefung",
                        fr:
                            "Table des matières détaillée pour l'approfondissement",
                        es: "Tabla de contenido completa para profundizar",
                        it: "Indice completo per l'approfondimento"
                    ),
                    order: 0,
                    friendly_url: "table-of-content-link"
                ),
                pages: (1...10)
                    .map { i in
                        PaginationItem(
                            title: tr(
                                "Chapter \(i)",
                                de: "Kapitel \(i)",
                                fr: "Chapitre \(i)",
                                es: "Capítulo \(i)",
                                it: "Capitolo \(i)"
                            ),
                            order: i,
                            friendly_url: "chapter-\(i)",
                            selected: i == 4
                        )
                    },
                hrefBase: "base-url"
            )
        ),
    ]

    func makeHtml(ctx: PaginationData) -> String {
        let html = renderFragments(Pagination(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Pagination")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { Pagination(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
