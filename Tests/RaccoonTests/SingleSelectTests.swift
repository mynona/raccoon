import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

private let options = [
    OptionValue(title: "Option A", value: "a"),
    OptionValue(title: "Option B", value: "b", selected: true),
    OptionValue(title: "Option C", value: "c"),
]

@Suite("SingleSelect")
struct SingleSelectTests {

    @Test("renders select element")
    func rendersSelectElement() async throws {

        let ctx = SingleSelectData(
            id: "sel-1",
            name: "choice",
            label: LabelData(id: "sel-1", title: "Choose"),
            placeholder: "Select…",
            options: options,
            state: .enabled
        )
        let html = renderHTML(SingleSelect(ctx).render())
        #expect(html.contains("<select") || html.contains("select"))
    }

    @Test("renders option titles")
    func rendersOptionTitles() async throws {

        let ctx = SingleSelectData(
            id: "sel-2",
            name: "pick",
            label: LabelData(id: "sel-2", title: "Pick one"),
            placeholder: "Select…",
            options: options,
            state: .enabled
        )
        let html = renderHTML(SingleSelect(ctx).render())
        #expect(html.contains("Option A"))
        #expect(html.contains("Option B"))
        #expect(html.contains("Option C"))
    }

    @Test("renders label text")
    func rendersLabel() async throws {

        let ctx = SingleSelectData(
            id: "sel-3",
            name: "framework",
            label: LabelData(id: "sel-3", title: "Framework"),
            options: options,
            state: .enabled
        )
        let html = renderHTML(SingleSelect(ctx).render())
        #expect(html.contains("Framework"))
    }

    @Test("renders hidden input bound to selected id")
    func rendersHiddenInputBoundToSelectedId() async throws {

        let ctx = SingleSelectData(
            id: "sel-4",
            name: "choice",
            label: LabelData(id: "sel-4", title: "Choose"),
            placeholder: "Select…",
            value: "b",
            options: options,
            state: .enabled
        )
        let html = renderHTML(SingleSelect(ctx).render())
        #expect(html.contains("type=\"hidden\""))
        #expect(html.contains("name=\"sel-4\""))
        #expect(html.contains("x-bind:value=\"selected ? selected.id : ''\""))
    }

    @Test("renders Alpine config with preselected value")
    func rendersAlpineConfigWithPreselectedValue() async throws {

        let ctx = SingleSelectData(
            id: "sel-5",
            name: "choice",
            label: LabelData(id: "sel-5", title: "Choose"),
            placeholder: "Select…",
            value: "b",
            options: options,
            state: .enabled
        )
        let html = renderHTML(SingleSelect(ctx).render())
        #expect(html.contains("singleSelect({"))
        #expect(html.contains("Option A"))
        #expect(html.contains("/js/single-select.js"))
    }

    @Test("renders combobox accessibility wiring")
    func rendersComboboxAccessibilityWiring() async throws {

        let ctx = SingleSelectData(
            id: "sel-6",
            name: "choice",
            label: LabelData(id: "sel-6", title: "Choose"),
            placeholder: "Select…",
            options: options,
            state: .enabled
        )
        let html = renderHTML(SingleSelect(ctx).render())
        #expect(html.contains("x-combobox:input"))
        #expect(html.contains("aria-controls=\"sel-6-listbox\""))
        #expect(html.contains("role=\"listbox\""))
        #expect(html.contains("Clear selection"))
    }
}
