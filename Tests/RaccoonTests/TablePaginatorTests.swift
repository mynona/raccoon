import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("TablePaginator")
struct TablePaginatorTests {

    // MARK: - TablePaginationInfo Tests

    @Test("TablePaginationInfo computes page totals and boundaries correctly")
    func paginationInfoCalculations() async throws {
        let info = TablePaginatorInfo(page: 1, per: 10, total: 95)
        #expect(info.totalPages == 10)
        #expect(!info.hasPrevious)
        #expect(info.hasNext)
        #expect(info.startItem == 1)
        #expect(info.endItem == 10)
        #expect(info.rangeLabel == "1 – 10 of 95")

        let middle = TablePaginatorInfo(page: 5, per: 10, total: 95)
        #expect(middle.hasPrevious)
        #expect(middle.hasNext)
        #expect(middle.startItem == 41)
        #expect(middle.endItem == 50)
        #expect(middle.rangeLabel == "41 – 50 of 95")

        let last = TablePaginatorInfo(page: 10, per: 10, total: 95)
        #expect(last.hasPrevious)
        #expect(!last.hasNext)
        #expect(last.startItem == 91)
        #expect(last.endItem == 95)
        #expect(last.rangeLabel == "91 – 95 of 95")

        let empty = TablePaginatorInfo(page: 1, per: 10, total: 0)
        #expect(empty.startItem == 0)
        #expect(empty.endItem == 0)
        #expect(empty.rangeLabel == "0 of 0")
        #expect(!empty.hasPrevious)
        #expect(!empty.hasNext)
    }

    @Test("TablePaginationInfo handles nil and out-of-bounds parameters safely")
    func paginationInfoSafeguards() async throws {
        let info = TablePaginatorInfo(
            page: nil,
            per: nil,
            total: 50,
            defaultPer: 25
        )
        #expect(info.page == 1)
        #expect(info.per == 25)
        #expect(info.totalPages == 2)

        let negative = TablePaginatorInfo(
            page: -3,
            per: -10,
            total: 50,
            defaultPer: 15
        )
        #expect(negative.page == 1)
        #expect(negative.per == 1)
    }

    // MARK: - Alpine Mode Tests

    @Test("renders table paginator in alpine mode with reactive bindings")
    func rendersAlpineMode() async throws {
        let data = TablePaginatorData(mode: .alpine)
        let html = renderHTML(TablePaginator(data).render())

        // Landmark & visibility
        #expect(html.contains("<nav"))
        #expect(html.contains("aria-label=\"Pagination\""))
        #expect(html.contains("x-show=\"hasSearched && total > 0\""))
        #expect(html.contains("x-cloak"))

        // Page size dropdown menu
        #expect(html.contains("Items per page:"))
        #expect(html.contains("id=\"itemsPerPage\""))
        #expect(html.contains("x-ref=\"button\""))
        #expect(html.contains(":aria-controls=\"$id('dropdown-button')\""))
        #expect(html.contains("x-text=\"per\""))
        #expect(html.contains("role=\"menu\""))
        #expect(html.contains("role=\"menuitem\""))
        #expect(html.contains("changePageSize("))

        // Range label
        #expect(html.contains("<p"))
        #expect(html.contains("x-text=\"rangeLabel\""))
        #expect(html.contains("aria-live=\"polite\""))

        // Navigation buttons
        #expect(html.contains("aria-label=\"First page\""))
        #expect(html.contains("@click=\"goToPage(1)\""))
        #expect(html.contains("aria-label=\"Previous page\""))
        #expect(html.contains("@click=\"previousPage()\""))
        #expect(html.contains("aria-label=\"Next page\""))
        #expect(html.contains("@click=\"nextPage()\""))
        #expect(html.contains("aria-label=\"Last page\""))
        #expect(html.contains("@click=\"goToPage(totalPages)\""))
        #expect(html.contains(":disabled=\"!(hasPrevious) || isLoading\""))
        #expect(html.contains(":disabled=\"!(hasNext) || isLoading\""))
    }

    @Test("alpine mode supports custom identifiers and handler bindings")
    func customAlpineBindings() async throws {
        let data = TablePaginatorData(
            selectId: "customSelectId",
            selectName: "customSelectName",
            bindPage: "currentPage",
            bindPer: "itemsLimit",
            bindTotal: "totalCount",
            bindRangeLabel: "formattedRange",
            bindShow: "totalCount > 0",
            onPageSizeChange: "onSizeChanged($event)",
            onFirstPage: "toFirst()",
            onPreviousPage: "toPrev()",
            onNextPage: "toNext()",
            onLastPage: "toLast()",
            ariaLabel: "User table navigation",
            itemsPerPageLabel: "Einträge pro Seite:",
            firstPageAriaLabel: "Erste Seite",
            mode: .alpine
        )
        let html = renderHTML(TablePaginator(data).render())

        #expect(html.contains("aria-label=\"User table navigation\""))
        #expect(html.contains("x-show=\"totalCount > 0\""))
        #expect(html.contains("id=\"customSelectId\""))
        #expect(html.contains("Einträge pro Seite:"))
        #expect(html.contains("x-text=\"itemsLimit\""))
        #expect(html.contains("x-text=\"formattedRange\""))
        #expect(html.contains("@click=\"toFirst()\""))
        #expect(html.contains("@click=\"toPrev()\""))
        #expect(html.contains("@click=\"toNext()\""))
        #expect(html.contains("@click=\"toLast()\""))
        #expect(html.contains("aria-label=\"Erste Seite\""))
    }

    // MARK: - SSR Link Mode Tests

    @Test("renders table paginator in link mode on first page")
    func rendersLinkModeFirstPage() async throws {
        let info = TablePaginatorInfo(page: 1, per: 10, total: 50)
        let data = TablePaginatorData(
            mode: .link(basePath: "/users", queryParams: ["role": "admin"]),
            info: info,
            pageSizeOptions: [10, 25, 50]
        )
        let html = renderHTML(TablePaginator(data).render())

        // Dropdown menu options in SSR mode
        #expect(html.contains("<span>10</span>"))
        #expect(
            html.contains(
                "<a href=\"/users?page=1&per=10&role=admin\" role=\"menuitem\" aria-checked=\"true\""
            )
        )
        #expect(
            html.contains(
                "<a href=\"/users?page=1&per=25&role=admin\" role=\"menuitem\""
            )
        )
        #expect(
            html.contains(
                "<a href=\"/users?page=1&per=50&role=admin\" role=\"menuitem\""
            )
        )

        // Static range text
        #expect(html.contains("1 – 10 of 50"))

        // First page: previous & first disabled button, next & last enabled link
        #expect(
            html.contains(
                "<button type=\"button\" aria-label=\"First page\" disabled"
            )
        )
        #expect(
            html.contains(
                "<button type=\"button\" aria-label=\"Previous page\" disabled"
            )
        )
        #expect(
            html.contains(
                "<a href=\"/users?page=2&per=10&role=admin\" aria-label=\"Next page\""
            )
        )
        #expect(
            html.contains(
                "<a href=\"/users?page=5&per=10&role=admin\" aria-label=\"Last page\""
            )
        )
    }

    @Test(
        "renders table paginator in link mode on middle page with all buttons active"
    )
    func rendersLinkModeMiddlePage() async throws {
        let info = TablePaginatorInfo(page: 3, per: 10, total: 50)
        let data = TablePaginatorData(
            mode: .link(basePath: "/items"),
            info: info
        )
        let html = renderHTML(TablePaginator(data).render())

        #expect(html.contains("21 – 30 of 50"))
        #expect(
            html.contains(
                "<a href=\"/items?page=1&per=10\" aria-label=\"First page\""
            )
        )
        #expect(
            html.contains(
                "<a href=\"/items?page=2&per=10\" aria-label=\"Previous page\""
            )
        )
        #expect(
            html.contains(
                "<a href=\"/items?page=4&per=10\" aria-label=\"Next page\""
            )
        )
        #expect(
            html.contains(
                "<a href=\"/items?page=5&per=10\" aria-label=\"Last page\""
            )
        )
    }

    @Test("renders table paginator in link mode on last page")
    func rendersLinkModeLastPage() async throws {
        let info = TablePaginatorInfo(page: 5, per: 10, total: 50)
        let data = TablePaginatorData(
            mode: .link(basePath: "/items"),
            info: info
        )
        let html = renderHTML(TablePaginator(data).render())

        #expect(html.contains("41 – 50 of 50"))
        #expect(
            html.contains(
                "<a href=\"/items?page=1&per=10\" aria-label=\"First page\""
            )
        )
        #expect(
            html.contains(
                "<a href=\"/items?page=4&per=10\" aria-label=\"Previous page\""
            )
        )
        #expect(
            html.contains(
                "<button type=\"button\" aria-label=\"Next page\" disabled"
            )
        )
        #expect(
            html.contains(
                "<button type=\"button\" aria-label=\"Last page\" disabled"
            )
        )
    }
}
