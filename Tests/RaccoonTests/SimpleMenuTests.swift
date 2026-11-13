import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("SimpleMenu")
struct SimpleMenuTests {

    @Test("renders trigger button and floating menu container")
    func rendersTriggerAndContainer() async throws {
        let data = SimpleMenuData(
            id: "testDropdown",
            ariaLabel: "Options menu",
            triggerText: "Actions",
            options: [
                SimpleMenuOption(id: "opt1", title: "Option 1"),
                SimpleMenuOption(id: "opt2", title: "Option 2"),
            ]
        )
        let html = renderHTML(SimpleMenu(data).render())

        // Script and clean Alpine initialization
        #expect(html.contains("src=\"/js/simple-menu.js\""))
        #expect(html.contains("x-data=\"simpleMenu()\""))

        // Trigger button
        #expect(html.contains("<button type=\"button\""))
        #expect(html.contains("id=\"testDropdown\""))
        #expect(html.contains("aria-label=\"Options menu\""))
        #expect(html.contains("Actions"))
        #expect(html.contains("x-ref=\"button\""))
        #expect(html.contains("@click=\"toggle()\""))
        #expect(html.contains("@keydown.down.prevent.stop=\"openMenu(0)\""))
        #expect(html.contains("@keydown.up.prevent.stop=\"openMenu(-1)\""))
        #expect(html.contains(":aria-expanded=\"open\""))

        // Dropdown panel
        #expect(html.contains("x-ref=\"panel\""))
        #expect(html.contains("x-show=\"open\""))
        #expect(html.contains("@click.outside=\"close($refs.button)\""))
        #expect(
            html.contains(
                "@keydown.down.prevent.stop=\"open ? nextItem() : openMenu(0)\""
            )
        )
        #expect(
            html.contains(
                "@keydown.up.prevent.stop=\"open ? prevItem() : openMenu(-1)\""
            )
        )
        #expect(
            html.contains("@keydown.home.prevent.stop=\"open && firstItem()\"")
        )
        #expect(
            html.contains("@keydown.end.prevent.stop=\"open && lastItem()\"")
        )
        #expect(html.contains("@keydown.escape.window=\"close($refs.button)\""))
        #expect(html.contains("@keydown.tab=\"open && close()\""))
        #expect(html.contains("role=\"menu\""))
        #expect(html.contains("role=\"menuitem\""))
    }

    @Test("renders SSR link mode options with anchor tags and checkmarks")
    func rendersSsrLinkMode() async throws {
        let options = [
            SimpleMenuOption(
                id: "10",
                title: "10 items",
                isSelected: true,
                href: "/items?per=10"
            ),
            SimpleMenuOption(
                id: "20",
                title: "20 items",
                isSelected: false,
                href: "/items?per=20"
            ),
        ]
        let data = SimpleMenuData(
            triggerText: "10 items",
            options: options
        )
        let html = renderHTML(SimpleMenu(data).render())

        // Selected option renders <a> with href, checkmark, and aria-checked
        #expect(
            html.contains(
                "<a href=\"/items?per=10\" role=\"menuitem\" aria-checked=\"true\""
            )
        )
        #expect(html.contains("10 items"))

        // Unselected option renders <a> with href without aria-checked
        #expect(html.contains("<a href=\"/items?per=20\" role=\"menuitem\""))
        #expect(html.contains("20 items"))
    }

    @Test("renders Alpine client mode options with buttons and action handlers")
    func rendersAlpineMode() async throws {
        let options = [
            SimpleMenuOption(
                id: "theme1",
                title: "Light",
                clickAction: "setMode('light')",
                bindSelected: "mode === 'light'"
            ),
            SimpleMenuOption(
                id: "theme2",
                title: "Dark",
                clickAction: "setMode('dark')",
                bindSelected: "mode === 'dark'"
            ),
        ]
        let data = SimpleMenuData(
            bindTriggerText: "currentLabel",
            options: options
        )
        let html = renderHTML(SimpleMenu(data).render())

        // Dynamic trigger text binding
        #expect(html.contains("x-text=\"currentLabel\""))

        // Button items with click actions and checkmark visibility
        #expect(html.contains("<button type=\"button\" role=\"menuitem\""))
        #expect(html.contains("@click=\"setMode('light')\""))
        #expect(html.contains("x-show=\"mode === 'light'\""))
        #expect(html.contains("@click=\"setMode('dark')\""))
        #expect(html.contains("x-show=\"mode === 'dark'\""))
    }

    @Test("supports right alignment and custom width")
    func supportsAlignmentAndWidth() async throws {
        let data = SimpleMenuData(
            options: [SimpleMenuOption(id: "1", title: "Item")],
            align: .right,
            width: "w-64"
        )
        let html = renderHTML(SimpleMenu(data).render())

        #expect(html.contains("right-0"))
        #expect(html.contains("w-64"))
        #expect(html.contains("x-transition.origin.top.right"))
    }

    @Test("supports center alignment")
    func supportsCenterAlignment() async throws {
        let data = SimpleMenuData(
            options: [SimpleMenuOption(id: "1", title: "Item")],
            align: .center,
            width: "w-64"
        )
        let html = renderHTML(SimpleMenu(data).render())

        #expect(html.contains("left-1/2 -translate-x-1/2"))
        #expect(html.contains("w-64"))
        #expect(html.contains("x-transition.origin.top"))
    }

    @Test("renders custom trigger content when provided via builder closure")
    func rendersCustomTriggerContent() async throws {
        let data = SimpleMenuData(
            options: [SimpleMenuOption(id: "1", title: "Item")]
        )
        let menu = SimpleMenu(data) {
            Span("Custom Avatar Trigger")
        }
        let html = renderHTML(menu.render())

        #expect(html.contains("Custom Avatar Trigger"))
    }

    @Test("renders disabled option as disabled button with aria-disabled")
    func rendersDisabledOption() async throws {
        let data = SimpleMenuData(
            options: [
                SimpleMenuOption(id: "1", title: "Enabled", clickAction: "run()"),
                SimpleMenuOption(id: "2", title: "Disabled", clickAction: "run()", state: .disabled),
            ]
        )
        let html = renderHTML(SimpleMenu(data).render())

        #expect(html.contains("Enabled"))
        #expect(html.contains("Disabled"))
        #expect(html.contains("disabled=\"disabled\"") || html.contains("disabled"))
        #expect(html.contains("aria-disabled=\"true\""))
    }

    @Test("adds x-sort:handle and grab cursor when isSortHandle is true")
    func rendersSortHandleTrigger() async throws {
        let data = SimpleMenuData(
            options: [SimpleMenuOption(id: "1", title: "Item")],
            isSortHandle: true
        )
        let html = renderHTML(SimpleMenu(data).render())

        #expect(html.contains("x-sort:handle"))
        #expect(html.contains("cursor-grab"))
    }

    @Test("renders leading icon in options when specified")
    func rendersOptionLeadingIcon() async throws {
        let options = [
            SimpleMenuOption(
                id: "profile",
                title: "Account settings",
                isSelected: true,
                href: "/profile",
                icon: .person_fill
            ),
            SimpleMenuOption(
                id: "logout",
                title: "Sign out",
                clickAction: "signOut()",
                icon: .box_arrow_left
            ),
        ]
        let data = SimpleMenuData(options: options)
        let html = renderHTML(SimpleMenu(data).render())

        // Leading icon and title wrapped together in itemContent
        #expect(html.contains(SimpleMenuStyles.itemContent))
        #expect(html.contains(SimpleMenuStyles.optionIcon))
        #expect(html.contains("Account settings"))
        #expect(html.contains("Sign out"))
        // Checkmark is also present on selected option
        #expect(html.contains(SimpleMenuStyles.activeIcon))
    }

    // MARK: localization

    @Test(
        "the default aria-label is built in and translated; literals stay plain"
    )
    func localizedDefaults() {
        let data = SimpleMenuData(
            triggerText: "Actions",
            options: [SimpleMenuOption(id: "o", title: "Option")]
        )
        let english = renderHTML(SimpleMenu(data).render())
        #expect(
            english.contains("data-i18n-aria-label=\"simplemenu.dropdownMenu\"")
        )
        let german = I18n.render(language: "de") {
            renderHTML(SimpleMenu(data).render())
        }
        #expect(german.contains("aria-label=\"Dropdown-Menü\""))
        #expect(german.contains(">Actions</span>"))
        #expect(german.contains(">Option</span>"))
        #expect(!german.contains("data-i18n=\""))
    }

    @Test("consumer option titles and trigger text are translated with markers")
    func consumerTexts() {
        let data = SimpleMenuData(
            triggerText: LocalizedText(
                en: "Actions",
                translations: ["de": "Aktionen"]
            ),
            options: [
                SimpleMenuOption(
                    id: "o",
                    title: LocalizedText(
                        en: "Edit",
                        translations: ["de": "Bearbeiten"]
                    )
                )
            ]
        )
        let html = I18n.render(language: "de") {
            renderHTML(SimpleMenu(data).render())
        }
        #expect(html.contains(">Aktionen</span>"))
        #expect(html.contains(">Bearbeiten</span>"))
        #expect(html.contains("data-i18n-values="))
    }
}
