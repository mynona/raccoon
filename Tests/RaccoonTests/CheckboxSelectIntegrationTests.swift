import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("CheckboxSelect Integration")
struct CheckboxSelectIntegrationTests {
    @Test("multiple CheckboxSelects on one page send correct data by key")
    func multipleCheckboxSelectsSendCorrectData() async throws {

        let options1 = [
            OptionValue(title: "A", value: "a"),
            OptionValue(title: "B", value: "b", selected: true),
            OptionValue(title: "C", value: "c"),
        ]
        let options2 = [
            OptionValue(title: "X", value: "x", selected: true),
            OptionValue(title: "Y", value: "y"),
            OptionValue(title: "Z", value: "z", selected: true),
        ]
        let data1 = CheckboxSelectData(
            id: "first",
            label: LabelData(id: "first", title: "First"),
            values: options1
        )
        let data2 = CheckboxSelectData(
            id: "second",
            label: LabelData(id: "second", title: "Second"),
            values: options2
        )
        let html = renderHTML(
            [
                CheckboxSelect(data1).render(),
                CheckboxSelect(data2).render(),
            ]
            .flatMap { $0 }
        )

        // Check both hidden inputs are present with correct names
        #expect(html.contains("name=\"first\""))
        #expect(html.contains("name=\"second\""))

        // Simulate backend receiving form data
        let formData: [String: String] = [
            "first": "b",
            "second": "x,z",
        ]
        // Backend extraction
        let firstSelected =
            formData["first"]?.split(separator: ",").map(String.init) ?? []
        let secondSelected =
            formData["second"]?.split(separator: ",").map(String.init) ?? []
        #expect(firstSelected == ["b"])
        #expect(Set(secondSelected) == Set(["x", "z"]))
    }
}
