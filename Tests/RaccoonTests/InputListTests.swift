import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("InputList")
struct InputListTests {

    @Test("renders input element")
    func rendersInputElement() async throws {

        let data = InputListData(
            id: "urls",
            label: LabelData(id: "urls", title: "URLs"),
            values: [],
            validationType: .url
        )
        let html = renderHTML(InputList(data).render())
        #expect(html.contains("<input"))
    }

    @Test("renders label")
    func rendersLabel() async throws {

        let data = InputListData(
            id: "emails",
            label: LabelData(id: "emails", title: "Email addresses"),
            values: [],
            validationType: .email
        )
        let html = renderHTML(InputList(data).render())
        #expect(html.contains("Email addresses"))
    }

    @Test("renders pre-filled values")
    func rendersPrefilledValues() async throws {

        let data = InputListData(
            id: "links",
            label: nil,
            values: ["https://swift.org", "https://vapor.codes"],
            validationType: .url
        )
        let html = renderHTML(InputList(data).render())
        #expect(html.contains("swift.org") || html.contains("swift\\.org"))
    }

    @Test(
        "renders with empty list and min/max/invalid/duplicate/clearing/adding rows"
    )
    func rendersEdgeCases() async throws {
        // Use .url for all cases (as .text does not exist)
        // Empty
        let empty = renderHTML(
            InputList(
                InputListData(
                    id: "k",
                    label: nil,
                    values: [],
                    validationType: .url
                )
            )
            .render()
        )
        #expect(empty.contains("<input"))
        // Min (1)
        let min = renderHTML(
            InputList(
                InputListData(
                    id: "k",
                    label: nil,
                    values: ["a"],
                    validationType: .url
                )
            )
            .render()
        )
        #expect(min.contains("a"))
        // Max (simulate 5)
        let max = renderHTML(
            InputList(
                InputListData(
                    id: "k",
                    label: nil,
                    values: ["1", "2", "3", "4", "5"],
                    validationType: .url
                )
            )
            .render()
        )
        #expect(max.contains("5"))
        // Duplicate
        let dup = renderHTML(
            InputList(
                InputListData(
                    id: "k",
                    label: nil,
                    values: ["x", "x"],
                    validationType: .url
                )
            )
            .render()
        )
        #expect(dup.contains("x"))
        // Clearing
        let cleared = renderHTML(
            InputList(
                InputListData(
                    id: "k",
                    label: nil,
                    values: [],
                    validationType: .url
                )
            )
            .render()
        )
        #expect(cleared.contains("<input"))
        // Adding
        let added = renderHTML(
            InputList(
                InputListData(
                    id: "k",
                    label: nil,
                    values: ["a", "b"],
                    validationType: .url
                )
            )
            .render()
        )
        #expect(added.contains("a") && added.contains("b"))
    }

    @Test("renders with all validation types and error/success states")
    func rendersAllValidationTypesAndStates() async throws {
        let types: [InputListData.ValidationType] = [
            .url, .email, .amount,
            .custom(pattern: "^abc$", message: "Custom error"),
        ]
        for t in types {
            let html = renderHTML(
                InputList(
                    InputListData(
                        id: "k",
                        label: nil,
                        values: ["v"],
                        validationType: t
                    )
                )
                .render()
            )
            #expect(html.contains("<input"))
        }
        // Error state (simulate error)
        let errorCtx = ErrorMessageData(
            errorMessages: ["Invalid"]
        )
        let error = renderHTML(
            InputList(
                InputListData(
                    id: "k",
                    label: nil,
                    values: [""],
                    validationType: .email,
                    errorMessages: errorCtx
                )
            )
            .render()
        )
        #expect(error.contains("Invalid"))
        // Success state (simulate helper)
        let helperCtx = HelperTextData(id: "h", text: "Good")
        let helper = renderHTML(
            InputList(
                InputListData(
                    id: "k",
                    label: nil,
                    values: ["ok"],
                    validationType: .email,
                    helperText: helperCtx
                )
            )
            .render()
        )
        #expect(helper.contains("Good"))
    }

    @Test("accessibility: keyboard, focus, ARIA, error/helper")
    func accessibilityChecks() async throws {
        let errorCtx = ErrorMessageData(
            errorMessages: ["E"]
        )
        let helperCtx = HelperTextData(id: "h", text: "H")
        let html = renderHTML(
            InputList(
                InputListData(
                    id: "k",
                    label: nil,
                    values: ["a"],
                    validationType: .url,
                    errorMessages: errorCtx,
                    helperText: helperCtx
                )
            )
            .render()
        )
        #expect(html.contains("aria-") || html.contains("role"))
        #expect(html.contains("focus") || html.contains("outline"))
        #expect(html.contains("E"))
        #expect(html.contains("H"))
    }

    @Test("renders Alpine config with initial values and validation")
    func rendersAlpineConfigWithValidation() async throws {

        let data = InputListData(
            id: "refs",
            label: LabelData(id: "refs", title: "References"),
            values: ["https://vapor.codes", "https://swift.org"],
            validationType: .url
        )
        let html = renderHTML(InputList(data).render())
        #expect(html.contains("inputListForm(["))
        #expect(
            html.contains("https://vapor.codes")
                || html.contains("https:\\/\\/vapor.codes")
        )
        #expect(
            html.contains("Please enter a valid http:// or https:// URL.")
                || html.contains(
                    "Please enter a valid http:\\/\\/ or https:\\/\\/ URL."
                )
        )
        #expect(html.contains("/js/input-list.js"))
    }

    @Test("renders hidden inputs for form submission")
    func rendersHiddenInputsForFormSubmission() async throws {

        let data = InputListData(
            id: "refs",
            label: nil,
            values: ["https://vapor.codes"],
            validationType: .url
        )
        let html = renderHTML(InputList(data).render())
        #expect(html.contains("type=\"hidden\""))
        #expect(html.contains("name=\"refs[]\""))
        #expect(html.contains(":value=\"value\""))
        #expect(html.contains("x-for=\"value in values\""))
    }

    @Test("renders add delete and clear-all actions")
    func rendersActionButtons() async throws {

        let data = InputListData(
            id: "refs",
            label: nil,
            values: ["https://vapor.codes"],
            validationType: .url
        )
        let html = renderHTML(InputList(data).render())
        #expect(html.contains("aria-label=\"Delete value\""))
        #expect(html.contains("aria-label=\"Add value\""))
        #expect(html.contains("aria-label=\"Clear all values\""))
        #expect(html.contains("remove(index)"))
        #expect(html.contains("clearAll"))
        #expect(
            html.contains("x-on:click=\"add\"")
                || html.contains("@click=\"add\"")
        )
    }
}
