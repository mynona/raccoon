import HTML
import SGML
import SVG
import WebBuilders

/// An accessible tab group component conforming to WAI-ARIA authoring practices.
public struct TabGroup: TemplateRepresentable {
    let data: TabGroupData
    typealias styles = TabGroupStyles

    /// Initializes a new `TabGroup` with the specified configuration data.
    ///
    /// - Parameter data: Configuration data defining the tabs, styles, and options.
    public init(_ data: TabGroupData) {
        self.data = data
    }

    /// Computes the initial selected tab identifier.
    private var resolvedDefaultTabId: String {
        if let explicit = data.defaultSelectedTabId, !explicit.isEmpty {
            return explicit
        }
        if let defaultItem = data.tabs.first(where: {
            $0.isDefaultSelected && $0.state == .enabled
        }) {
            return defaultItem.id
        }
        return data.tabs.first(where: { $0.state == .enabled })?.id ?? ""
    }

    @Builder<Element>
    func renderBadge(for tab: TabItemData) -> [Element] {
        let tabLit = JavaScriptEscaper.alpineStringLiteral(tab.id)
        let dynamicClass =
            "selectedTab === \(tabLit) ? '\(styles.pillActive)' : '\(styles.pillInactive)'"

        if let pill = tab.pill {
            Pill(
                PillData(
                    id: pill.id,
                    bindId: pill.bindId,
                    bindClass: pill.bindClass ?? dynamicClass,
                    text: pill.text,
                    ariaLabel: pill.ariaLabel,
                    count: pill.count,
                    variant: pill.variant,
                    size: pill.size,
                    matomoStatus: pill.matomoStatus,
                    contentTracker: pill.contentTracker
                )
            )
            .render()
        }
        else if let count = tab.badgeCount {
            Pill(
                PillData(
                    bindClass: dynamicClass,
                    count: count
                )
            )
            .render()
        }
        else if let badgeText = tab.badgeText, !badgeText.isEmpty {
            Pill(
                PillData(
                    bindClass: dynamicClass,
                    text: badgeText
                )
            )
            .render()
        }
    }

    @Builder<Element>
    func renderTabButton(_ tab: TabItemData) -> [Element] {
        let tabId = "tab-\(tab.id)"
        let panelId = "tabpanel-\(tab.id)"
        let tabLit = JavaScriptEscaper.alpineStringLiteral(tab.id)
        let isDisabled = tab.state != .enabled

        let activeClass: String = {
            switch data.variant {
            case .underline:
                return styles.tabUnderlineActive
            case .pills:
                return styles.tabPillsActive
            }
        }()

        let inactiveClass: String = {
            switch data.variant {
            case .underline:
                return styles.tabUnderlineInactive
            case .pills:
                return styles.tabPillsInactive
            }
        }()

        Button {
            if let icon = tab.icon, tab.iconPosition == .left {
                Svg.icon(icon, width: 18, height: 18)
            }

            Span(tab.label)

            if let icon = tab.icon, tab.iconPosition == .right {
                Svg.icon(icon, width: 18, height: 18)
            }

            renderBadge(for: tab)
        }
        .type(.button)
        .id(tabId)
        .setAttribute(name: "role", value: "tab")
        .setAttribute(name: "aria-controls", value: panelId)
        .if(tab.ariaLabel != nil) {
            $0.setAttribute(name: "aria-label", value: tab.ariaLabel!)
        }
        .if(isDisabled) {
            $0
                .disabled()
                .setAttribute(name: "aria-disabled", value: "true")
                .addClass(styles.tabDisabled)
                .addClass(
                    data.variant == .pills
                        ? styles.tabPillsDisabled : styles.tabUnderlineDisabled
                )
        } else: {
            $0
                .setAttribute(name: "x-on:click", value: "selectTab(\(tabLit))")
                .setAttribute(
                    name: "x-bind:aria-selected",
                    value: "selectedTab === \(tabLit)"
                )
                .setAttribute(
                    name: "x-bind:tabindex",
                    value: "selectedTab === \(tabLit) ? '0' : '-1'"
                )
                .setAttribute(
                    name: "x-bind:class",
                    value:
                        "selectedTab === \(tabLit) ? '\(activeClass)' : '\(inactiveClass)'"
                )
                .addClass(
                    data.variant == .pills
                        ? styles.tabPillsButtonBase
                        : styles.tabUnderlineButtonBase
                )
        }
        // Matomo Content Tracking
        .if(
            tab.matomoStatus == .ACCEPTED
                || tab.matomoStatus == .BANNER
                || data.matomoStatus == .ACCEPTED
                || data.matomoStatus == .BANNER
        ) {
            $0
                .flagAttribute("data-track-content")
                .setAttribute(name: "data-content-name", value: "tabgroup")
                .setAttribute(name: "data-content-piece", value: "tab.button")
                .setAttribute(name: "data-content-target", value: tab.label)
        }
    }

    @Builder<Element>
    func renderTabList() -> [Element] {
        let isVertical = data.orientation == .vertical
        let listClasses: String = {
            if isVertical {
                return data.variant == .pills
                    ? styles.tabListVerticalPills : styles.tabListVertical
            }
            switch data.variant {
            case .underline:
                return styles.tabListHorizontalUnderline
            case .pills:
                return styles.tabListHorizontalPills
            }
        }()

        Div {
            for tab in data.tabs {
                renderTabButton(tab)
            }
        }
        .setAttribute(name: "role", value: "tablist")
        .setAttribute(name: "aria-label", value: data.ariaLabel)
        .setAttribute(
            name: "aria-orientation",
            value: isVertical ? "vertical" : "horizontal"
        )
        .if(isVertical) {
            $0
                .setAttribute(
                    name: "x-on:keydown.down.prevent",
                    value: "nextTab()"
                )
                .setAttribute(
                    name: "x-on:keydown.up.prevent",
                    value: "previousTab()"
                )
        } else: {
            $0
                .setAttribute(
                    name: "x-on:keydown.right.prevent",
                    value: "nextTab()"
                )
                .setAttribute(
                    name: "x-on:keydown.left.prevent",
                    value: "previousTab()"
                )
        }
        .setAttribute(name: "x-on:keydown.home.prevent", value: "firstTab()")
        .setAttribute(name: "x-on:keydown.end.prevent", value: "lastTab()")
        .class(listClasses)
    }

    @Builder<Element>
    func renderPanelContent(_ content: TabContent) -> [Element] {
        switch content {
        case .html(let html):
            Div { InlineText(html, isRaw: true) }
        case .markdown(let markdown):
            Div { InlineText(renderMarkdownAsHTML(markdown), isRaw: true) }
                .addClass(styles.panelProse)
        case .element(let elements):
            elements
        }
    }

    @Builder<Element>
    func renderPanels() -> [Element] {
        Div {
            for tab in data.tabs {
                let tabId = "tab-\(tab.id)"
                let panelId = "tabpanel-\(tab.id)"
                let tabLit = JavaScriptEscaper.alpineStringLiteral(tab.id)

                Div {
                    renderPanelContent(tab.content)
                }
                .id(panelId)
                .setAttribute(name: "role", value: "tabpanel")
                .setAttribute(name: "aria-labelledby", value: tabId)
                .setAttribute(
                    name: "x-show",
                    value: "selectedTab === \(tabLit)"
                )
                .flagAttribute("x-cloak")
                .addClass(styles.panelContainer)
            }
        }
        .class("flex-1")
    }

    @Builder<Element>
    public func render() -> [Element] {
        DebugComment("TabGroup: \(data.ariaLabel)")

        Script()
            .src("/js/tab-group.js")
            .setAttribute(name: "type", value: "text/javascript")

        let componentId = data.id ?? StableIdentifier.unique(data.ariaLabel)
        let defaultTabLit = JavaScriptEscaper.alpineStringLiteral(
            resolvedDefaultTabId
        )
        let tabIdsArray = data.tabs.filter { $0.state == .enabled }
            .map { $0.id }
        let tabIdsJson = JavaScriptEscaper.htmlAttributeEscape(
            JavaScriptEscaper.jsonEncode(tabIdsArray, fallback: "[]")
        )

        let alpineInit: String = {
            guard let customBinding = data.bindSelectedTab,
                !customBinding.isEmpty
            else {
                return
                    "tabGroup({ initialTab: \(defaultTabLit), tabIds: \(tabIdsJson) })"
            }
            return "{ selectedTab: \(customBinding), tabIds: \(tabIdsJson) }"
        }()

        Div {
            renderTabList()
            renderPanels()
        }
        .id(componentId)
        .setAttribute(name: "x-data", value: alpineInit)
        .if(data.orientation == .vertical) {
            $0.class("flex flex-row gap-6 w-full")
        } else: {
            $0.class("flex flex-col gap-2 w-full")
        }
        .if(data.hasBorder) {
            $0.addClass(styles.groupBorder)
        }
    }
}
