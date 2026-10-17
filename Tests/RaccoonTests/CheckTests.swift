import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("Check")
struct CheckTests {

    @Test("renders checkbox input element")
    func rendersInputElement() async throws {

        let html = renderHTML(
            Check(CheckData(id: "accept", name: "accept"))
                .render()
        )
        #expect(html.contains("<input"))
        #expect(html.contains("type=\"checkbox\""))
    }

    @Test("renders label text when provided")
    func rendersLabel() async throws {

        let html = renderHTML(
            Check(
                CheckData(
                    id: "terms",
                    label: "I agree to the terms",
                    name: "terms"
                )
            )
            .render()
        )
        #expect(html.contains("I agree to the terms"))
    }

    @Test("renders checked state")
    func rendersCheckedState() async throws {

        let html = renderHTML(
            Check(
                CheckData(
                    id: "checked-box",
                    name: "checked-box",
                    isSelected: true
                )
            )
            .render()
        )
        #expect(html.contains("checked"))
    }

    @Test("renders with error state context (no crash)")
    func rendersWithErrorContext() async throws {

        let error = ErrorMessageData(
            errorMessages: ["You must accept the terms."]
        )
        let html = renderHTML(
            Check(
                CheckData(id: "cb", name: "cb", errorMessages: error)
            )
            .render()
        )
        // Component renders even when errorMessages context is provided
        #expect(html.contains("cb"))
    }

    @Test("renders error message text and wires aria-describedby to it")
    func rendersErrorMessageTextAndAriaDescribedBy() async throws {

        let error = ErrorMessageData(
            errorMessages: ["You must accept the terms."]
        )
        let html = renderHTML(
            Check(
                CheckData(id: "cb-err", name: "cb-err", errorMessages: error)
            )
            .render()
        )

        #expect(html.contains("You must accept the terms."))
        #expect(html.contains("aria-describedby=\"cb-err-error\""))
        #expect(html.contains("id=\"cb-err-error\""))
    }

    @Test(
        "wires aria-describedby to both helper text and error message ids when both are provided"
    )
    func wiresAriaDescribedByToHelperAndError() async throws {

        let helper = HelperTextData(
            id: "cb-both-helper-data",
            text: "Helper info"
        )
        let error = ErrorMessageData(
            errorMessages: ["Required field."]
        )
        let html = renderHTML(
            Check(
                CheckData(
                    id: "cb-both",
                    name: "cb-both",
                    errorMessages: error,
                    helperText: helper
                )
            )
            .render()
        )

        #expect(
            html.contains("aria-describedby=\"cb-both-helper cb-both-error\"")
        )
    }

    @Test("handles empty label and name")
    func handlesEmptyLabelAndName() async throws {
        let html = renderHTML(
            Check(
                CheckData(id: "cb-empty", label: "", name: "")
            )
            .render()
        )
        #expect(html.contains("<input"))
    }

    @Test("handles nil label and name")
    func handlesNilLabelAndName() async throws {
        let html = renderHTML(
            Check(
                CheckData(id: "cb-nil")
            )
            .render()
        )
        #expect(html.contains("<input"))
    }

    @Test("handles long label")
    func handlesLongLabel() async throws {
        let longLabel = String(repeating: "A", count: 1000)
        let html = renderHTML(
            Check(
                CheckData(id: "cb-long", label: longLabel)
            )
            .render()
        )
        #expect(html.contains(longLabel))
    }

    @Test("renders disabled state attributes and classes")
    func rendersDisabledState() async throws {

        let html = renderHTML(
            Check(
                CheckData(
                    id: "cb-disabled",
                    label: "Disabled Checkbox",
                    state: .disabled
                )
            )
            .render()
        )
        #expect(html.contains("disabled"))
        #expect(html.contains("cursor-not-allowed"))
    }

    @Test("renders helper text when provided")
    func rendersHelperText() async throws {

        let helper = HelperTextData(id: "cb-help", text: "Important guidance")
        let html = renderHTML(
            Check(
                CheckData(
                    id: "cb-helper",
                    label: "Option",
                    helperText: helper
                )
            )
            .render()
        )
        #expect(html.contains("Important guidance"))
    }
}
