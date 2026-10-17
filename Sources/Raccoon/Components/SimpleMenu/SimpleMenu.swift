import HTML
import SGML
import SVG
import WebBuilders

/// Standardized simple menu component following ThemeSwitcher interaction standards.
///
/// Supports both:
/// 1. `.link` (SSR): Options render as standard `<a href="...">` anchor tags with pre-rendered active checkmarks.
/// 2. `.alpine` (Client-side): Options render as interactive `<button>` elements with `@click` handlers and dynamic checkmarks.
public struct SimpleMenu: TemplateRepresentable {

    let data: SimpleMenuData
    typealias styles = SimpleMenuStyles

    /// Creates a new `SimpleMenu` instance.
    ///
    /// - Parameter data: Configuration data model for the simple menu.
    public init(_ data: SimpleMenuData) {
        self.data = data
    }

    @Builder<Element>
    private func showTriggerContent() -> [Element] {
        if let icon = data.triggerIcon {
            Svg.icon(icon, width: 16, height: 16)
        }
        if let bindTriggerText = data.bindTriggerText {
            Span("")
                .setAttribute(name: "x-text", value: bindTriggerText)
        }
        else if !data.triggerText.isEmpty {
            Span(data.triggerText)
        }
        if data.hasTriggerChevron {
            Svg.icon(.chevron_down, width: 14, height: 14)
        }
    }

    private var triggerClass: String {
        if let custom = data.triggerClass {
            return custom
        }
        if data.triggerIcon != nil && data.triggerText.isEmpty
            && data.bindTriggerText == nil
        {
            return styles.iconButton
        }
        return styles.triggerButton
    }

    @Builder<Element>
    private func showOptionItem(_ option: SimpleMenuOption) -> [Element] {
        let role = option.role ?? "menuitem"
        if let href = option.href {
            // SSR Link mode
            A {
                Span(option.title)
                if option.isSelected {
                    Svg.icon(.check_lg, width: 16, height: 16)
                        .class(styles.activeIcon)
                }
            }
            .href(href)
            .setAttribute(name: "role", value: role)
            .if(option.isSelected) {
                $0.setAttribute(name: "aria-checked", value: "true")
            }
            .class(styles.menuItem)
        }
        else {
            // Alpine / client mode
            Button {
                Span(option.title)
                if let bindSelected = option.bindSelected {
                    Svg.icon(.check_lg, width: 16, height: 16)
                        .setAttribute(name: "x-show", value: bindSelected)
                        .flagAttribute("x-cloak")
                        .class(styles.activeIcon)
                }
                else if option.isSelected {
                    Svg.icon(.check_lg, width: 16, height: 16)
                        .class(styles.activeIcon)
                }
            }
            .type(.button)
            .setAttribute(name: "role", value: role)
            .if(option.bindAriaChecked != nil) {
                guard let check = option.bindAriaChecked else { return $0 }
                return $0.setAttribute(name: ":aria-checked", value: check)
            }
            .if(option.clickAction != nil) {
                guard let action = option.clickAction else { return $0 }
                return $0.setAttribute(name: "@click", value: action)
            }
            .class(styles.menuItem)
        }
    }

    @Builder<Element>
    public func render() -> [Element] {
        Script()
            .src("/js/simple-menu.js")
            .setAttribute(name: "type", value: "text/javascript")

        let toggleAction = data.onToggle ?? "toggle()"
        let closeAction = data.onClose ?? "close($refs.button)"
        let alpineData = data.bindAlpineData ?? "simpleMenu()"

        Div {
            // Trigger Button
            Button {
                showTriggerContent()
            }
            .type(.button)
            .if(data.id != nil) {
                guard let id = data.id else { return $0 }
                return $0.id(id)
            }
            .ariaLabel(data.triggerAriaLabel ?? data.ariaLabel)
            .setAttribute(name: "x-ref", value: "button")
            .setAttribute(name: "@click", value: toggleAction)
            .setAttribute(
                name: "@keydown.down.prevent.stop",
                value: "openMenu(0)"
            )
            .setAttribute(
                name: "@keydown.up.prevent.stop",
                value: "openMenu(-1)"
            )
            .setAttribute(name: ":aria-expanded", value: data.bindOpen)
            .setAttribute(
                name: ":aria-controls",
                value: "$id('\(data.alpineId)')"
            )
            .class(triggerClass)
            .if(data.matomoStatus == .ACCEPTED || data.matomoStatus == .BANNER)
            {
                if let tracker = data.contentTracker {
                    return
                        $0
                        .flagAttribute("data-track-content")
                        .setAttribute(
                            name: "data-content-name",
                            value: tracker.name
                        )
                        .setAttribute(
                            name: "data-content-piece",
                            value: tracker.piece
                        )
                        .setAttribute(
                            name: "data-content-target",
                            value: tracker.target
                        )
                }
                return $0
            }

            // Dropdown panel
            Div {
                Ul {
                    for option in data.options {
                        Li {
                            showOptionItem(option)
                        }
                        .setAttribute(name: "role", value: "none")
                        .class("py-2")
                    }
                }
                .setAttribute(name: "role", value: "menu")
                .class(styles.menuList)
            }
            .setAttribute(name: "x-ref", value: "panel")
            .setAttribute(name: "x-show", value: data.bindOpen)
            .flagAttribute(
                data.align == .right
                    ? "x-transition.origin.top.right"
                    : "x-transition.origin.top.left"
            )
            .setAttribute(name: "@click.outside", value: closeAction)
            .setAttribute(name: ":id", value: "$id('\(data.alpineId)')")
            .style("display: none;")
            .flagAttribute("x-cloak")
            .class(styles.dropdownPanel(width: data.width, align: data.align))
        }
        .setAttribute(name: "x-data", value: alpineData)
        .setAttribute(name: "x-id", value: "['\(data.alpineId)']")
        .setAttribute(
            name: "@keydown.down.prevent.stop",
            value: "\(data.bindOpen) ? nextItem() : openMenu(0)"
        )
        .setAttribute(
            name: "@keydown.up.prevent.stop",
            value: "\(data.bindOpen) ? prevItem() : openMenu(-1)"
        )
        .setAttribute(
            name: "@keydown.home.prevent.stop",
            value: "\(data.bindOpen) && firstItem()"
        )
        .setAttribute(
            name: "@keydown.end.prevent.stop",
            value: "\(data.bindOpen) && lastItem()"
        )
        .setAttribute(name: "@keydown.escape.window", value: closeAction)
        .setAttribute(
            name: "@keydown.tab",
            value: "\(data.bindOpen) && close()"
        )
        .setAttribute(
            name: "x-on:focusin.window",
            value:
                "! $refs.panel.contains($event.target) && ! $refs.button.contains($event.target) && close()"
        )
        .class(styles.container)
    }
}
