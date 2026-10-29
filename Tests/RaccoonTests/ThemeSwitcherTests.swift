import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("ThemeSwitcher")
struct ThemeSwitcherTests {

    @Test("renders trigger button, palette2 icon, and loads its script")
    func rendersTriggerAndScript() {
        let html = renderHTML(
            ThemeSwitcher(ThemeSwitcherData()).render()
        )
        #expect(html.contains("src=\"/js/themeswitcher.js\""))
        #expect(html.contains("<svg"))
        #expect(html.contains("M0 .5A.5.5 0 0 1 .5 0h5a"))
        #expect(html.contains("x-ref=\"button\""))
    }

    @Test("trigger button carries accessible attributes")
    func hasAccessibleTriggerAttributes() {
        let html = renderHTML(
            ThemeSwitcher(ThemeSwitcherData()).render()
        )
        #expect(html.contains("type=\"button\""))
        #expect(html.contains("aria-label=\"Select color theme\""))
        #expect(html.contains(":aria-expanded=\"open\""))
        #expect(html.contains(":aria-controls=\"$id('dropdown-button')\""))
    }

    @Test("renders dropdown panel with proper roles and attributes")
    func rendersDropdownPanelWithRoles() {
        let html = renderHTML(
            ThemeSwitcher(ThemeSwitcherData()).render()
        )
        #expect(html.contains("x-ref=\"panel\""))
        #expect(html.contains("x-show=\"open\""))
        #expect(html.contains("role=\"menu\""))
        #expect(html.contains(":id=\"$id('dropdown-button')\""))
    }

    @Test("renders all theme options with checkmarks and radio roles")
    func rendersAllThemeOptionsWithCheckmarks() {
        let html = renderHTML(
            ThemeSwitcher(ThemeSwitcherData()).render()
        )
        #expect(html.contains("role=\"menuitemradio\""))
        #expect(html.contains("emerald mine"))
        #expect(html.contains("black and white"))
        #expect(html.contains("beacon blue"))
        #expect(
            html.contains(
                ":aria-checked=\"currentTheme === 'emerald-mine'\""
            )
        )
        #expect(
            html.contains(
                ":aria-checked=\"currentTheme === 'black-and-white'\""
            )
        )
        #expect(
            html.contains(
                ":aria-checked=\"currentTheme === 'beacon-blue'\""
            )
        )
        #expect(html.contains("@click=\"setTheme('emerald-mine')\""))
        #expect(html.contains("@click=\"setTheme('black-and-white')\""))
        #expect(html.contains("@click=\"setTheme('beacon-blue')\""))
        #expect(html.contains("x-show=\"currentTheme === 'emerald-mine'\""))
        #expect(
            html.contains("x-show=\"currentTheme === 'black-and-white'\"")
        )
        #expect(
            html.contains("x-show=\"currentTheme === 'beacon-blue'\"")
        )
    }

    @Test("binds click, escape, focus, and outside-click interactions")
    func handlesClickAndKeyboardEvents() {
        let html = renderHTML(
            ThemeSwitcher(ThemeSwitcherData()).render()
        )
        #expect(html.contains("@click=\"toggle()\""))
        #expect(
            html.contains("@keydown.escape.window=\"close($refs.button)\"")
        )
        #expect(html.contains("@click.outside=\"close($refs.button)\""))
        #expect(
            html.contains(
                "x-on:focusin.window=\"! $refs.panel.contains($event.target) && ! $refs.button.contains($event.target) && close()\""
            )
        )
    }

    @Test("supports left and right alignment")
    func supportsAlignment() {

        let left = renderHTML(
            ThemeSwitcher(ThemeSwitcherData(align: .left)).render()
        )
        #expect(left.contains(ThemeSwitcherStyles.dropdownPanel))
        #expect(left.contains("x-transition.origin.top.left"))

        let right = renderHTML(
            ThemeSwitcher(ThemeSwitcherData(align: .right)).render()
        )
        #expect(right.contains(ThemeSwitcherStyles.dropdownPanelRight))
        #expect(right.contains("x-transition.origin.top.right"))
    }

    @Test("passes Matomo tracking flag into the Alpine component")
    func passesTrackingFlag() {

        let tracked = renderHTML(
            ThemeSwitcher(
                ThemeSwitcherData(matomoStatus: .ACCEPTED)
            )
            .render()
        )
        #expect(
            tracked.contains(
                "x-data=\"themeSwitcher('emerald-mine', true)\""
            )
        )

        let untracked = renderHTML(
            ThemeSwitcher(
                ThemeSwitcherData(matomoStatus: .DECLINED)
            )
            .render()
        )
        #expect(
            untracked.contains(
                "x-data=\"themeSwitcher('emerald-mine', false)\""
            )
        )
    }

    @Test("supports custom theme options")
    func supportsCustomThemeOptions() {

        let custom = renderHTML(
            ThemeSwitcher(
                ThemeSwitcherData(
                    defaultTheme: .blackAndWhite,
                    themes: [.blackAndWhite]
                )
            )
            .render()
        )
        #expect(
            custom.contains(
                "x-data=\"themeSwitcher('black-and-white', false)\""
            )
        )
        #expect(custom.contains("black and white"))
        #expect(!custom.contains("setTheme('emerald-mine')"))
    }

    @Test("detect-theme script sets data-theme before paint")
    func detectThemeScript() {
        let script = ThemeSwitcher.detectThemeScript
        #expect(
            script.contains(
                "document.documentElement.setAttribute('data-theme'"
            )
        )
        #expect(script.contains("localStorage.getItem('theme')"))
        #expect(script.contains("localStorage.setItem('theme', 'emerald-mine')"))
        #expect(script.contains("stored === 'raumnebenan'"))
    }

    @Test("applies the shared icon button styling")
    func usesIconButtonStyling() {
        let html = renderHTML(
            ThemeSwitcher(ThemeSwitcherData()).render()
        )
        #expect(html.contains(ActionButtonStyles.iconButton))
    }

    @Test("renders optional id and custom Matomo content tracking")
    func rendersOptionalData() {

        let withId = renderHTML(
            ThemeSwitcher(
                ThemeSwitcherData(
                    id: "themeSwitcherId",
                    matomoStatus: .ACCEPTED
                )
            )
            .render()
        )
        #expect(withId.contains("id=\"themeSwitcherId\""))
        #expect(withId.contains("data-track-content"))
        #expect(withId.contains("data-content-name=\"theme-switcher\""))

        let withoutId = renderHTML(
            ThemeSwitcher(ThemeSwitcherData()).render()
        )
        #expect(!withoutId.contains("id=\"themeSwitcherId\""))
        #expect(!withoutId.contains("data-track-content"))
    }
}
