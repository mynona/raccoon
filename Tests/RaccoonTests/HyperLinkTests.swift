import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

private let tracker = MatomoContentTracker(
    name: "test",
    piece: "link",
    target: "#"
)

@Suite("HyperLink")
struct HyperLinkTests {

    @Test("renders anchor element")
    func rendersAnchorElement() async throws {

        let html = renderHTML(
            HyperLink(
                HyperLinkData(
                    label: "Read more",
                    href: "/blog/",
                    isFocusable: true,
                    isUnderlined: true,
                    contentTracker: tracker
                )
            )
            .render()
        )
        #expect(html.contains("<a"))
    }

    @Test("renders label text")
    func rendersLabel() async throws {

        let html = renderHTML(
            HyperLink(
                HyperLinkData(
                    label: "Read more",
                    href: "/blog/",
                    isFocusable: true,
                    isUnderlined: true,
                    contentTracker: tracker
                )
            )
            .render()
        )
        #expect(html.contains("Read more"))
    }

    @Test("renders href attribute")
    func rendersHref() async throws {

        let html = renderHTML(
            HyperLink(
                HyperLinkData(
                    label: "Go",
                    href: "/destination/",
                    isFocusable: true,
                    isUnderlined: false,
                    contentTracker: tracker
                )
            )
            .render()
        )
        #expect(html.contains("/destination/"))
    }

    @Test("renders all alignments")
    func rendersAllAlignments() async throws {
        for align in [HyperLinkData.Alignment.left, .center] {
            let html = renderHTML(
                HyperLink(
                    HyperLinkData(
                        label: "Align",
                        href: "/",
                        align: align,
                        isFocusable: true,
                        isUnderlined: true,
                        contentTracker: tracker
                    )
                )
                .render()
            )
            #expect(html.contains("<a"))
            if align == .center {
                #expect(html.contains("text-center"))
            }
            else {
                #expect(html.contains("text-left"))
            }
        }
    }

    @Test("renders with all icon sizes")
    func rendersAllIconSizes() async throws {
        for size in [12, 16, 24] {
            let html = renderHTML(
                HyperLink(
                    HyperLinkData(
                        label: "Icon",
                        href: "/",
                        icon: .arrow_right,
                        iconSize: size,
                        isFocusable: true,
                        isUnderlined: true,
                        contentTracker: tracker
                    )
                )
                .render()
            )
            #expect(html.contains("<a"))
        }
    }

    @Test("renders tooltip and ariaLabel combos")
    func rendersTooltipAndAriaLabelCombos() async throws {
        let html = renderHTML(
            HyperLink(
                HyperLinkData(
                    label: "Help",
                    ariaLabel: "More info link",
                    href: "/",
                    tooltip: "More info",
                    isFocusable: true,
                    isUnderlined: true,
                    contentTracker: tracker
                )
            )
            .render()
        )
        #expect(html.contains("More info"))
    }

    @Test("renders with missing href")
    func rendersWithMissingHref() async throws {
        let html = renderHTML(
            HyperLink(
                HyperLinkData(
                    label: "NoHref",
                    href: "#",
                    isFocusable: true,
                    isUnderlined: true,
                    contentTracker: tracker
                )
            )
            .render()
        )
        #expect(html.contains("<a"))
    }

    @Test("renders tracking attributes and no hreflang")
    func rendersTrackingAttributesWithoutHreflang() async throws {

        let html = renderHTML(
            HyperLink(
                HyperLinkData(
                    label: "Docs",
                    href: "/docs/",
                    isFocusable: true,
                    isUnderlined: true,
                    matomoStatus: .ACCEPTED,
                    contentTracker: tracker
                )
            )
            .render()
        )
        #expect(!html.contains("hreflang"))
        #expect(html.contains("data-track-content"))
        #expect(html.contains("data-content-name=\"test\""))
        #expect(html.contains("data-content-piece=\"link\""))
        #expect(html.contains("data-content-target=\"#\""))
    }

    @Test("renders tooltip mouse events and alpine container")
    func rendersTooltipMouseEventsAndAlpineContainer() async throws {

        let html = renderHTML(
            HyperLink(
                HyperLinkData(
                    label: "Help",
                    ariaLabel: "Help link",
                    href: "#",
                    tooltip: "Some tooltip",
                    isFocusable: true,
                    isUnderlined: true,
                    contentTracker: tracker
                )
            )
            .render()
        )
        #expect(html.contains("Some tooltip"))
        #expect(html.contains("x-on:mouseenter"))
        #expect(html.contains("x-on:mouseleave"))
        #expect(html.contains("x-data=\"\""))
    }

    @Test("renders non-focusable and non-underlined styles")
    func rendersNonFocusableAndNonUnderlinedStyles() async throws {

        let html = renderHTML(
            HyperLink(
                HyperLinkData(
                    label: "Plain",
                    href: "#",
                    icon: .airplane,
                    iconSize: 48,
                    isFocusable: false,
                    isUnderlined: false,
                    contentTracker: tracker
                )
            )
            .render()
        )
        #expect(html.contains("!no-underline"))
        #expect(
            html.contains("focus:outline-hidden")
                || html.contains("focus:ring-0")
        )
        #expect(html.contains("width=\"48px\""))
    }

    @Test("renders with multiline-ready wrapping classes")
    func rendersMultilineClasses() async throws {

        let html = renderHTML(
            HyperLink(
                HyperLinkData(
                    label:
                        "This is a long hyperlink text designed to wrap onto multiple lines cleanly",
                    href: "#",
                    isFocusable: true,
                    isUnderlined: true,
                    contentTracker: tracker
                )
            )
            .render()
        )
        #expect(html.contains("max-w-full"))
        #expect(html.contains("break-words"))
    }

    // MARK: localization

    @Test(
        "label, aria-label and tooltip take LocalizedText; literals stay plain"
    )
    func localizedTexts() {
        let data = HyperLinkData(
            label: LocalizedText(
                en: "Read more",
                translations: ["de": "Weiterlesen"]
            ),
            ariaLabel: LocalizedText(
                en: "Read the post",
                translations: ["de": "Beitrag lesen"]
            ),
            href: "/blog/",
            tooltip: LocalizedText(
                en: "Opens the post",
                translations: ["de": "Öffnet den Beitrag"]
            ),
            isFocusable: true,
            isUnderlined: true,
            contentTracker: tracker
        )
        let html = I18n.render(language: "de") {
            renderHTML(HyperLink(data).render())
        }
        #expect(html.contains(">Weiterlesen</span>"))
        #expect(html.contains("aria-label=\"Beitrag lesen\""))
        #expect(html.contains("'Öffnet den Beitrag'"))

        let plain = I18n.render(language: "de") {
            renderHTML(
                HyperLink(
                    HyperLinkData(
                        label: "Plain",
                        href: "/x",
                        isFocusable: true,
                        isUnderlined: true,
                        contentTracker: tracker
                    )
                )
                .render()
            )
        }
        #expect(plain.contains(">Plain</span>"))
        #expect(!plain.contains("data-i18n"))
    }
}
