import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("Pagination")
struct PaginationTests {

    let pages = [
        PaginationItem(
            title: "First Page",
            order: 1,
            friendly_url: "page-1",
            selected: false
        ),
        PaginationItem(
            title: "Second Page",
            order: 2,
            friendly_url: "page-2",
            selected: true
        ),
        PaginationItem(
            title: "Third Page",
            order: 3,
            friendly_url: "page-3",
            selected: false
        ),
    ]

    @Test("does not render when pages count is 1 or 0")
    func doesNotRenderSinglePage() async throws {

        let singlePageData = PaginationData(
            pages: [
                PaginationItem(
                    title: "Only",
                    order: 1,
                    friendly_url: "only",
                    selected: true
                )
            ],
            hrefBase: "/stories"
        )
        let htmlSingle = renderHTML(Pagination(singlePageData).render())
        #expect(!htmlSingle.contains("<nav"))

        let emptyData = PaginationData(pages: [], hrefBase: "/stories")
        let htmlEmpty = renderHTML(Pagination(emptyData).render())
        #expect(!htmlEmpty.contains("<nav"))
    }

    @Test("renders first, current, and last page items")
    func rendersNavigationLinks() async throws {

        let data = PaginationData(
            tableOfContent: PaginationItem(
                title: "Overview",
                order: 0,
                friendly_url: "toc",
                selected: false
            ),
            pages: pages,
            hrefBase: "/stories"
        )
        let html = renderHTML(Pagination(data).render())

        #expect(html.contains("<nav"))
        #expect(html.contains("aria-label=\"Pagination\""))
        #expect(html.contains("Overview"))
        #expect(html.contains("First page: First Page"))
        #expect(html.contains("Last page: Third Page"))
        #expect(html.contains("href=\"/stories/page-1\""))
        #expect(html.contains("href=\"/stories/page-3\""))
        #expect(html.contains("aria-current=\"page\""))
        #expect(html.contains("<span>2</span>"))
    }

    @Test("omits first button on first page")
    func omitsFirstButtonOnFirstPage() async throws {

        let firstPageActive = [
            PaginationItem(
                title: "First Page",
                order: 1,
                friendly_url: "page-1",
                selected: true
            ),
            PaginationItem(
                title: "Second Page",
                order: 2,
                friendly_url: "page-2",
                selected: false
            ),
        ]
        let data = PaginationData(pages: firstPageActive, hrefBase: "/stories")
        let html = renderHTML(Pagination(data).render())

        #expect(!html.contains("First page"))
        #expect(html.contains("Last page: Second Page"))
        #expect(html.contains("href=\"/stories/page-2\""))
    }

    @Test("omits last button on last page")
    func omitsLastButtonOnLastPage() async throws {

        let lastPageActive = [
            PaginationItem(
                title: "First Page",
                order: 1,
                friendly_url: "page-1",
                selected: false
            ),
            PaginationItem(
                title: "Second Page",
                order: 2,
                friendly_url: "page-2",
                selected: true
            ),
        ]
        let data = PaginationData(pages: lastPageActive, hrefBase: "/stories")
        let html = renderHTML(Pagination(data).render())

        #expect(html.contains("First page: First Page"))
        #expect(!html.contains("Last page"))
    }

    @Test("renders up to 3 page numbers for 2 pages")
    func rendersTwoPages() async throws {

        let twoPages = [
            PaginationItem(
                title: "Page One",
                order: 1,
                friendly_url: "p1",
                selected: true
            ),
            PaginationItem(
                title: "Page Two",
                order: 2,
                friendly_url: "p2",
                selected: false
            ),
        ]
        let data = PaginationData(pages: twoPages, hrefBase: "/stories")
        let html = renderHTML(Pagination(data).render())

        #expect(html.contains("aria-current=\"page\""))
        #expect(html.contains("<span>1</span>"))
        #expect(html.contains("href=\"/stories/p2\""))
        #expect(!html.contains("<span>3</span>"))
    }

    @Test("renders two pages before and two pages after when available")
    func rendersTwoPagesBeforeAndAfter() async throws {

        // 100 pages, page 50 is selected (0-indexed: 49)
        let manyPages = (1...100)
            .map { i in
                PaginationItem(
                    title: "Page \(i)",
                    order: i,
                    friendly_url: "p\(i)",
                    selected: i == 50
                )
            }
        let data = PaginationData(pages: manyPages, hrefBase: "/stories")
        let html = renderHTML(Pagination(data).render())

        // Selected is page 50, visible should be 48, 49, 50, 51, 52
        #expect(html.contains("aria-current=\"page\""))
        #expect(html.contains("<span>50</span>"))
        #expect(html.contains("href=\"/stories/p48\""))
        #expect(html.contains("href=\"/stories/p49\""))
        #expect(html.contains("href=\"/stories/p51\""))
        #expect(html.contains("href=\"/stories/p52\""))
        // Should not contain pages outside the 2-page window as numbered buttons
        #expect(!html.contains("href=\"/stories/p47\""))
        #expect(!html.contains("href=\"/stories/p53\""))
        // First and Last buttons link to p1 and p100
        #expect(html.contains("First page: Page 1"))
        #expect(html.contains("href=\"/stories/p1\""))
        #expect(html.contains("Last page: Page 100"))
        #expect(html.contains("href=\"/stories/p100\""))
    }

    @Test("limits visible pages when first page is active in large list")
    func limitsVisiblePagesFirstPageActive() async throws {

        let manyPages = (1...20)
            .map { i in
                PaginationItem(
                    title: "Page \(i)",
                    order: i,
                    friendly_url: "p\(i)",
                    selected: i == 1
                )
            }
        let data = PaginationData(pages: manyPages, hrefBase: "/stories")
        let html = renderHTML(Pagination(data).render())

        #expect(html.contains("aria-current=\"page\""))
        #expect(html.contains("<span>1</span>"))
        #expect(html.contains("href=\"/stories/p2\""))
        #expect(html.contains("href=\"/stories/p3\""))
        #expect(!html.contains("href=\"/stories/p4\""))
        #expect(!html.contains("First page"))
        #expect(html.contains("Last page: Page 20"))
    }

    @Test("limits visible pages when last page is active in large list")
    func limitsVisiblePagesLastPageActive() async throws {

        let manyPages = (1...20)
            .map { i in
                PaginationItem(
                    title: "Page \(i)",
                    order: i,
                    friendly_url: "p\(i)",
                    selected: i == 20
                )
            }
        let data = PaginationData(pages: manyPages, hrefBase: "/stories")
        let html = renderHTML(Pagination(data).render())

        #expect(html.contains("aria-current=\"page\""))
        #expect(html.contains("<span>20</span>"))
        #expect(html.contains("href=\"/stories/p18\""))
        #expect(html.contains("href=\"/stories/p19\""))
        #expect(!html.contains("href=\"/stories/p17\""))
        #expect(!html.contains("Last page"))
        #expect(html.contains("First page: Page 1"))
    }

    @Test(
        "renders first and last buttons with two pages before and after current"
    )
    func rendersFirstAndLastWithTwoPagesBeforeAndAfter() async throws {

        let tenPages = (1...10)
            .map { i in
                PaginationItem(
                    title: "Page \(i)",
                    order: i,
                    friendly_url: "p\(i)",
                    selected: i == 4
                )
            }
        let data = PaginationData(pages: tenPages, hrefBase: "/stories")
        let html = renderHTML(Pagination(data).render())

        // First button pointing to Page 1
        #expect(html.contains("First page: Page 1"))
        #expect(html.contains("href=\"/stories/p1\""))

        // Two pages before: Page 2, Page 3
        #expect(html.contains("href=\"/stories/p2\""))
        #expect(html.contains("href=\"/stories/p3\""))

        // Current page: Page 4
        #expect(html.contains("aria-current=\"page\""))
        #expect(html.contains("<span>4</span>"))

        // Two pages after: Page 5, Page 6
        #expect(html.contains("href=\"/stories/p5\""))
        #expect(html.contains("href=\"/stories/p6\""))

        // Page 7 should not be in the numbered items
        #expect(!html.contains("href=\"/stories/p7\""))

        // Last button pointing to Page 10
        #expect(html.contains("Last page: Page 10"))
        #expect(html.contains("href=\"/stories/p10\""))
    }

    @Test(
        "hides current-2 and current+2 on small screens with hidden md:inline-block"
    )
    func hidesOuterPagesOnSmallScreens() async throws {

        let tenPages = (1...10)
            .map { i in
                PaginationItem(
                    title: "Page \(i)",
                    order: i,
                    friendly_url: "p\(i)",
                    selected: i == 4
                )
            }
        let data = PaginationData(pages: tenPages, hrefBase: "/stories")
        let html = renderHTML(Pagination(data).render())

        // Page 2 (current-2) and Page 6 (current+2) should have hidden md:inline-block
        #expect(
            html.contains(
                "<li class=\"hidden md:inline-block\"><div class=\"relative inline-block max-w-full\"><a href=\"/stories/p2\""
            )
        )
        #expect(
            html.contains(
                "<li class=\"hidden md:inline-block\"><div class=\"relative inline-block max-w-full\"><a href=\"/stories/p6\""
            )
        )

        // Page 3 (current-1) and Page 5 (current+1) should not have hidden md:inline-block
        #expect(
            html.contains(
                "<li><div class=\"relative inline-block max-w-full\"><a href=\"/stories/p3\""
            )
        )
        #expect(
            html.contains(
                "<li><div class=\"relative inline-block max-w-full\"><a href=\"/stories/p5\""
            )
        )
    }

    @Test(
        "truncates table of content text with truncate max-w-xs md:max-w-none md:text-clip"
    )
    func truncatesTableOfContentText() async throws {

        let data = PaginationData(
            tableOfContent: PaginationItem(
                title: "Very Long Table Of Contents Title",
                order: 0,
                friendly_url: "toc"
            ),
            pages: pages,
            hrefBase: "/stories"
        )
        let html = renderHTML(Pagination(data).render())

        #expect(html.contains("truncate max-w-xs md:max-w-none md:text-clip"))
    }
}
