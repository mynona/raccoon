import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct PaginationView: TemplateRepresentable {

    let variants: [(String, PaginationData)] = [
        (
            """
            // Middle page (Page 4 of 10 selected: First | 2 | 3 | 4 | 5 | 6 | Last)
            """,
            PaginationData(
                tableOfContent: PaginationItem(
                    title: "Table of content",
                    order: 0,
                    friendly_url: "table-of-content-link"
                ),
                pages: (1...10)
                    .map { i in
                        PaginationItem(
                            title: "Chapter \(i)",
                            order: i,
                            friendly_url: "chapter-\(i)",
                            selected: i == 4
                        )
                    },
                hrefBase: "base-url"
            )
        ),
        (
            """
            // First page (Page 1 of 10 selected: no pages before, First button omitted)
            """,
            PaginationData(
                tableOfContent: PaginationItem(
                    title: "Table of content",
                    order: 0,
                    friendly_url: "table-of-content-link"
                ),
                pages: (1...10)
                    .map { i in
                        PaginationItem(
                            title: "Chapter \(i)",
                            order: i,
                            friendly_url: "chapter-\(i)",
                            selected: i == 1
                        )
                    },
                hrefBase: "base-url"
            )
        ),
        (
            """
            // Near start (Page 2 of 10 selected: only 1 page before)
            """,
            PaginationData(
                tableOfContent: nil,
                pages: (1...10)
                    .map { i in
                        PaginationItem(
                            title: "Chapter \(i)",
                            order: i,
                            friendly_url: "chapter-\(i)",
                            selected: i == 2
                        )
                    },
                hrefBase: "base-url"
            )
        ),
        (
            """
            // Last page (Page 10 of 10 selected: no pages after, Last button omitted)
            """,
            PaginationData(
                tableOfContent: nil,
                pages: (1...10)
                    .map { i in
                        PaginationItem(
                            title: "Chapter \(i)",
                            order: i,
                            friendly_url: "chapter-\(i)",
                            selected: i == 10
                        )
                    },
                hrefBase: "base-url"
            )
        ),
        (
            """
            // 2 pages (Page 1 selected: First omitted, Last shown)
            """,
            PaginationData(
                tableOfContent: nil,
                pages: [
                    PaginationItem(
                        title: "First",
                        order: 1,
                        friendly_url: "first",
                        selected: true
                    ),
                    PaginationItem(
                        title: "Second",
                        order: 2,
                        friendly_url: "second",
                        selected: false
                    ),
                ],
                hrefBase: "base-url"
            )
        ),
        (
            """
            // 100 pages (Page 42 selected: First | 40 | 41 | 42 | 43 | 44 | Last)
            """,
            PaginationData(
                tableOfContent: PaginationItem(
                    title: "Overview",
                    order: 0,
                    friendly_url: "overview"
                ),
                pages: (1...100)
                    .map { i in
                        PaginationItem(
                            title: "Chapter \(i)",
                            order: i,
                            friendly_url: "chapter-\(i)",
                            selected: i == 42
                        )
                    },
                hrefBase: "base-url"
            )
        ),
        (
            """
            // Long Table of content title (> 15 characters, truncated)
            """,
            PaginationData(
                tableOfContent: PaginationItem(
                    title: "Comprehensive Table of Contents for Deep Dive",
                    order: 0,
                    friendly_url: "table-of-content-link"
                ),
                pages: (1...10)
                    .map { i in
                        PaginationItem(
                            title: "Chapter \(i)",
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

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { Pagination(ctx).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
