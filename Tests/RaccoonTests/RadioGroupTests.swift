import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

private func count(of needle: String, in haystack: String) -> Int {
    haystack.components(separatedBy: needle).count - 1
}

/// Boolean attributes render bare; the `disabled:` class variant must not count.
private func hasDisabledAttribute(_ html: String) -> Bool {
    html.contains(" disabled>") || html.contains(" disabled ")
}

private func hasCheckedAttribute(_ html: String) -> Bool {
    html.contains(" checked>") || html.contains(" checked ")
}

private let plans: [RadioData] = [
    RadioData(id: "plan-free", label: "Free", value: "free"),
    RadioData(id: "plan-pro", label: "Pro", value: "pro"),
    RadioData(id: "plan-team", label: "Team", value: "team"),
]

@Suite("RadioGroup")
struct RadioGroupTests {

    @Test("renders fieldset with legend")
    func fieldsetAndLegend() {
        let html = renderHTML(
            RadioGroup(
                RadioGroupData(
                    id: "plan",
                    name: "plan",
                    label: LabelData(id: "plan", title: "Choose a plan"),
                    options: plans
                )
            ).render()
        )
        #expect(html.contains("<fieldset"))
        #expect(html.contains("<legend"))
        #expect(html.contains("Choose a plan"))
        #expect(html.contains("(required)"))
    }

    @Test("legend omits required marker when not required")
    func legendNotRequired() {
        let html = renderHTML(
            RadioGroup(
                RadioGroupData(
                    id: "plan",
                    name: "plan",
                    label: LabelData(id: "plan", title: "Plan", isRequired: false),
                    options: plans
                )
            ).render()
        )
        #expect(!html.contains("(required)"))
    }

    @Test("no legend without label")
    func noLegend() {
        let html = renderHTML(
            RadioGroup(RadioGroupData(id: "plan", name: "plan", options: plans)).render()
        )
        #expect(!html.contains("<legend"))
    }

    @Test("every option is a radio sharing the group name")
    func sharedName() {
        let html = renderHTML(
            RadioGroup(RadioGroupData(id: "plan", name: "plan-choice", options: plans)).render()
        )
        #expect(count(of: "type=\"radio\"", in: html) == 3)
        #expect(count(of: "name=\"plan-choice\"", in: html) == 3)
        #expect(html.contains("for=\"plan-pro\""))
    }

    @Test("only the option matching selectedValue is checked")
    func selectedValue() {
        let html = renderHTML(
            RadioGroup(
                RadioGroupData(id: "plan", name: "plan", selectedValue: "pro", options: plans)
            ).render()
        )
        #expect(count(of: " checked", in: html) == 1)
        let checkedInput = html.components(separatedBy: "<input").first { hasCheckedAttribute($0) }
        #expect(checkedInput?.contains("value=\"pro\"") == true)
    }

    @Test("selectedValue matches the id when an option has no value")
    func selectedValueFallsBackToId() {
        let html = renderHTML(
            RadioGroup(
                RadioGroupData(
                    id: "g",
                    name: "g",
                    selectedValue: "b",
                    options: [RadioData(id: "a"), RadioData(id: "b")]
                )
            ).render()
        )
        #expect(count(of: " checked", in: html) == 1)
    }

    @Test("no match selects nothing and option isSelected is ignored")
    func noMatch() {
        let html = renderHTML(
            RadioGroup(
                RadioGroupData(
                    id: "plan",
                    name: "plan",
                    selectedValue: "unknown",
                    options: [RadioData(id: "x", value: "x", isSelected: true)]
                )
            ).render()
        )
        #expect(!hasCheckedAttribute(html))
    }

    @Test("only the first of duplicate values is checked")
    func duplicateValues() {
        let html = renderHTML(
            RadioGroup(
                RadioGroupData(
                    id: "g",
                    name: "g",
                    selectedValue: "same",
                    options: [
                        RadioData(id: "a", value: "same"),
                        RadioData(id: "b", value: "same"),
                    ]
                )
            ).render()
        )
        #expect(count(of: " checked", in: html) == 1)
    }

    @Test("group state disables every option")
    func groupDisabled() {
        let html = renderHTML(
            RadioGroup(
                RadioGroupData(id: "plan", name: "plan", options: plans, state: .disabled)
            ).render()
        )
        let inputs = html.components(separatedBy: "<input").dropFirst()
        #expect(inputs.count == 3)
        #expect(inputs.allSatisfy { hasDisabledAttribute($0) })
        #expect(!html.contains("hover:ring-2"))
    }

    @Test("option state disables only that option")
    func optionDisabled() {
        let html = renderHTML(
            RadioGroup(
                RadioGroupData(
                    id: "plan",
                    name: "plan",
                    options: [
                        RadioData(id: "a", label: "A"),
                        RadioData(id: "b", label: "B", state: .disabled),
                    ]
                )
            ).render()
        )
        let inputs = html.components(separatedBy: "<input").dropFirst()
        #expect(inputs.count == 2)
        #expect(inputs.filter { hasDisabledAttribute($0) }.count == 1)
    }

    @Test("group helper and error are wired to the fieldset and rendered before the options")
    func helperAndError() {
        let html = renderHTML(
            RadioGroup(
                RadioGroupData(
                    id: "plan",
                    name: "plan",
                    options: plans,
                    errorMessages: ErrorMessageData(errorMessages: ["Select a plan."]),
                    helperText: HelperTextData(id: "plan-h", text: "You can change it later.")
                )
            ).render()
        )
        #expect(html.contains("aria-describedby=\"plan-h-helper plan-error\""))
        #expect(html.contains("id=\"plan-h-helper\""))
        #expect(html.contains("id=\"plan-error\""))
        #expect(count(of: "aria-invalid=\"true\"", in: html) == 3)

        let firstInput = html.range(of: "<input")?.lowerBound
        let helper = html.range(of: "You can change it later.")?.lowerBound
        let error = html.range(of: "Select a plan.")?.lowerBound
        #expect(helper != nil && error != nil && firstInput != nil)
        if let helper, let error, let firstInput {
            #expect(helper < firstInput)
            #expect(error < firstInput)
        }
    }

    @Test("plain group has no aria-describedby and no aria-invalid")
    func plainGroup() {
        let html = renderHTML(
            RadioGroup(RadioGroupData(id: "plan", name: "plan", options: plans)).render()
        )
        #expect(!html.contains("aria-describedby"))
        #expect(!html.contains("aria-invalid"))
    }

    @Test("option error messages are not rendered inside a group")
    func optionErrorIgnored() {
        let html = renderHTML(
            RadioGroup(
                RadioGroupData(
                    id: "g",
                    name: "g",
                    options: [
                        RadioData(
                            id: "a",
                            errorMessages: ErrorMessageData(errorMessages: ["nope"])
                        )
                    ]
                )
            ).render()
        )
        #expect(!html.contains("nope"))
    }

    @Test("option helper text is kept")
    func optionHelperKept() {
        let html = renderHTML(
            RadioGroup(
                RadioGroupData(
                    id: "g",
                    name: "g",
                    options: [
                        RadioData(
                            id: "a",
                            label: "A",
                            helperText: HelperTextData(id: "ha", text: "Option help")
                        )
                    ]
                )
            ).render()
        )
        #expect(html.contains("Option help"))
        #expect(html.contains("aria-describedby=\"ha-helper\""))
    }

    @Test("empty options render the fieldset without crashing")
    func emptyOptions() {
        let html = renderHTML(
            RadioGroup(RadioGroupData(id: "g", name: "g", options: [])).render()
        )
        #expect(html.contains("<fieldset"))
        #expect(!html.contains("<input"))
    }
}
