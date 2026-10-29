import HTML
import SGML
import SVG
import WebBuilders

/// ThemeSwitcher
///
/// An accessible dropdown menu component allowing users to switch between color themes
/// (e.g. "Emerald mine" default and "Black and White").
///
/// Self-contained: owns its Alpine state via `/js/themeswitcher.js`.
/// Theme preference is persisted in `localStorage` under `theme` and sets the `data-theme`
/// attribute on `document.documentElement`.
public struct ThemeSwitcher: TemplateRepresentable {
    let data: ThemeSwitcherData
    typealias styles = ThemeSwitcherStyles

    /// Must stay inline in `<head>`: it sets the `data-theme` attribute before first paint.
    /// Loading it via `src` would run too late and flash the default theme.
    public static let detectThemeScript: String = """
        // detect-theme.js
        // Set initial color theme before first paint to eliminate flashing

        (() => {
            let explicitlyPreferredTheme = null;
            try {
                if (window.localStorage) {
                    let stored = localStorage.getItem('theme');
                    // 'raumnebenan' was the former name of the 'emerald-mine' theme
                    if (stored === 'raumnebenan') {
                        stored = 'emerald-mine';
                        localStorage.setItem('theme', stored);
                    }
                    if (stored) {
                        document.documentElement.setAttribute('data-theme', stored);
                        explicitlyPreferredTheme = stored;
                    }
                }
            } catch (e) {}

            if (explicitlyPreferredTheme === null) {
                document.documentElement.setAttribute('data-theme', 'emerald-mine');
                try {
                    if (window.localStorage) {
                        localStorage.setItem('theme', 'emerald-mine');
                    }
                } catch (e) {}
            }
        })();
        """

    public init(
        _ data: ThemeSwitcherData
    ) {
        self.data = data
    }

    @Builder<Element>
    public func render() -> [Element] {

        DebugComment("Theme switcher")
        Script()
            .src("/js/themeswitcher.js")
            .setAttribute(
                name: "type",
                value: "text/javascript"
            )

        let options = data.themes.map { theme in
            SimpleMenuOption(
                id: theme.rawValue,
                title: theme.displayName,
                clickAction: "setTheme('\(theme.rawValue)')",
                bindSelected: "currentTheme === '\(theme.rawValue)'",
                role: "menuitemradio",
                bindAriaChecked: "currentTheme === '\(theme.rawValue)'"
            )
        }

        let menuData = SimpleMenuData(
            id: data.id,
            alpineId: "dropdown-button",
            bindOpen: "open",
            bindAlpineData:
                "themeSwitcher('\(data.defaultTheme.rawValue)', \(data.matomoStatus == .ACCEPTED))",
            ariaLabel: data.ariaLabel,
            options: options,
            align: data.align,
            triggerIcon: .palette2,
            hasTriggerChevron: false,
            matomoStatus: data.matomoStatus,
            contentTracker: MatomoContentTracker(
                name: "theme-switcher",
                piece: "toggle",
                target: ""
            )
        )

        SimpleMenu(menuData).render()
    }
}
