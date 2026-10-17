import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct TablePaginatorView: TemplateRepresentable {

    let variants: [(String, TablePaginatorData)] = [
        (
            """
            // Alpine.js Client-Side Mode (Interactive with dynamic state)
            """,
            TablePaginatorData(
                bindShow: "true",
                mode: .alpine
            )
        ),
        (
            """
            // Alpine.js Client-Side Mode (Simulated loading state)
            """,
            TablePaginatorData(
                bindIsLoading: "true",
                bindShow: "true",
                mode: .alpine
            )
        ),
        (
            """
            // SSR Link Mode: First Page (Previous & First disabled)
            """,
            TablePaginatorData(
                mode: .link(basePath: "/preview/table-paginator"),
                info: TablePaginatorInfo(page: 1, per: 10, total: 95),
                pageSizeOptions: [5, 10, 20, 50, 100]
            )
        ),
        (
            """
            // SSR Link Mode: Middle Page (All navigation buttons active)
            """,
            TablePaginatorData(
                mode: .link(
                    basePath: "/preview/table-paginator",
                    queryParams: ["filter": "active"]
                ),
                info: TablePaginatorInfo(page: 5, per: 10, total: 95),
                pageSizeOptions: [5, 10, 20, 50, 100]
            )
        ),
        (
            """
            // SSR Link Mode: Last Page (Next & Last disabled)
            """,
            TablePaginatorData(
                mode: .link(basePath: "/preview/table-paginator"),
                info: TablePaginatorInfo(page: 10, per: 10, total: 95),
                pageSizeOptions: [5, 10, 20, 50, 100]
            )
        ),
    ]

    func makeHtml(ctx: TablePaginatorData) -> String {
        let html = renderFragments(TablePaginator(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {
        Basic(title: "Table Paginator") {
            Div {
                showComponentTitle("Table Paginator")

                for (label, ctx) in variants {
                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div {
                            TablePaginator(ctx).render()
                        }
                        .setAttribute(
                            name: "x-data",
                            value: """
                                {
                                    page: 2,
                                    per: 10,
                                    total: 95,
                                    totalPages: 10,
                                    rangeLabel: '11 – 20 of 95',
                                    pageSizeOptions: [5, 10, 20, 50, 100],
                                    hasPrevious: true,
                                    hasNext: true,
                                    isLoading: false,
                                    hasSearched: true,
                                    changePageSize(val) { this.per = Number(val); },
                                    goToPage(p) { this.page = p; },
                                    previousPage() { if (this.page > 1) this.page--; },
                                    nextPage() { if (this.page < this.totalPages) this.page++; }
                                }
                                """
                        )
                        .class("mb-4 mt-6 max-w-4xl")
                    }
                }
            }
            .class("mt-4 space-y-6")
        }
        .render()
    }
}
