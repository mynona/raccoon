import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("Badge")
struct BadgeTests {

    @Test("renders badge title")
    func rendersBadgeTitle() async throws {

        let html = renderHTML(
            Badge(BadgeData(id: "badge-1", title: "swift"))
                .render()
        )
        #expect(html.contains("swift"))
    }

    @Test("replaces hyphens with spaces in title")
    func replacesHyphensWithSpaces() async throws {

        let html = renderHTML(
            Badge(BadgeData(id: "badge-2", title: "swift-vapor"))
                .render()
        )
        #expect(html.contains("swift vapor"))
    }

    @Test("renders counter when provided")
    func rendersCounter() async throws {

        let html = renderHTML(
            Badge(BadgeData(id: "badge-3", title: "posts", counter: 42))
                .render()
        )
        #expect(html.contains("42"))
    }

    @Test("renders anchor tag when linkable")
    func rendersLinkableAsBadge() async throws {

        let html = renderHTML(
            Badge(
                BadgeData(id: "badge-4", title: "swift", isLink: true)
            )
            .render()
        )
        #expect(html.contains("<a"))
        #expect(html.contains("/tags/swift"))
    }

    @Test("renders span when not linkable")
    func rendersSpanWhenNotLinkable() async throws {

        let html = renderHTML(
            Badge(
                BadgeData(id: "badge-5", title: "swift", isLink: false)
            )
            .render()
        )
        #expect(html.contains("<span"))
    }

    @Test("renders link tracking attributes and encoded tag URL")
    func rendersLinkTrackingAttributesAndEncodedTagURL() async throws {

        let html = renderHTML(
            Badge(
                BadgeData(
                    id: "badge-6",
                    title: "Swift Vapor",
                    counter: 3,
                    isLink: true,
                    matomoStatus: .ACCEPTED
                )
            )
            .render()
        )
        #expect(html.contains("href=\"/tags/swift%20vapor/\""))
        #expect(html.contains("data-track-content"))
        #expect(html.contains("data-content-name=\"badge\""))
        #expect(html.contains("data-content-piece=\"link.tag\""))
        #expect(html.contains("data-content-target=\"/tags/swift%20vapor\""))
    }

    @Test("omits tracking when matomoStatus is declined")
    func omitsTrackingWhenDeclined() async throws {

        let html = renderHTML(
            Badge(
                BadgeData(
                    id: "badge-6b",
                    title: "Swift Vapor",
                    isLink: true,
                    matomoStatus: .DECLINED
                )
            )
            .render()
        )
        #expect(html.contains("href=\"/tags/swift%20vapor/\""))
        #expect(!html.contains("data-track-content"))
    }

    @Test("supports custom tagUrlPrefix and formatHyphens false")
    func supportsCustomTagUrlPrefixAndNoHyphenFormatting() async throws {

        let html = renderHTML(
            Badge(
                BadgeData(
                    id: "badge-6c",
                    title: "c-sharp",
                    tagUrlPrefix: "/categories/",
                    isLink: true,
                    hasHyphenFormatting: false
                )
            )
            .render()
        )
        #expect(html.contains("href=\"/categories/c-sharp/\""))
        #expect(html.contains("c-sharp"))
    }

    @Test("renders counter split styling and group label")
    func rendersCounterSplitStylingAndGroupLabel() async throws {

        let html = renderHTML(
            Badge(BadgeData(id: "badge-7", title: "Messages", counter: 5))
                .render()
        )
        #expect(html.contains("rounded-l-lg"))
        #expect(html.contains("rounded-r-lg"))
        #expect(html.contains("role=\"group\""))
        #expect(html.contains("Articles tagged as 'Messages'"))
    }

    @Test("renders without counter has full rounded-lg")
    func rendersWithoutCounterHasFullRoundedLg() async throws {

        let html = renderHTML(
            Badge(BadgeData(id: "badge-8", title: "Single"))
                .render()
        )
        #expect(html.contains("rounded-lg"))
        #expect(!html.contains("rounded-l-lg"))
        #expect(!html.contains("rounded-r-lg"))
    }
}
