import HTML
import Raccoon
import SGML
import SVG
import WebBuilders

public struct Basic: TemplateRepresentable {
    typealias styles = BasicStyles

    let title: String?
    let TEMPLATE_MAIN: [Element]

    public init(
        title: String? = nil,
        @Builder<Element> _ builder: () -> [Element]
    ) {
        self.title = title
        self.TEMPLATE_MAIN = builder()
    }

    public init(
        @Builder<Element> _ builder: () -> [Element]
    ) {
        self.title = nil
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
    private func renderSidebar() -> [Element] {
        let currentPath = normalizedPath(PreviewRequest.path)

        Aside {
            // Header: DarkLightModeToggle & ThemeSwitcher on left, LanguageSwitcher on right
            Div {
                Div {
                    DarkLightModeToggle(
                        DarkLightModeToggleData(matomoStatus: .DEACTIVATED)
                    )
                    .render()

                    ThemeSwitcher(
                        ThemeSwitcherData(
                            align: .left,
                            matomoStatus: .DEACTIVATED
                        )
                    )
                    .render()
                }
                .class(styles.sidebarControls)

                LanguageSwitcher(
                    LanguageSwitcherData(
                        languages: LanguageOption.builtIn,
                        fallbackLanguage: PreviewRequest.lang
                    )
                )
                .render()
            }
            .class(styles.sidebarHeader)

            // Search filter field
            Div {
                SearchField(
                    SearchFieldData(
                        name: "sidebarSearchInput",
                        bindModel: "search",
                        bindRef: "searchInput",
                        placeholder: PreviewTexts.filterPlaceholder,
                        ariaLabel: PreviewTexts.filterLabel,
                        size: .sm
                    )
                )
                .render()
            }
            .class("px-4 pt-3 pb-2 shrink-0")

            // Navigation
            Nav {
                Ul {
                    for group in PreviewNavigation.groups {
                        for section in group.sections {
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
                    }
                }
                .class(styles.navList)
            }
            .ariaLabel("Component preview navigation")
            .class(styles.sidebarNav)
        }
        .class(styles.sidebar)
        .style("width: 17rem; min-width: 17rem;")
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
                Style("[x-cloak] { display: none !important; }")

                // Skip link (from Raccoon)
                SkipLink().render()

                // Main layout: Sidebar on left + Main Content on right
                Div {
                    renderSidebar()

                    Main {
                        Div {
                            TEMPLATE_MAIN
                        }
                        .class(styles.contentContainer)
                    }
                    .id("main")
                    .setAttribute(name: "role", value: "main")
                    .class(styles.main)
                }
                .class(styles.layout)
                .setAttribute(name: "x-data", value: "{ search: '' }")

                // Alpine bundle
                I18n.scripts()
                Script().src("/js/bundle-min.js")
                // Preview only: a language switch is remembered in a cookie and the page is rendered again,
                // because demo content (HTML, markdown) can only be translated on the server
                Script(
                    "(function(){var first=document.documentElement.lang;new MutationObserver(function(){var l=document.documentElement.lang;if(l===first)return;document.cookie='preview-lang='+l+'; path=/; max-age=31536000';var u=new URL(location.href);u.searchParams.delete('lang');location.replace(u.toString())}).observe(document.documentElement,{attributes:true,attributeFilter:['lang']})})();"
                )
            }
            .class(styles.body)
        }
        .lang(PreviewRequest.lang)
        .class(styles.html)
    }
}

public typealias TemplateBasic = Basic
