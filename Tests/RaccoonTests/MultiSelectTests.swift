import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

private let options = [
    OptionValue(title: "Swift", value: "swift"),
    OptionValue(title: "Vapor", value: "vapor", selected: true),
    OptionValue(title: "HTML", value: "html"),
]

@Suite("MultiSelect")
struct MultiSelectTests {
    @Test("renders error message when present")
    func rendersErrorMessage() async throws {
        let ctx = MultiSelectData(
            id: "ms-err",
            name: "techs",
            label: LabelData(id: "ms-err", title: "Tech"),
            placeholder: "Select…",
            values: ["vapor"],
            options: options,
            state: .enabled,
            errorMessages: ErrorMessageData(
                id: "err-1",
                errorMessages: ["error one"],
                hasIcon: false
            ),
        )
        let html = renderHTML(MultiSelect(ctx).render())
        #expect(html.contains("error one"))
    }

    @Test("renders info state with value")
    func rendersInfoState() async throws {
        let ctx = MultiSelectData(
            id: "ms-info",
            name: "techs",
            label: LabelData(id: "ms-info", title: "Tech"),
            placeholder: "Select…",
            values: ["vapor"],
            options: options,
            state: .info
        )
        let html = renderHTML(MultiSelect(ctx).render())
        #expect(html.contains("Vapor"))
        #expect(html.contains("Tech"))
    }

    @Test("renders with background color")
    func rendersWithBackgroundColor() async throws {
        let ctx = MultiSelectData(
            id: "ms-bg",
            name: "techs",
            label: LabelData(id: "ms-bg", title: "Tech"),
            placeholder: "Select…",
            values: ["vapor"],
            options: options,
            state: .info,
            backgroundColor: "#7e43ac"
        )
        let html = renderHTML(MultiSelect(ctx).render())
        #expect(html.contains("background-color: #7e43ac"))
    }

    @Test("renders disabled state")
    func rendersDisabledState() async throws {
        let ctx = MultiSelectData(
            id: "ms-disabled",
            name: "techs",
            label: LabelData(id: "ms-disabled", title: "Tech"),
            placeholder: "Select…",
            values: ["vapor"],
            options: options,
            state: .disabled
        )
        let html = renderHTML(MultiSelect(ctx).render())
        #expect(html.contains("cursor-not-allowed"))
        #expect(html.contains("Vapor"))
    }

    @Test("renders helper text if present")
    func rendersHelperText() async throws {
        let ctx = MultiSelectData(
            id: "ms-helper",
            name: "techs",
            label: LabelData(id: "ms-helper", title: "Tech"),
            placeholder: "Select…",
            values: ["vapor"],
            options: options,
            state: .enabled,
            helperText: HelperTextData(
                id: "hlp-1",
                text: "helper-text-1"
            ),
        )
        let html = renderHTML(MultiSelect(ctx).render())
        #expect(html.contains("helper-text-1"))
    }

    @Test("renders option titles")
    func rendersOptionTitles() async throws {

        let ctx = MultiSelectData(
            id: "ms-1",
            name: "techs",
            label: LabelData(id: "ms-1", title: "Technologies"),
            placeholder: "Select…",
            values: ["vapor"],
            options: options,
            state: .enabled
        )
        let html = renderHTML(MultiSelect(ctx).render())
        #expect(html.contains("Swift"))
        #expect(html.contains("Vapor"))
        #expect(html.contains("HTML"))
    }

    @Test("renders label text")
    func rendersLabel() async throws {

        let ctx = MultiSelectData(
            id: "ms-2",
            name: "langs",
            label: LabelData(id: "ms-2", title: "Pick languages"),
            placeholder: "Choose…",
            values: [],
            options: options,
            state: .enabled
        )
        let html = renderHTML(MultiSelect(ctx).render())
        #expect(html.contains("Pick languages"))
    }

    @Test("marks pre-selected values as selected")
    func marksSelectedValues() async throws {

        let ctx = MultiSelectData(
            id: "ms-3",
            name: "stack",
            label: LabelData(id: "ms-3", title: "Stack"),
            placeholder: "Select…",
            values: ["swift"],
            options: options,
            state: .enabled
        )
        let html = renderHTML(MultiSelect(ctx).render())
        #expect(html.contains("swift"))
    }

    @Test("renders Alpine config with preselected indices")
    func rendersAlpineConfigWithPreselectedIndices() async throws {

        let ctx = MultiSelectData(
            id: "ms-4",
            name: "stack",
            label: LabelData(id: "ms-4", title: "Stack"),
            placeholder: "Select…",
            values: ["swift", "html"],
            options: options,
            state: .enabled
        )
        let html = renderHTML(MultiSelect(ctx).render())
        #expect(html.contains("multiSelect({frameworks:"))
        #expect(html.contains("preselected: [0,2]"))
    }

    @Test("renders hidden select for submitted selected values")
    func rendersHiddenSelectForSubmittedValues() async throws {

        let ctx = MultiSelectData(
            id: "ms-5",
            name: "stack",
            label: LabelData(id: "ms-5", title: "Stack"),
            placeholder: "Select…",
            values: ["swift"],
            options: options,
            state: .enabled
        )
        let html = renderHTML(MultiSelect(ctx).render())
        #expect(html.contains("<select"))
        #expect(html.contains("multiple"))
        #expect(html.contains("name=\"stack\""))
        #expect(html.contains("x-html=\"selectedOptions()\""))
    }

    @Test("renders combobox input and dropdown button")
    func rendersComboboxInputAndDropdownButton() async throws {

        let ctx = MultiSelectData(
            id: "ms-6",
            name: "stack",
            label: LabelData(id: "ms-6", title: "Stack"),
            placeholder: "Select…",
            values: [],
            options: options,
            state: .enabled
        )
        let html = renderHTML(MultiSelect(ctx).render())
        #expect(html.contains("x-combobox:input"))
        #expect(html.contains("Search or select"))
        #expect(html.contains("x-combobox:button"))
        #expect(html.contains("/js/multi-select.js"))
    }
}
