import HTML
import Raccoon
import SGML
import SVG
import WebBuilders

public struct Basic: TemplateRepresentable {
    typealias styles = BasicStyles

    let title: String?
    let contentPadding: Bool
    let TEMPLATE_MAIN: [Element]

    public init(
        title: String? = nil,
        contentPadding: Bool = true,
        @Builder<Element> _ builder: () -> [Element]
    ) {
        self.title = title
        self.contentPadding = contentPadding
        self.TEMPLATE_MAIN = builder()
    }

    public init(
        contentPadding: Bool = true,
        @Builder<Element> _ builder: () -> [Element]
    ) {
        self.title = nil
        self.contentPadding = contentPadding
        self.TEMPLATE_MAIN = builder()
    }

    private func computeTitle() -> String {
        if let title = self.title, !title.isEmpty {
            return Self.pageTitle(title)
        }
        let currentPath = normalizedPath(PreviewRequest.path)
        for group in PreviewNavigation.groups {
            for section in group.sections {
                if let item = section.items.first(where: {
                    $0.url == currentPath
                }) {
                    return Self.pageTitle(item.title)
                }
            }
        }
        if currentPath == "/" || currentPath == "/preview" {
            return PreviewTexts.homeTitle
                .with(variables: ["name": PreviewTexts.productName]).resolved
        }
        return PreviewTexts.preview.resolved
    }

    /// "Preview – <name>": the name is fixed, the word around it follows the page language.
    private static func pageTitle(_ name: String) -> String {
        PreviewTexts.pageTitle.with(variables: ["title": name]).resolved
    }

    private func normalizedPath(_ path: String) -> String {
        if path.count > 1 && path.hasSuffix("/") {
            return String(path.dropLast())
        }
        return path
    }

    @Builder<Element>
    private func renderHeader() -> [Element] {
        HTML.Header {
            Div {
                Div {
                    Div {
                        // Left controls: hamburger button, dark/light toggle, theme switcher
                        Div {
                            // Hamburger menu button (hidden on lg+)
                            Button {
                                Svg.icon(
                                    .list,
                                    width: 20,
                                    height: 20
                                )
                            }
                            .setAttribute(
                                name: "@click",
                                value:
                                    "showNavigation = !showNavigation; drawerOpen = true;"
                            )
                            .setAttribute(
                                name: ":aria-expanded",
                                value: "showNavigation"
                            )
                            .setAttribute(
                                name: "aria-controls",
                                value: "burger-menu"
                            )
                            .localized(.ariaLabel, PreviewTexts.openMainMenu)
                            .class(styles.burgerButton)

                            // Dark-Light-Mode
                            DarkLightModeToggle(
                                DarkLightModeToggleData(
                                    matomoStatus: .DEACTIVATED
                                )
                            )
                            .render()

                            // Theme Switcher
                            ThemeSwitcher(
                                ThemeSwitcherData(
                                    align: .left,
                                    matomoStatus: .DEACTIVATED
                                )
                            )
                            .render()
                        }
                        .class(styles.topBarControls)

                        // Right controls: Language Switcher
                        Div {
                            LanguageSwitcher(
                                LanguageSwitcherData(
                                    languages: LanguageOption.builtIn,
                                    fallbackLanguage: PreviewRequest.lang
                                )
                            )
                            .render()
                        }
                        .class(styles.topBarRight)
                    }
                    .class(styles.headerRow)
                }
                .class(styles.headerContent)
            }
            .class(styles.headerContainer)

            // Drawers container
            Div {
                showMobileDrawer()
                showDesktopSidebar()
            }
            .class("relative")
        }
        .setAttribute(name: "role", value: "banner")
        .class(styles.banner)
        .id("page-header")
    }

    @Builder<Element>
    private func showMobileDrawer() -> [Element] {
        Nav {
            Div {
                Div {
                    Div {
                        // Sticky close button
                        Div {
                            Button {
                                Svg.icon(
                                    .x_lg,
                                    width: 20,
                                    height: 20
                                )
                            }
                            .setAttribute(
                                name: "@click",
                                value:
                                    "showNavigation = false; drawerOpen = false"
                            )
                            .setAttribute(
                                name: ":aria-expanded",
                                value: "showNavigation"
                            )
                            .setAttribute(
                                name: "aria-controls",
                                value: "burger-menu"
                            )
                            .localized(.ariaLabel, PreviewTexts.closeNavigation)
                            .class(styles.closeButton)
                        }
                        .class(styles.stickyCloseButtonWrapper)

                        Div {
                            showSidebarContent(isMobile: true)
                        }
                        .class(styles.sidebarBodyContent)
                    }
                    .class(styles.mobileContentWrapper)
                }
                .class(styles.mobileScrollArea)
            }
            .id("drawer-menu")
            .setAttribute(name: "role", value: "dialog")
            .setAttribute(
                name: "@keydown.escape.window",
                value: "showNavigation = false; drawerOpen = false"
            )
            .class(styles.mobileDialog)
        }
        .id("burger-menu")
        .setAttribute(name: ":hidden", value: "!showNavigation")
        .flagAttribute("x-cloak")
        .setAttribute(name: "x-trap.noscroll", value: "drawerOpen")
        .localized(.ariaLabel, PreviewTexts.mainNavigation)
        .class(styles.mobileContainer)
        .setAttribute(
            name: "@resize.window.debounce",
            value:
                "if (window.innerWidth >= 1024) { showNavigation = false; drawerOpen = false; }"
        )
    }

    @Builder<Element>
    private func showDesktopSidebar() -> [Element] {
        Div {
            Div {
                Div {
                    showSidebarContent(isMobile: false)
                }
                .class(styles.sidebarBodyContent)
            }
            .class(styles.desktopSidebarContent)
        }
        .class(styles.desktopSidebar)
    }

    @Builder<Element>
    private func showSidebarContent(isMobile: Bool) -> [Element] {
        let currentPath = normalizedPath(PreviewRequest.path)

        // Search filter field
        Div {
            SearchField(
                SearchFieldData(
                    name: isMobile ? "mobileSearchInput" : "sidebarSearchInput",
                    bindModel: "search",
                    bindRef: isMobile ? "mobileSearchInput" : "searchInput",
                    placeholder: PreviewTexts.filterPlaceholder,
                    ariaLabel: PreviewTexts.filterLabel,
                    size: .sm
                )
            )
            .render()
        }
        .class("pb-4 shrink-0")

        // Navigation
        Nav {
            for group in PreviewNavigation.groups {
                if PreviewNavigation.groups.count > 1 {
                    H2(group.name)
                        .class(styles.groupTitle)
                }

                for section in group.sections {
                    let itemTitles = section.items.map { "'\($0.title.lowercased())'" }.joined(separator: ", ")

                    Div {
                        if let title = section.title {
                            if PreviewNavigation.groups.count > 1 {
                                H3(title.resolved)
                                    .localized(title)
                                    .class(styles.subGroupTitle)
                            } else {
                                H2(title.resolved)
                                    .localized(title)
                                    .class(styles.subGroupTitle)
                            }
                        }

                        Ul {
                            for item in section.items {
                                let option = SimpleMenuOption(
                                    id: item.url,
                                    // Component names are fixed terms
                                    title: LocalizedText(
                                        verbatim: item.title
                                    ),
                                    isSelected: item.url == currentPath,
                                    href: item.url,
                                    icon: item.isOpenInNewTab
                                        ? .arrow_up_right_square : nil,
                                    role: nil
                                )

                                Li {
                                    showSidebarOption(
                                        option,
                                        isOpenInNewTab: item
                                            .isOpenInNewTab
                                    )
                                }
                                .setAttribute(
                                    name: "x-show",
                                    value:
                                        "!search || '\(item.title.lowercased())'.includes(search.toLowerCase().trim())"
                                )
                            }
                        }
                        .class(styles.navList)
                    }
                    .class(styles.navSection)
                    .setAttribute(
                        name: "x-show",
                        value:
                            "!search || [\(itemTitles)].some(t => t.includes(search.toLowerCase().trim()))"
                    )
                }
            }
        }
        .localized(.ariaLabel, PreviewTexts.mainNavigation)
        .class(styles.sidebarNav)
        .if(isMobile) {
            $0.setAttribute(
                name: "@click",
                value: "if ($event.target.closest('a')) { showNavigation = false; drawerOpen = false; }"
            )
        }
    }

    @Builder<Element>
    private func showSidebarOption(
        _ option: SimpleMenuOption,
        isOpenInNewTab: Bool
    ) -> [Element] {
        if let href = option.href {
            A {
                Span(option.title.english)

                Span {
                    if isOpenInNewTab {
                        Span {
                            Svg.icon(
                                .arrow_up_right_square,
                                width: 16,
                                height: 16
                            )
                        }
                        .class("pr-2 flex items-center")
                    }
                    if option.isSelected {
                        Svg.icon(.check_lg, width: 16, height: 16)
                            .class(styles.activeIcon)
                    }
                }
                .class("flex items-center")
            }
            .href(href)
            .class(
                option.isSelected
                    ? styles.navItemActive
                    : styles.navItem
            )
            .if(option.isSelected) {
                $0.setAttribute(
                    name: "aria-current",
                    value: "page"
                )
            }
            .if(isOpenInNewTab) {
                $0.target(.blank)
                    .setAttribute(
                        name: "rel",
                        value: "noopener noreferrer"
                    )
            }
        }
    }

    @Builder<Element>
    public func render() -> [Element] {
        Html {
            Head {
                Meta().charset("utf-8")
                Meta().name(.viewport)
                    .content("width=device-width, initial-scale=1")
                Title(computeTitle())
                Link(rel: .shortcutIcon).href("/images/favicon.ico")
                    .type("image/x-icon")
                Link(rel: .icon).href("/images/favicon.ico")
                    .type("image/x-icon")
                Link(rel: .stylesheet).href("/css/ibm-plex.css")
                Link(rel: .stylesheet).href("/css/raccoon-min.css")
                Script(DarkLightModeToggle.detectModeScript)
                    .setAttribute(name: "type", value: "text/javascript")
                Script(ThemeSwitcher.detectThemeScript)
                    .setAttribute(name: "type", value: "text/javascript")
            }

            Body {
                Style(
                    """
                    [x-cloak] { display: none !important; }
                    @media (min-width: 1024px) {
                        .topbar-sidebar-padding {
                            padding-left: 2.5rem;
                        }
                    }
                    """
                )

                // Skip link (from Raccoon)
                SkipLink().render()

                // Top bar header with controls, drawer, and desktop sidebar
                renderHeader()

                // Main CMS / Preview Workspace
                Main {
                    if contentPadding {
                        Div {
                            TEMPLATE_MAIN
                        }
                        .class(styles.contentContainer)
                    } else {
                        TEMPLATE_MAIN
                    }
                }
                .id("main")
                .setAttribute(name: "role", value: "main")
                .class(contentPadding ? styles.main : styles.mainNoPadding)

                // Alpine bundle
                I18n.scripts()
                Script().src("/js/bundle-min.js")
                // Preview only: a language switch is remembered in a cookie and the page is rendered again,
                // because demo content (HTML, markdown) can only be translated on the server
                Script(
                    "(function(){var first=document.documentElement.lang;new MutationObserver(function(){var l=document.documentElement.lang;if(l===first)return;document.cookie='preview-lang='+l+'; path=/; max-age=31536000';var u=new URL(location.href);u.searchParams.delete('lang');location.replace(u.toString())}).observe(document.documentElement,{attributes:true,attributeFilter:['lang']})})();"
                )
            }
            .setAttribute(
                name: "x-data",
                value: """
                    {
                    showNavigation: false,
                    drawerOpen: false,
                    search: '',
                    init() {
                        const mq = window.matchMedia('(min-width: 1024px)');
                        mq.addEventListener('change', (e) => {
                            if (e.matches) {
                                this.showNavigation = false;
                                this.drawerOpen = false;
                            }
                        });
                    }
                    }
                    """
            )
            .class(styles.body)
        }
        .lang(PreviewRequest.lang)
        .class(styles.html)
    }
}

public typealias TemplateBasic = Basic
