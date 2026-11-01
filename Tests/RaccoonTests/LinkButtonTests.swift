import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

private let tracker = MatomoContentTracker(
    name: "test",
    piece: "link-button",
    target: "#"
)

@Suite("LinkButton")
struct LinkButtonTests {

    @Test("renders all button types and variants")
    func rendersAllActionButtonTypesAndVariants() async throws {
        let types: [ActionButtonType] = [
            .primary, .secondary, .tertiary, .warning, .icon,
        ]
        let icons: [SvgIcon?] = [.airplane, .camera, .cake, .tree, .mouse, nil]
        let bools = [true, false]
        for type in types {
            for icon in icons {
                //for inverted in bools {
                for fullWidth in bools {
                    let html = renderHTML(
                        LinkButton(
                            LinkButtonData(
                                label: type == .icon ? nil : "Label",
                                ariaLabel: "aria-label",
                                href: "/test/",
                                hreflang: "en-US",
                                buttonType: type,
                                icon: icon,
                                iconSize: 16,
                                hasFullWidth: fullWidth,
                                contentTracker: tracker
                            )
                        )
                        .render()
                    )
                    #expect(html.contains("<a"))
                    if type == .icon {
                        #expect(html.contains("aria-label=\"aria-label\""))
                    }
                    else {
                        #expect(!html.contains("aria-label=\"aria-label\""))
                    }

                    if let _ = icon, type != .icon {
                        #expect(html.contains("svg"))
                    }
                    if type == .icon {
                        #expect(!html.contains(">Label<"))
                    }
                    else {
                        #expect(html.contains("Label"))
                    }
                    if fullWidth {
                        #expect(html.contains("w-full"))
                    }
                    else {
                        #expect(html.contains("w-fit max-w-full"))
                    }
                }
                //}
            }
        }
    }

    @Test("renders with empty label and only icon")
    func rendersIconOnly() async throws {
        let html = renderHTML(
            LinkButton(
                LinkButtonData(
                    label: nil,
                    ariaLabel: "icon only",
                    href: "/icon/",
                    buttonType: .icon,
                    icon: .mouse,
                    iconSize: 16,
                    contentTracker: tracker
                )
            )
            .render()
        )
        #expect(html.contains("svg"))
        #expect(!html.contains(">Label<"))
    }

    @Test("renders with long and special character label")
    func rendersLongAndSpecialLabel() async throws {
        let label = "Löng Label with $pec!al <chars> & emoji 🚀"
        let html = renderHTML(
            LinkButton(
                LinkButtonData(
                    label: LocalizedText(verbatim: label),
                    ariaLabel: LocalizedText(verbatim: label),
                    href: "/long/",
                    buttonType: .primary,
                    contentTracker: tracker
                )
            )
            .render()
        )
        #expect(html.contains(label))
    }

    @Test("renders with missing href")
    func rendersMissingHref() async throws {
        let html = renderHTML(
            LinkButton(
                LinkButtonData(
                    label: "No href",
                    ariaLabel: "No href",
                    href: "",
                    buttonType: .primary,
                    contentTracker: tracker
                )
            )
            .render()
        )
        #expect(html.contains("href=\"\""))
    }

    @Test("accessibility: aria-label, role, tabindex, and data attributes")
    func accessibilityAttributes() async throws {
        let html = renderHTML(
            LinkButton(
                LinkButtonData(
                    label: nil,
                    ariaLabel: "aria-label",
                    href: "/a11y/",
                    buttonType: .primary,
                    matomoStatus: .ACCEPTED,
                    contentTracker: tracker
                )
            )
            .render()
        )
        #expect(html.contains("aria-label=\"aria-label\""))
        #expect(html.contains("data-track-content"))
        #expect(html.contains("data-content-name=\"test\""))
        #expect(html.contains("data-content-piece=\"link-button\""))
        #expect(html.contains("data-content-target=\"#\""))
    }

    @Test(
        "renders anchor with an accessible name across representative prop combinations",
        arguments: [
            (
                "Label", "aria-label", "/url", "en-US",
                SvgIcon?.some(.airplane), Int?.some(16),
                ActionButtonType.primary, true
            ),
            (
                nil, "special 🚀", "/äöü/", nil, SvgIcon?.some(.airplane),
                Int?.some(32), ActionButtonType.icon, false
            ),
            (
                "Label", "", "", "de-DE", SvgIcon?.none, Int?.none,
                ActionButtonType.tertiary, true
            ),
            (
                nil, "aria-label", "/long-url-with-query?x=1&y=2", nil,
                SvgIcon?.none, Int?.some(16), ActionButtonType.warning, false
            ),
            (
                "Label", "special 🚀", "/url", "en-US", SvgIcon?.none, Int?.none,
                ActionButtonType.secondary, false
            ),
        ]
    )
    func rendersPropCombinations(
        label: String?,
        ariaLabel: String,
        href: String,
        hreflang: String?,
        icon: SvgIcon?,
        iconSize: Int?,
        type: ActionButtonType,
        fullWidth: Bool
    ) async throws {
        let html = renderHTML(
            LinkButton(
                LinkButtonData(
                    label: label.map(LocalizedText.init(verbatim:)),
                    ariaLabel: LocalizedText(verbatim: ariaLabel),
                    href: href,
                    hreflang: hreflang,
                    buttonType: type,
                    icon: icon,
                    iconSize: iconSize,
                    hasFullWidth: fullWidth,
                    contentTracker: tracker
                )
            )
            .render()
        )
        #expect(html.contains("<a"))
        if let label,
            !label.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        {
            #expect(html.contains(label))
        }
        else {
            #expect(html.contains("aria-label"))
        }
    }

    @Test("renders anchor element")
    func rendersAnchorElement() async throws {

        let html = renderHTML(
            LinkButton(
                LinkButtonData(
                    label: "Get started",
                    ariaLabel: "Get started",
                    href: "/start/",
                    buttonType: .primary,
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
            LinkButton(
                LinkButtonData(
                    label: "Learn more",
                    ariaLabel: "Learn more",
                    href: "/docs/",
                    buttonType: .secondary,
                    contentTracker: tracker
                )
            )
            .render()
        )
        #expect(html.contains("Learn more"))
    }

    @Test("renders href attribute")
    func rendersHref() async throws {

        let html = renderHTML(
            LinkButton(
                LinkButtonData(
                    label: "Go",
                    ariaLabel: "Go",
                    href: "/target/",
                    buttonType: .primary,
                    contentTracker: tracker
                )
            )
            .render()
        )
        #expect(html.contains("/target/"))
    }

    @Test("omits tracking attributes when Matomo is declined")
    func omitsTrackingAttributesWhenMatomoIsDeclined() async throws {

        let html = renderHTML(
            LinkButton(
                LinkButtonData(
                    label: "Tracked",
                    ariaLabel: "Tracked",
                    href: "/tracked/",
                    buttonType: .primary,
                    matomoStatus: .DECLINED,
                    contentTracker: tracker
                )
            )
            .render()
        )
        #expect(!html.contains("data-track-content"))
        #expect(!html.contains("data-content-name"))
        #expect(!html.contains("data-content-piece"))
        #expect(!html.contains("data-content-target"))
    }

    @Test("renders truncation classes when hasTruncation is true")
    func rendersTruncationClasses() async throws {

        let html = renderHTML(
            LinkButton(
                LinkButtonData(
                    label: "Very Long Button Text",
                    href: "/long/",
                    buttonType: .tertiary,
                    hasTruncation: true,
                    contentTracker: tracker
                )
            )
            .render()
        )
        #expect(html.contains("truncate max-w-xs md:max-w-none md:text-clip"))
    }

    @Test(
        "renders with multiline-ready wrapping classes and no whitespace-nowrap"
    )
    func rendersMultilineClasses() async throws {

        let html = renderHTML(
            LinkButton(
                LinkButtonData(
                    label:
                        "This is a very long link button label that should wrap gracefully",
                    ariaLabel: "Long link",
                    href: "/multiline/",
                    buttonType: .primary,
                    icon: .airplane,
                    contentTracker: tracker
                )
            )
            .render()
        )
        #expect(!html.contains("whitespace-nowrap"))
        #expect(html.contains("w-fit max-w-full"))
        #expect(html.contains("break-words"))
        #expect(html.contains("flex-none shrink-0"))
        #expect(html.contains("flex-1"))
    }

    @Test("renders centered content container consistent with ActionButton")
    func rendersCenteredContentContainer() async throws {

        let html = renderHTML(
            LinkButton(
                LinkButtonData(
                    label: "Sign in with Google",
                    ariaLabel: "Sign in with Google",
                    href: "/auth2/google/",
                    buttonType: .secondary,
                    icon: .google,
                    hasFullWidth: true,
                    contentTracker: tracker
                )
            )
            .render()
        )
        #expect(
            html.contains(
                "flex items-center justify-center mx-auto space-x-4 max-w-full"
            )
        )
        #expect(html.contains("w-full"))
    }

    // MARK: localization

    private func render(_ data: LinkButtonData, language: String = "en")
        -> String
    {
        I18n.render(language: language) {
            renderHTML(LinkButton(data).render())
        }
    }

    @Test(
        "an icon-only button without texts falls back to the built-in 'Link' label"
    )
    func fallbackAriaLabelIsLocalized() {
        let data = LinkButtonData(
            href: "/x",
            buttonType: .primary,
            contentTracker: tracker
        )
        let english = render(data)
        #expect(english.contains("aria-label=\"Link\""))
        #expect(english.contains("data-i18n-aria-label=\"linkbutton.link\""))
        let french = render(data, language: "fr")
        #expect(french.contains("aria-label=\"Lien\""))
    }

    @Test("an icon name stays a plain aria-label without marker")
    func iconNameIsPlain() {
        let data = LinkButtonData(
            href: "/x",
            buttonType: .icon,
            icon: .airplane,
            contentTracker: tracker
        )
        let html = render(data, language: "de")
        #expect(html.contains("aria-label=\"airplane\""))
        #expect(!html.contains("data-i18n"))
    }

    @Test("a consumer label is rendered in the page language with its marker")
    func consumerLabel() {
        let data = LinkButtonData(
            label: LocalizedText(en: "Save", translations: ["de": "Speichern"]),
            href: "/x",
            buttonType: .primary,
            contentTracker: tracker
        )
        let html = render(data, language: "de")
        #expect(html.contains(">Speichern</span>"))
        #expect(html.contains("data-i18n-values="))
    }

    @Test("a consumer tooltip is used as aria-label of an icon-only button")
    func consumerTooltipAsAriaLabel() {
        let data = LinkButtonData(
            tooltip: LocalizedText(en: "Open", translations: ["de": "Öffnen"]),
            href: "/x",
            buttonType: .icon,
            icon: .airplane,
            contentTracker: tracker
        )
        let html = render(data, language: "de")
        #expect(html.contains("aria-label=\"Öffnen\""))
        #expect(html.contains("data-i18n-aria-label-values="))
        #expect(html.contains("RaccoonI18n.pick("))
    }

    @Test("a literal label stays plain in every language")
    func literalLabelIsPlain() {
        let data = LinkButtonData(
            label: "Home",
            href: "/x",
            buttonType: .primary,
            contentTracker: tracker
        )
        let html = render(data, language: "de")
        #expect(html.contains(">Home</span>"))
        #expect(!html.contains("data-i18n"))
    }

    @Test(
        "the tooltip id is derived from the English text and does not change per language"
    )
    func tooltipIdIsStable() {
        let data = LinkButtonData(
            tooltip: LocalizedText(en: "Open", translations: ["de": "Öffnen"]),
            href: "/x",
            buttonType: .icon,
            icon: .airplane,
            contentTracker: tracker
        )
        // The id is "tooltip-<hash of the English text>-<random suffix>"
        func tooltipIdPrefix(_ html: String) -> String? {
            html.components(separatedBy: "x-ref=\"tooltip-").dropFirst().first?
                .components(separatedBy: "-").first
        }
        let english = render(data)
        let german = render(data, language: "de")
        #expect(tooltipIdPrefix(english) != nil)
        #expect(tooltipIdPrefix(english) == tooltipIdPrefix(german))
    }
}
