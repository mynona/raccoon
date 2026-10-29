import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

/// Boolean attributes render bare; the `disabled:` class variant must not count.
private func hasDisabledAttribute(_ html: String) -> Bool {
    html.contains(" disabled>") || html.contains(" disabled ")
}

private func hasCheckedAttribute(_ html: String) -> Bool {
    html.contains(" checked>") || html.contains(" checked ")
}

@Suite("Radio")
struct RadioTests {

    @Test("renders radio input with id, name and value")
    func rendersInput() {
        let html = renderHTML(
            Radio(RadioData(id: "plan-a", name: "plan", value: "a")).render()
        )
        #expect(html.contains("type=\"radio\""))
        #expect(html.contains("id=\"plan-a\""))
        #expect(html.contains("name=\"plan\""))
        #expect(html.contains("value=\"a\""))
    }

    @Test("name and value fall back to id")
    func fallbacks() {
        let html = renderHTML(Radio(RadioData(id: "solo")).render())
        #expect(html.contains("name=\"solo\""))
        #expect(html.contains("value=\"solo\""))
    }

    @Test("renders label bound to the input")
    func rendersLabel() {
        let html = renderHTML(
            Radio(RadioData(id: "r1", label: "Option one")).render()
        )
        #expect(html.contains("Option one"))
        #expect(html.contains("for=\"r1\""))
    }

    @Test("renders no label element without label")
    func noLabel() {
        let html = renderHTML(Radio(RadioData(id: "r1")).render())
        #expect(!html.contains("<label"))
    }

    @Test("checked only when selected")
    func checkedState() {
        let selected = renderHTML(
            Radio(RadioData(id: "r1", isSelected: true)).render()
        )
        let unselected = renderHTML(Radio(RadioData(id: "r1")).render())
        #expect(hasCheckedAttribute(selected))
        #expect(!hasCheckedAttribute(unselected))
    }

    @Test("disabled state disables the input")
    func disabledState() {
        let html = renderHTML(
            Radio(RadioData(id: "r1", label: "Off", state: .disabled)).render()
        )
        #expect(hasDisabledAttribute(html))
        #expect(html.contains("cursor-not-allowed"))
        #expect(!html.contains("hover:ring-2"))
    }

    @Test("enabled state has no disabled attribute")
    func enabledState() {
        let html = renderHTML(Radio(RadioData(id: "r1")).render())
        #expect(!hasDisabledAttribute(html))
        #expect(html.contains("hover:ring-2"))
    }

    @Test("plain variant has no aria attributes and no Alpine state")
    func plainVariant() {
        let html = renderHTML(Radio(RadioData(id: "r1", label: "Plain")).render())
        #expect(!html.contains("aria-describedby"))
        #expect(!html.contains("aria-invalid"))
        #expect(!html.contains("x-data"))
    }

    @Test("helper text is wired through aria-describedby")
    func helperText() {
        let html = renderHTML(
            Radio(
                RadioData(
                    id: "r1",
                    label: "Label",
                    helperText: HelperTextData(id: "h", text: "Some help")
                )
            ).render()
        )
        #expect(html.contains("Some help"))
        #expect(html.contains("aria-describedby=\"h-helper\""))
        #expect(html.contains("id=\"h-helper\""))
        #expect(!html.contains("aria-invalid"))
    }

    @Test("error is wired through aria-describedby and sets aria-invalid")
    func errorMessages() {
        let html = renderHTML(
            Radio(
                RadioData(
                    id: "r1",
                    label: "Label",
                    errorMessages: ErrorMessageData(errorMessages: ["Pick one."]),
                    helperText: HelperTextData(id: "h", text: "Some help")
                )
            ).render()
        )
        #expect(html.contains("Pick one."))
        #expect(html.contains("aria-describedby=\"h-helper r1-error\""))
        #expect(html.contains("id=\"r1-error\""))
        #expect(html.contains("aria-invalid=\"true\""))
    }

    @Test("empty error and helper render nothing and add no references")
    func emptyFeedback() {
        let html = renderHTML(
            Radio(
                RadioData(
                    id: "r1",
                    errorMessages: ErrorMessageData(errorMessages: []),
                    helperText: HelperTextData(id: "h", text: "  ")
                )
            ).render()
        )
        #expect(!html.contains("aria-describedby"))
        #expect(!html.contains("aria-invalid"))
        #expect(!html.contains("h-helper"))
        #expect(!html.contains("r1-error"))
    }

    @Test("isInvalid sets aria-invalid without an error message")
    func isInvalid() {
        let html = renderHTML(Radio(RadioData(id: "r1", isInvalid: true)).render())
        #expect(html.contains("aria-invalid=\"true\""))
        #expect(!html.contains("aria-describedby"))
    }

    @Test("uses the round radio style class")
    func usesRadioStyle() {
        let html = renderHTML(Radio(RadioData(id: "r1")).render())
        #expect(html.contains("radio-input"))
        #expect(!html.contains("check-input"))
    }
}
