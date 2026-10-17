import Foundation
import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("TabGroup Component")
struct TabGroupTests {

    @Test(
        "Pills render joined segments without changing tab behavior",
        arguments: [
            TabOrientation.horizontal, .vertical,
        ]
    )
    func rendersSegmentedPills(orientation: TabOrientation) {
        let html = renderHTML(
            TabGroup(
                TabGroupData(
                    tabs: [
                        TabItemData(
                            id: "first",
                            label: "First",
                            content: .html("<p>One</p>")
                        ),
                        TabItemData(
                            id: "disabled",
                            label: "Disabled",
                            content: .html("<p>Two</p>"),
                            state: .disabled
                        ),
                    ],
                    variant: .pills,
                    orientation: orientation
                )
            )
            .render()
        )

        let listStyle =
            orientation == .horizontal
            ? TabGroupStyles.tabListHorizontalPills
            : TabGroupStyles.tabListVerticalPills
        #expect(html.contains("class=\"\(listStyle)\""))
        #expect(
            html.components(separatedBy: TabGroupStyles.tabPillsButtonBase)
                .count == 3
        )
        #expect(html.contains(TabGroupStyles.tabPillsActive))
        #expect(html.contains(TabGroupStyles.tabPillsInactive))
        #expect(!html.contains("bg-primary"))
        #expect(html.contains("border-b-on-theme"))
        #expect(html.contains("focus-visible:outline-2"))
        #expect(html.contains("forced-colors:border-b-[Highlight]"))
        #expect(html.contains("aria-disabled=\"true\""))
        #expect(
            html.contains("x-bind:aria-selected=\"selectedTab === 'first'\"")
        )
        #expect(html.contains("x-on:keydown.home.prevent=\"firstTab()\""))
        #expect(html.contains("x-on:keydown.end.prevent=\"lastTab()\""))
        #expect(
            html.contains(
                orientation == .horizontal
                    ? "x-on:keydown.right.prevent=\"nextTab()\""
                    : "x-on:keydown.down.prevent=\"nextTab()\""
            )
        )
    }

    @Test(
        "Underline renders accessible bottom indicator, hover, and focus",
        arguments: [
            TabOrientation.horizontal, .vertical,
        ]
    )
    func rendersUnderlineVariant(orientation: TabOrientation) {
        let html = renderHTML(
            TabGroup(
                TabGroupData(
                    tabs: [
                        TabItemData(
                            id: "first",
                            label: "First",
                            content: .html("<p>One</p>")
                        ),
                        TabItemData(
                            id: "disabled",
                            label: "Disabled",
                            content: .html("<p>Two</p>"),
                            state: .disabled
                        ),
                    ],
                    variant: .underline,
                    orientation: orientation
                )
            )
            .render()
        )

        let listStyle =
            orientation == .horizontal
            ? TabGroupStyles.tabListHorizontalUnderline
            : TabGroupStyles.tabListVertical
        #expect(html.contains("class=\"\(listStyle)\""))
        #expect(html.contains(TabGroupStyles.tabUnderlineButtonBase))
        #expect(html.contains(TabGroupStyles.tabUnderlineActive))
        #expect(html.contains(TabGroupStyles.tabUnderlineInactive))
        #expect(html.contains("enabled:hover:bg-on-surface/5"))
        #expect(html.contains("focus-visible:outline-focusring"))
        #expect(html.contains("border-b-on-theme"))
        #expect(html.contains("cursor-not-allowed"))
        #expect(!html.contains("pointer-events-none"))
    }

    @Test(
        "Renders tablist and tab buttons with accessible roles and attributes"
    )
    func rendersRolesAndAccessibility() async throws {

        let html = renderHTML(
            TabGroup(
                TabGroupData(
                    ariaLabel: "Sample Tabs",
                    tabs: [
                        TabItemData(
                            id: "tab1",
                            label: "First",
                            content: .html("<p>One</p>")
                        ),
                        TabItemData(
                            id: "tab2",
                            label: "Second",
                            content: .html("<p>Two</p>")
                        ),
                    ]
                )
            )
            .render()
        )

        #expect(html.contains("role=\"tablist\""))
        #expect(html.contains("aria-label=\"Sample Tabs\""))
        #expect(html.contains("aria-orientation=\"horizontal\""))
        #expect(html.contains("role=\"tab\""))
        #expect(html.contains("id=\"tab-tab1\""))
        #expect(html.contains("aria-controls=\"tabpanel-tab1\""))
        #expect(html.contains("role=\"tabpanel\""))
        #expect(html.contains("id=\"tabpanel-tab1\""))
        #expect(html.contains("aria-labelledby=\"tab-tab1\""))
        #expect(!html.contains("tabpanel-tab1\" tabindex"))
        #expect(html.contains("x-data=\"tabGroup({ initialTab: 'tab1'"))
    }

    @Test("Respects explicit defaultSelectedTabId and isDefaultSelected flag")
    func respectsDefaultSelection() async throws {

        // Test flag isDefaultSelected
        let htmlFlag = renderHTML(
            TabGroup(
                TabGroupData(
                    tabs: [
                        TabItemData(
                            id: "tab1",
                            label: "First",
                            content: .html("<p>One</p>")
                        ),
                        TabItemData(
                            id: "tab2",
                            label: "Second",
                            content: .html("<p>Two</p>"),
                            isDefaultSelected: true
                        ),
                    ]
                )
            )
            .render()
        )
        #expect(htmlFlag.contains("initialTab: 'tab2'"))

        // Test explicit defaultSelectedTabId override
        let htmlExplicit = renderHTML(
            TabGroup(
                TabGroupData(
                    tabs: [
                        TabItemData(
                            id: "tab1",
                            label: "First",
                            content: .html("<p>One</p>"),
                            isDefaultSelected: true
                        ),
                        TabItemData(
                            id: "tab2",
                            label: "Second",
                            content: .html("<p>Two</p>")
                        ),
                    ],
                    defaultSelectedTabId: "tab2"
                )
            )
            .render()
        )
        #expect(htmlExplicit.contains("initialTab: 'tab2'"))
    }

    @Test("Renders icons and badges correctly")
    func rendersIconsAndBadges() async throws {

        let html = renderHTML(
            TabGroup(
                TabGroupData(
                    tabs: [
                        TabItemData(
                            id: "groups",
                            label: "Groups",
                            content: .html("<p>Groups</p>"),
                            icon: .people,
                            iconPosition: .left,
                            badgeCount: 12
                        ),
                        TabItemData(
                            id: "messages",
                            label: "Messages",
                            content: .html("<p>Messages</p>"),
                            icon: .envelope,
                            iconPosition: .right,
                            badgeText: "New"
                        ),
                    ]
                )
            )
            .render()
        )

        #expect(html.contains("12"))
        #expect(html.contains("New"))
        #expect(html.contains("<svg"))
        #expect(html.contains("Groups"))
        #expect(html.contains("Messages"))
    }

    @Test("Renders markdown, HTML, and element builder panel content")
    func rendersPanelContent() async throws {

        let html = renderHTML(
            TabGroup(
                TabGroupData(
                    tabs: [
                        TabItemData(
                            id: "md",
                            label: "MD",
                            content: .markdown("**Markdown Text**")
                        ),
                        TabItemData(
                            id: "raw",
                            label: "RAW",
                            content: .html("<em>Raw HTML</em>")
                        ),
                        TabItemData(id: "elem", label: "Elem") {
                            Div { Span("Custom Element") }
                        },
                    ]
                )
            )
            .render()
        )

        #expect(
            html.contains("<strong>Markdown Text</strong>")
                || html.contains("<b>Markdown Text</b>")
                || html.contains("Markdown Text")
        )
        #expect(html.contains("<em>Raw HTML</em>"))
        #expect(html.contains("Custom Element"))
    }

    @Test("Applies disabled attributes to disabled tab items")
    func rendersDisabledTabs() async throws {

        let html = renderHTML(
            TabGroup(
                TabGroupData(
                    tabs: [
                        TabItemData(
                            id: "enabled",
                            label: "Enabled",
                            content: .html("<p>Active</p>")
                        ),
                        TabItemData(
                            id: "disabled",
                            label: "Disabled",
                            content: .html("<p>Inactive</p>"),
                            state: .disabled
                        ),
                    ]
                )
            )
            .render()
        )

        #expect(html.contains("disabled"))
        #expect(html.contains("aria-disabled=\"true\""))
        #expect(html.contains("cursor-not-allowed"))
        #expect(!html.contains("pointer-events-none"))
    }

    @Test("Renders vertical layout correctly")
    func rendersVerticalLayout() async throws {

        let html = renderHTML(
            TabGroup(
                TabGroupData(
                    tabs: [
                        TabItemData(
                            id: "v1",
                            label: "Tab 1",
                            content: .html("<p>1</p>")
                        )
                    ],
                    variant: .underline,
                    orientation: .vertical,
                    hasBorder: true
                )
            )
            .render()
        )

        #expect(html.contains("aria-orientation=\"vertical\""))
        #expect(html.contains("flex-row"))
        #expect(html.contains("border rounded-md"))
    }

    @Test("Includes Matomo tracking attributes when enabled")
    func rendersMatomoTracking() async throws {

        let html = renderHTML(
            TabGroup(
                TabGroupData(
                    tabs: [
                        TabItemData(
                            id: "tab1",
                            label: "Stats",
                            content: .html("<p>Data</p>")
                        )
                    ],
                    matomoStatus: .ACCEPTED
                )
            )
            .render()
        )

        #expect(html.contains("data-track-content"))
        #expect(html.contains("data-content-name=\"tabgroup\""))
        #expect(html.contains("data-content-piece=\"tab.button\""))
        #expect(html.contains("data-content-target=\"Stats\""))
    }
}
