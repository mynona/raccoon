import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("TextAreaField")
struct TextAreaFieldTests {

    @Test("renders textarea element")
    func rendersTextareaElement() async throws {

        let html = renderHTML(
            TextAreaField(
                TextAreaFieldData(
                    id: "description",
                    label: LabelData(
                        id: "description",
                        title: "Description"
                    )
                )
            )
            .render()
        )
        #expect(html.contains("<textarea"))
    }

    @Test("renders label text")
    func rendersLabel() async throws {

        let html = renderHTML(
            TextAreaField(
                TextAreaFieldData(
                    id: "summary",
                    label: LabelData(id: "summary", title: "Summary")
                )
            )
            .render()
        )
        #expect(html.contains("Summary"))
    }

    @Test("renders pre-filled value")
    func rendersValue() async throws {

        let html = renderHTML(
            TextAreaField(
                TextAreaFieldData(
                    id: "body",
                    label: LabelData(id: "body", title: "Body"),
                    value: "Existing body text."
                )
            )
            .render()
        )
        #expect(html.contains("Existing body text."))
    }

    @Test(
        "aria-describedby references label, helper text and both error containers"
    )
    func ariaDescribedByReferencesAllContainers() async throws {

        let html = renderHTML(
            TextAreaField(
                TextAreaFieldData(
                    id: "bio",
                    label: LabelData(id: "bio", title: "Bio"),
                    errorMessages: ErrorMessageData(
                        errorMessages: ["Too long."]
                    ),
                    helperText: HelperTextData(
                        id: "bio-help",
                        text: "Keep it short"
                    )
                )
            )
            .render()
        )
        #expect(
            html.contains(
                "aria-describedby=\"label-bio bio-help-helper bio-local-error bio-server-error\""
            )
        )
        #expect(html.contains("id=\"bio-local-error\""))
        #expect(html.contains("id=\"bio-server-error\""))
    }

    @Test(
        "aria-describedby omits the server-error id when there is no server error"
    )
    func ariaDescribedByOmitsServerErrorWhenAbsent() async throws {

        let html = renderHTML(
            TextAreaField(
                TextAreaFieldData(
                    id: "bio",
                    label: LabelData(id: "bio", title: "Bio")
                )
            )
            .render()
        )
        #expect(html.contains("aria-describedby=\"label-bio bio-local-error\""))
        #expect(
            !html.contains(
                "aria-describedby=\"label-bio bio-local-error bio-server-error\""
            )
        )
    }

    @Test("renders validation Alpine config")
    func rendersValidationAlpineConfig() async throws {

        let html = renderHTML(
            TextAreaField(
                TextAreaFieldData(
                    id: "summary",
                    label: LabelData(id: "summary", title: "Summary"),
                    value: "Existing body text.",
                    validation: .custom(
                        pattern: "^[A-Z].+$",
                        message: "Needs capitalized text"
                    )
                )
            )
            .render()
        )
        // Regression: single-quoted JS literals, since the renderer doesn't escape double quotes
        // inside double-quoted HTML attribute values.
        #expect(html.contains("textAreaFieldAlpine({regexPattern: '^[A-Z].+$'"))
        #expect(html.contains("errorMessage: 'Needs capitalized text'"))
        #expect(html.contains("hasInitialValue: true"))
        #expect(html.contains("/js/text-area-field.js"))
    }

    @Test("renders helper text and helper description")
    func rendersHelperTextAndDescription() async throws {

        let html = renderHTML(
            TextAreaField(
                TextAreaFieldData(
                    id: "notes",
                    label: LabelData(id: "notes", title: "Notes"),
                    helperText: HelperTextData(
                        id: "notes-help",
                        text: "Add public notes"
                    )
                )
            )
            .render()
        )
        #expect(html.contains("Add public notes"))
        #expect(html.contains("aria-describedby"))
    }

    @Test("renders server error wiring")
    func rendersServerErrorWiring() async throws {

        let html = renderHTML(
            TextAreaField(
                TextAreaFieldData(
                    id: "details",
                    label: LabelData(id: "details", title: "Details"),
                    errorMessages: ErrorMessageData(
                        id: "details-error",
                        errorMessages: ["Too long"],
                        hasIcon: false
                    )
                )
            )
            .render()
        )
        #expect(html.contains("Too long"))
        #expect(html.contains("hasServerError: true"))
        #expect(html.contains("x-show=\"!isTouched\""))
    }

    @Test("renders monospace font class when isMonospaced is true")
    func rendersMonospaced() async throws {

        let html = renderHTML(
            TextAreaField(
                TextAreaFieldData(
                    id: "code-input",
                    isMonospaced: true
                )
            )
            .render()
        )
        #expect(html.contains("font-mono"))
    }

    @Test("renders required attribute when label indicates required")
    func rendersRequiredAttribute() async throws {

        let html = renderHTML(
            TextAreaField(
                TextAreaFieldData(
                    id: "mandatory-comment",
                    label: LabelData(
                        id: "mandatory-comment",
                        title: "Mandatory",
                        isRequired: true
                    )
                )
            )
            .render()
        )
        #expect(html.contains("required"))
    }
}
