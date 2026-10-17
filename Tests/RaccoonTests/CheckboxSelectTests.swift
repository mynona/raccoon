import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("CheckboxSelect")
struct CheckboxSelectTests {

    @Test("renders checkbox inputs for each option")
    func rendersCheckboxInputs() async throws {

        let options = [
            OptionValue(title: "Swift", value: "swift"),
            OptionValue(title: "Vapor", value: "vapor"),
        ]
        let data = CheckboxSelectData(
            id: "langs",
            label: LabelData(id: "langs", title: "Languages"),
            values: options
        )
        let html = renderHTML(CheckboxSelect(data).render())
        #expect(html.contains("Swift"))
        #expect(html.contains("Vapor"))
    }

    @Test("renders label when provided")
    func rendersLabel() async throws {

        let data = CheckboxSelectData(
            id: "tags",
            label: LabelData(id: "tags", title: "Tags"),
            values: []
        )
        let html = renderHTML(CheckboxSelect(data).render())
        #expect(html.contains("Tags"))
    }

    @Test("renders error message when provided")
    func rendersErrorMessage() async throws {

        let data = CheckboxSelectData(
            id: "choice",
            label: nil,
            values: [],
            errorMessages: ErrorMessageData(
                errorMessages: [
                    "Please select at least one option."
                ]
            )
        )
        let html = renderHTML(CheckboxSelect(data).render())
        #expect(html.contains("Please select at least one option."))
    }

    @Test("renders hidden input bound to joined values")
    func rendersHiddenInputBoundToJoinedValues() async throws {

        let data = CheckboxSelectData(
            id: "langs",
            label: LabelData(id: "langs", title: "Languages"),
            values: [
                OptionValue(
                    title: "Swift",
                    value: "swift",
                    selected: true
                ),
                OptionValue(title: "Vapor", value: "vapor"),
            ]
        )

        let html = renderHTML(CheckboxSelect(data).render())
        #expect(html.contains("type=\"hidden\""))
        #expect(html.contains("name=\"langs\""))
        #expect(html.contains("x-model=\"joined\""))
    }

    @Test("renders search input and select all controls by default")
    func rendersSearchAndSelectAllByDefault() async throws {

        let data = CheckboxSelectData(
            id: "langs",
            label: LabelData(id: "langs", title: "Languages"),
            values: [OptionValue(title: "Swift", value: "swift")]
        )

        let html = renderHTML(CheckboxSelect(data).render())
        #expect(html.contains("placeholder=\"Search\""))
        #expect(html.contains("x-model=\"searchRaw\""))
        #expect(html.contains("x-ref=\"checkboxSearchInput\""))
        #expect(html.contains("aria-label=\"Search options\""))
        #expect(html.contains("aria-controls=\"checkbox-options\""))
        #expect(html.contains("tabindex=\"0\""))
        #expect(html.contains("Select All"))
        #expect(html.contains("Select all options"))
    }

    @Test("omits search and select all when disabled in data")
    func omitsSearchAndSelectAllWhenDisabledInData() async throws {

        let data = CheckboxSelectData(
            id: "langs",
            label: LabelData(id: "langs", title: "Languages"),
            values: [OptionValue(title: "Swift", value: "swift")],
            hasSearch: false,
            hasSelectAll: false
        )

        let html = renderHTML(CheckboxSelect(data).render())
        #expect(!html.contains("placeholder=\"Search\""))
        #expect(!html.contains("Select All"))
        #expect(html.contains("mt-2"))
    }

    @Test("sanitizes custom id prefix")
    func sanitizesCustomIdPrefix() async throws {

        let data = CheckboxSelectData(
            id: "langs",
            label: LabelData(id: "langs", title: "Languages"),
            values: [OptionValue(title: "Swift", value: "swift")]
        )

        let html = renderHTML(
            CheckboxSelect(data, idPrefix: "9-prefix-test").render()
        )
        #expect(html.contains("_9_prefix_test-selectAll"))
        #expect(html.contains("_9_prefix_test-hidden"))
    }
}
