import HTML
import SGML
import Testing
import WebBuilders

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

private let errors = ErrorMessageData(errorMessages: ["Wrong"])

@Suite("Field state borders")
struct FieldStateBorderTests {

    @Test("the dropdown label and trigger share one border with error, success and default colours")
    func dropdownBorder() throws {
        let html = renderHTML(
            Dropdown(
                DropdownData(
                    id: "country",
                    label: LabelData(id: "country", title: "Country"),
                    errorMessages: errors
                )
            ).render()
        )
        #expect(html.contains("border-on-error-variant"))
        #expect(html.contains("border-on-success"))
        #expect(html.contains("hasServerError: true"))
        // The state lives on the container that holds the label, not on the trigger
        let label = try #require(html.range(of: "Country"))
        let state = try #require(html.range(of: "border-on-error-variant"))
        let trigger = try #require(html.range(of: "id=\"country-trigger\""))
        #expect(state.lowerBound < label.lowerBound)
        #expect(!html[trigger.lowerBound...].prefix(400).contains("border-on-error-variant"))
    }

    @Test("the dropdown error message follows the error state")
    func dropdownMessageIsGated() {
        let html = renderHTML(
            Dropdown(DropdownData(id: "country", errorMessages: errors)).render()
        )
        #expect(html.contains("x-show=\"hasServerError\""))
    }

    @Test("a check box shows the error border only when it has an error")
    func checkBorder() {
        let withError = renderHTML(
            Check(CheckData(id: "terms", label: "Terms", errorMessages: errors))
                .render()
        )
        #expect(withError.contains("border-on-error-variant"))
        #expect(withError.contains("hasServerError = false"))

        let without = renderHTML(
            Check(CheckData(id: "terms", label: "Terms")).render()
        )
        #expect(!without.contains("border-on-error-variant"))
        #expect(!without.contains("@change"))
    }

    @Test("a checkbox select and a radio get the error border from the server render")
    func staticErrorBorders() {
        let list = renderHTML(
            CheckboxSelect(
                CheckboxSelectData(
                    id: "tags",
                    label: nil,
                    values: [],
                    errorMessages: errors
                )
            ).render()
        )
        #expect(list.contains("border-on-error-variant"))

        let radio = renderHTML(
            Radio(RadioData(id: "a", name: "choice", errorMessages: errors))
                .render()
        )
        #expect(radio.contains("border-on-error-variant"))
        #expect(radio.contains("aria-invalid=\"true\""))
    }

    @Test("the date picker border surrounds label and pill, the pill has none")
    func datePickerBorder() {
        let html = renderHTML(
            DatePicker(
                DatePickerData(
                    id: "date",
                    label: LabelData(id: "date", title: "Date"),
                    errorMessages: errors
                )
            ).render()
        )
        #expect(html.contains("border-on-error-variant"))
        #expect(html.contains("border-on-success"))
        #expect(!DatePickerStyles.pillContainer.contains("border"))
    }
}
