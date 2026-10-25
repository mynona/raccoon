import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("Breadcrumb")
struct BreadcrumbTests {

    @Test("renders path titles as links")
    func rendersPathTitles() async throws {

        let ctx = BreadcrumbData(paths: [
            BreadcrumbPath(title: "Blog", href: "/blog/", hreflang: "en-US")
        ])
        let html = renderHTML(Breadcrumb(ctx).render())
        #expect(html.contains("Blog"))
        #expect(html.contains("/blog/"))
    }

    @Test("renders nav element")
    func rendersNavElement() async throws {

        let ctx = BreadcrumbData(paths: [
            BreadcrumbPath(title: "Home", href: "/", hreflang: "en-US")
        ])
        let html = renderHTML(Breadcrumb(ctx).render())
        #expect(html.contains("<nav"))
        #expect(html.contains("aria-label=\"Breadcrumb\""))
        #expect(html.contains(BreadcrumbStyles.list))
        #expect(html.contains("whitespace-nowrap"))
    }

    @Test("renders home link when showHome is true")
    func rendersHomeLinkWhenEnabled() async throws {

        let ctx = BreadcrumbData(
            paths: [],
            homeHreflang: "en-US",
            hasHome: true,
            matomoStatus: .ACCEPTED
        )
        let html = renderHTML(Breadcrumb(ctx).render())
        #expect(html.contains("/home/"))
        #expect(html.contains("hreflang=\"en-US\""))
        #expect(html.contains("aria-label=\"Home\""))
        #expect(html.contains("data-content-piece=\"breadcrumb.home\""))
        #expect(html.contains("data-content-target=\"/home\""))
    }

    @Test("renders current segment with page semantics as span")
    func rendersCurrentSegmentWithPageSemantics() async throws {

        let ctx = BreadcrumbData(paths: [
            BreadcrumbPath(title: "Level 1", href: "/one", hreflang: "en-US"),
            BreadcrumbPath(
                title: "Level 2",
                href: "/one/two",
                hreflang: "en-US"
            ),
            BreadcrumbPath(
                title: "Level 3",
                href: "/one/two/three",
                hreflang: "en-US",
                isCurrentPathSegment: true
            ),
        ])
        let html = renderHTML(Breadcrumb(ctx).render())
        #expect(html.contains("aria-current=\"page\""))
        #expect(html.contains("class=\"sr-only\">Level 3</span>"))
        #expect(!html.contains("href=\"\""))
        #expect(html.contains(">…</span>"))
        #expect(html.contains(">Level 3</span>"))
    }

    @Test("renders current segment title directly for short breadcrumb trails")
    func rendersCurrentSegmentTitleForShortTrail() async throws {

        let ctx = BreadcrumbData(paths: [
            BreadcrumbPath(title: "Level 1", href: "/one", hreflang: "en-US"),
            BreadcrumbPath(
                title: "Level 2",
                href: "/one/two",
                hreflang: "en-US",
                isCurrentPathSegment: true
            ),
        ])
        let html = renderHTML(Breadcrumb(ctx).render())
        #expect(html.contains("aria-current=\"page\""))
        #expect(html.contains(">Level 2</span>"))
        #expect(!html.contains(">…</span>"))
    }

    @Test("renders separators as decorative only")
    func rendersSeparatorsAsDecorativeOnly() async throws {

        let ctx = BreadcrumbData(
            paths: [
                BreadcrumbPath(
                    title: "Level 1",
                    href: "/one",
                    hreflang: "en-US"
                ),
                BreadcrumbPath(
                    title: "Level 2",
                    href: "/one/two",
                    hreflang: "en-US",
                    isCurrentPathSegment: true
                ),
            ],
            hasHome: true,
            matomoStatus: .ACCEPTED
        )
        let html = renderHTML(Breadcrumb(ctx).render())
        #expect(html.contains("aria-hidden=\"true\""))
        #expect(html.contains("data-content-piece=\"breadcrumb.pathsegment\""))
        #expect(html.contains("data-content-target=\"/one\""))
    }

    @Test("renders empty when paths is nil")
    func rendersNothingWithNilPaths() async throws {

        let ctx = BreadcrumbData(paths: nil)
        let html = renderHTML(Breadcrumb(ctx).render())
        #expect(!html.contains("<nav"))
    }

    @Test("handles empty title in path")
    func handlesEmptyTitle() async throws {
        let ctx = BreadcrumbData(paths: [
            BreadcrumbPath(title: "", href: "/empty/", hreflang: "en-US")
        ])
        let html = renderHTML(Breadcrumb(ctx).render())
        #expect(html.contains("/empty/"))
    }

    @Test("handles missing href in path")
    func handlesMissingHref() async throws {
        let ctx = BreadcrumbData(paths: [
            BreadcrumbPath(title: "NoHref", href: "", hreflang: "en-US")
        ])
        let html = renderHTML(Breadcrumb(ctx).render())
        #expect(html.contains("NoHref"))
    }

    @Test("handles invalid hreflang in path")
    func handlesInvalidHreflang() async throws {
        let ctx = BreadcrumbData(paths: [
            BreadcrumbPath(
                title: "InvalidLang",
                href: "/lang/",
                hreflang: "1234"
            )
        ])
        let html = renderHTML(Breadcrumb(ctx).render())
        #expect(html.contains("/lang/"))
        #expect(html.contains("InvalidLang"))
    }
}
