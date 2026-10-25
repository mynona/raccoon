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
            return "Preview – \(title)"
        }
        let currentPath = normalizedPath(PreviewRequest.path)
        for group in PreviewNavigation.groups {
            for section in group.sections {
                if let item = section.items.first(where: {
                    $0.url == currentPath
                }) {
                    return "Preview – \(item.title)"
                }
            }
        }
        if currentPath == "/" || currentPath == "/preview" {
            return "Raccoon Component Preview"
        }
        return "Preview"
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
            // Header: Title + DarkLightModeToggle & ThemeSwitcher
            Div {
                A("Raccoon")
                    .href("/")
                    .class(styles.sidebarTitle)

                Div {
                    DarkLightModeToggle(
                        DarkLightModeToggleData(matomoStatus: .DEACTIVATED)
                    )
                    .render()

                    ThemeSwitcher(
                        ThemeSwitcherData(
                            align: .right,
                            matomoStatus: .DEACTIVATED
                        )
                    )
                    .render()
                }
                .class(styles.sidebarControls)
            }
            .class(styles.sidebarHeader)

            // Search filter field
            Div {
                SearchField(
                    SearchFieldData(
                        name: "sidebarSearchInput",
                        bindModel: "search",
                        bindRef: "searchInput",
                        placeholder: "Filter components...",
                        ariaLabel: "Filter components",
                        size: .sm
                    )
                )
                .render()
            }
            .class("px-4 pt-3 pb-2 shrink-0")

            // Navigation groups
            Nav {
                for group in PreviewNavigation.groups {
                    Div {
                        H2(group.name)
                            .class(styles.groupTitle)

                        for section in group.sections {
                            Div {
                                if let sectionTitle = section.title {
                                    H3(sectionTitle)
                                        .class(styles.subGroupTitle)
                                }

                                Ul {
                                    for item in section.items {
                                        let option = SimpleMenuOption(
                                            id: item.url,
                                            title: item.title,
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
                                        }.class("py-2")
                                    }
                                }
                                .class(styles.navList)
                            }
                            .class(styles.navSection)
                        }
                    }
                }
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
                Span(option.title)

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
            .setAttribute(
                name: "x-show",
                value:
                    "!search || '\(option.title.lowercased())'.includes(search.toLowerCase())"
            )
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
                Script().src("/js/bundle-min.js")
            }
            .class(styles.body)
        }
        .lang("en")
        .class(styles.html)
    }
}

public typealias TemplateBasic = Basic
