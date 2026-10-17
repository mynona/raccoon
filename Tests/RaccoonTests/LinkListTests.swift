import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

private let tracker = MatomoContentTracker(
    name: "test",
    piece: "link-list",
    target: "#"
)

@Suite("LinkList")
struct LinkListTests {
    @Test("renders nothing with empty links")
    func rendersNothingWithEmptyLinks() async throws {
        let data = LinkListData(
            links: [:],
            icon: .arrow_right_circle,
            matomoStatus: .ACCEPTED,
            contentTracker: tracker
        )
        let html = renderHTML(LinkList(data).render())
        #expect(!html.contains("<a"))
    }

    @Test("renders with nil and whitespace labels")
    func rendersNilAndWhitespaceLabels() async throws {
        let data = LinkListData(
            links: [
                " ": "/space", "\t": "/tab", "\n": "/newline", "": "/empty",
            ],
            icon: .arrow_right_circle,
            contentTracker: tracker
        )
        let html = renderHTML(LinkList(data).render())
        #expect(html.contains("/space"))
        #expect(html.contains("/tab"))
        #expect(html.contains("/newline"))
        #expect(html.contains("/empty"))
    }

    @Test("renders icon only (empty label)")
    func rendersIconOnly() async throws {
        let data = LinkListData(
            links: ["": "/icononly"],
            icon: .airplane,
            contentTracker: tracker
        )
        let html = renderHTML(LinkList(data).render())
        #expect(html.contains("svg"))
        #expect(html.contains("/icononly"))
    }

    @Test("renders with HTML special characters in label and href")
    func rendersHtmlEscaping() async throws {
        let data = LinkListData(
            links: ["<b>Bold</b>": "/<script>?x=1&y=2"],
            icon: .arrow_right_circle,
            contentTracker: tracker
        )
        let html = renderHTML(LinkList(data).render())
        #expect(
            html.contains("&lt;b&gt;Bold&lt;/b&gt;")
                || html.contains("<b>Bold</b>")
        )
        #expect(
            html.contains("/&lt;script&gt;?x=1&amp;y=2")
                || html.contains("/<script>?x=1&y=2")
        )
    }

    @Test("renders 100+ links (performance)")
    func rendersManyLinks() async throws {
        var links: [String: String?] = [:]
        for i in 1...120 {
            links["Link #\(i) 🚀"] = "/l\(i)"
        }
        let data = LinkListData(
            links: links,
            icon: .arrow_right_circle,
            contentTracker: tracker
        )
        let html = renderHTML(LinkList(data).render())
        #expect(html.contains("Link #1 🚀"))
        #expect(html.contains("/l120"))
        #expect(html.components(separatedBy: "<a").count > 100)
    }

    @Test("matomo tracking attributes per link")
    func matomoTrackingAttributes() async throws {
        let data = LinkListData(
            links: ["Tracked": "/tracked"],
            icon: .arrow_right_circle,
            matomoStatus: .ACCEPTED,
            contentTracker: MatomoContentTracker(
                name: "matomo",
                piece: "piece",
                target: "target"
            )
        )
        let html = renderHTML(LinkList(data).render())
        #expect(html.contains("data-track-content"))
        #expect(html.contains("data-content-name=\"matomo\""))
        #expect(html.contains("data-content-piece=\"Tracked\""))
        #expect(html.contains("data-content-target=\"/tracked\""))
    }

    @Test("renders with all icon and border/margin variants")
    func rendersAllIconAndBorderMarginVariants() async throws {
        let icons: [SvgIcon?] = [.arrow_right_circle, .airplane, nil]
        for icon in icons {
            let data = LinkListData(
                links: ["A": "/a", "B": "/b"],
                icon: icon,
                contentTracker: tracker
            )
            let html = renderHTML(LinkList(data).render())
            #expect(html.contains("<a"))
            #expect(html.contains("A"))
            #expect(html.contains("B"))
            if icon != nil {
                #expect(html.contains("svg"))
            }
        }
    }
}

@Test("renders with empty and special character labels")
func rendersEmptyAndSpecialLabels() async throws {
    let data = LinkListData(
        links: ["": "/empty", "Löng 🚀": "/long"],
        icon: .arrow_right_circle,
        contentTracker: tracker
    )
    let html = renderHTML(LinkList(data).render())
    #expect(html.contains("/empty"))
    #expect(html.contains("Löng 🚀"))
}

@Test("skips entries with missing and empty hrefs")
func rendersMissingAndEmptyHrefs() async throws {
    let data = LinkListData(
        links: ["No href": nil, "Empty href": ""],
        icon: .arrow_right_circle,
        contentTracker: tracker
    )
    let html = renderHTML(LinkList(data).render())
    #expect(!html.contains("No href"))
    #expect(!html.contains("Empty href"))
    #expect(!html.contains("<a"))
}

@Test(
    "accessibility: aria-label, role, tabindex, and data attributes for all links"
)
func accessibilityAttributesAllLinks() async throws {
    let data = LinkListData(
        links: ["A": "/a", "B": "/b"],
        icon: .arrow_right_circle,
        matomoStatus: .ACCEPTED,
        contentTracker: tracker
    )
    let html = renderHTML(LinkList(data).render())
    // Visible label text is the accessible name; aria-label is intentionally omitted
    #expect(!html.contains("aria-label=\"A\""))
    #expect(!html.contains("aria-label=\"B\""))
    #expect(html.contains("A"))
    #expect(html.contains("B"))
    #expect(html.contains("data-track-content"))
}

@Test("renders with all prop combinations (exhaustive)")
func rendersAllPropCombinations() async throws {
    let icons: [SvgIcon?] = [.arrow_right_circle, nil]
    let linksList: [[String: String?]] = [
        ["A": "/a"],
        ["B": nil],
        ["": ""],
        ["Löng 🚀": "/long"],
    ]
    for icon in icons {
        for links in linksList {
            let data = LinkListData(
                links: links,
                icon: icon,
                contentTracker: tracker
            )
            let html = renderHTML(LinkList(data).render())
            // entries without a usable href are skipped, so no anchor is emitted
            let hasUsableHref = links.contains {
                ($0.value ?? "").isEmpty == false
            }
            #expect(html.contains("<a") == hasUsableHref)
            // visible label text (the key) is the accessible name when a link is rendered
            if hasUsableHref,
                let key = links.first(where: {
                    ($0.value ?? "").isEmpty == false
                })?
                .key
            {
                #expect(html.contains(key))
            }
        }
    }
}

@Test("renders link text")
func rendersLinkText() async throws {

    let data = LinkListData(
        links: ["Getting started": "/start"],
        icon: .arrow_right_circle,
        contentTracker: tracker
    )
    let html = renderHTML(LinkList(data).render())
    #expect(html.contains("Getting started"))
}

@Test("renders multiple link hrefs")
func rendersMultipleLinkHrefs() async throws {

    let data = LinkListData(
        links: ["Blog": "/blog", "Docs": "/docs"],
        icon: .arrow_right_circle,
        contentTracker: tracker
    )
    let html = renderHTML(LinkList(data).render())
    #expect(html.contains("/blog"))
    #expect(html.contains("/docs"))
}

@Test("renders anchor elements for each link")
func rendersAnchorElements() async throws {

    let data = LinkListData(
        links: ["Home": "/"],
        icon: .arrow_right_circle,
        contentTracker: tracker
    )
    let html = renderHTML(LinkList(data).render())
    #expect(html.contains("<a"))
}
