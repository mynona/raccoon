import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("DarkLightModeToggle")
struct DarkLightModeToggleTests {

    @Test("renders both icons and loads its script")
    func rendersIconsAndScript() {
        let html = renderHTML(
            DarkLightModeToggle(DarkLightModeToggleData()).render()
        )
        #expect(html.contains("src=\"/js/darklightmode.js\""))
        #expect(html.contains("x-show=\"!lightMode\""))
        #expect(html.contains("x-show=\"lightMode\""))
    }

    @Test("button carries an accessible name")
    func hasAccessibleName() {
        let html = renderHTML(
            DarkLightModeToggle(DarkLightModeToggleData()).render()
        )
        #expect(html.contains("aria-label=\"Switch dark and light mode\""))
        #expect(html.contains("type=\"button\""))
    }

    @Test("click handler and Alt+M shortcut are bound")
    func bindsInteractions() {
        let html = renderHTML(
            DarkLightModeToggle(DarkLightModeToggleData()).render()
        )
        #expect(html.contains("@click=\"toggle()\""))
        #expect(
            html.contains(
                "@keydown.window=\"toggleFromKeyboard($event)\""
            )
        )
    }

    @Test("passes Matomo tracking flag into the Alpine component")
    func passesTrackingFlag() {

        let tracked = renderHTML(
            DarkLightModeToggle(
                DarkLightModeToggleData(matomoStatus: .ACCEPTED)
            )
            .render()
        )
        #expect(tracked.contains("x-data=\"darkLightModeToggle(true)\""))

        let untracked = renderHTML(
            DarkLightModeToggle(
                DarkLightModeToggleData(matomoStatus: .DECLINED)
            )
            .render()
        )
        #expect(untracked.contains("x-data=\"darkLightModeToggle(false)\""))
    }

    @Test("applies the shared icon button styling")
    func usesIconButtonStyling() {
        let html = renderHTML(
            DarkLightModeToggle(DarkLightModeToggleData()).render()
        )
        #expect(html.contains(ActionButtonStyles.iconButton))
    }

    @Test("renders optional id and custom Matomo content name")
    func rendersOptionalData() {

        let withId = renderHTML(
            DarkLightModeToggle(
                DarkLightModeToggleData(
                    id: "themeToggle",
                )
            )
            .render()
        )
        #expect(withId.contains("id=\"themeToggle\""))

        let withoutId = renderHTML(
            DarkLightModeToggle(DarkLightModeToggleData()).render()
        )
        #expect(!withoutId.contains("id=\"themeToggle\""))

    }

    @Test("detect-mode script sets the class before paint")
    func detectModeScript() {
        let script = DarkLightModeToggle.detectModeScript
        #expect(script.contains("classList.add('dark')"))
        #expect(script.contains("prefers-color-scheme:dark"))
        #expect(script.contains("localStorage.setItem('colorMode', 'dark')"))
    }
}
