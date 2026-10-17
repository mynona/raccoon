import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("ToggleSwitch")
struct ToggleSwitchTests {

    @Test("renders toggle input element")
    func rendersInputElement() async throws {

        let html = renderHTML(
            ToggleSwitch(
                ToggleSwitchData(
                    id: "notify",
                    isSelected: false,
                    state: .enabled
                )
            )
            .render()
        )
        #expect(html.contains("<input"))
    }

    @Test("renders label when provided")
    func rendersLabel() async throws {

        let html = renderHTML(
            ToggleSwitch(
                ToggleSwitchData(
                    id: "dark-mode",
                    label: LabelData(id: "dark-mode", title: "Dark mode"),
                    isSelected: false,
                    state: .enabled
                )
            )
            .render()
        )
        #expect(html.contains("Dark mode"))
    }

    @Test("renders checked state when value is true")
    func rendersCheckedState() async throws {

        let html = renderHTML(
            ToggleSwitch(
                ToggleSwitchData(
                    id: "toggle-on",
                    isSelected: true,
                    state: .enabled
                )
            )
            .render()
        )
        #expect(html.contains("initialValue: true"))
    }

    @Test("does not render checked when value is false")
    func doesNotRenderCheckedWhenFalse() async throws {

        let html = renderHTML(
            ToggleSwitch(
                ToggleSwitchData(
                    id: "toggle-off",
                    isSelected: false,
                    state: .enabled
                )
            )
            .render()
        )
        #expect(html.contains("initialValue: false"))
    }

    @Test("renders hidden input bound to switch value")
    func rendersHiddenInputBoundToSwitchValue() async throws {

        let html = renderHTML(
            ToggleSwitch(
                ToggleSwitchData(
                    id: "notify",
                    label: LabelData(id: "notify", title: "Notifications"),
                    isSelected: true,
                    state: .enabled
                )
            )
            .render()
        )
        #expect(html.contains("type=\"hidden\""))
        #expect(html.contains("name=\"notify\""))
        #expect(html.contains(":value=\"value\""))
        #expect(html.contains("x-switch:group"))
    }

    @Test("renders api click wiring and script")
    func rendersApiClickWiringAndScript() async throws {

        let html = renderHTML(
            ToggleSwitch(
                ToggleSwitchData(
                    id: "remote-toggle",
                    label: LabelData(
                        id: "remote-toggle",
                        title: "Remote toggle"
                    ),
                    isSelected: false,
                    state: .enabled,
                    apiURL: "/api/toggle"
                )
            )
            .render()
        )
        #expect(html.contains("data-api-url=\"/api/toggle\""))
        #expect(html.contains("@click=\"updateStatus($el.dataset.apiUrl)\""))
        #expect(
            html.contains(
                "toggleSwitch({ initialValue: false, apiUrl: '/api/toggle' })"
            )
        )
        #expect(html.contains("/js/toggle.js"))
        #expect(html.contains("x-switch"))
    }

    @Test("renders disabled state with left label and xl size")
    func rendersDisabledStateWithLeftLabelAndXLSize() async throws {

        let html = renderHTML(
            ToggleSwitch(
                ToggleSwitchData(
                    id: "access",
                    label: LabelData(
                        id: "access",
                        title: "Access",
                        position: .left
                    ),
                    isSelected: false,
                    size: .xl,
                    state: .disabled
                )
            )
            .render()
        )
        #expect(html.contains("Access"))
        #expect(html.contains("pr-3"))
        #expect(html.contains("text-lg"))
        #expect(html.contains("disabled"))
        #expect(html.contains("w-14"))
        #expect(html.contains("cursor-not-allowed"))
    }

    @Test("renders small size toggle switch classes")
    func rendersSmallSizeToggleSwitch() async throws {

        let html = renderHTML(
            ToggleSwitch(
                ToggleSwitchData(
                    id: "small-toggle",
                    isSelected: false,
                    size: .sm,
                    state: .enabled
                )
            )
            .render()
        )
        #expect(html.contains("w-6"))
        #expect(html.contains("h-2 w-2"))
        #expect(html.contains("translate-x-3"))
    }
}
