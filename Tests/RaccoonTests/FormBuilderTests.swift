import HTML
import SGML
import Testing
import WebBuilders

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

private func position(of text: String, in html: String) -> Int? {
    html.range(of: text).map { html.distance(from: html.startIndex, to: $0.lowerBound) }
}

private func tracker(_ piece: String) -> MatomoContentTracker {
    MatomoContentTracker(name: "test", piece: piece, target: "")
}

@Suite("FormBuilder")
struct FormBuilderTests {

    @Test("renders a form with id, name, method, novalidate and tracking name")
    func rendersFormAttributes() {
        let html = renderHTML(
            FormBuilder(FormBuilderData(id: "registration.step1")).render()
        )
        #expect(html.contains("<form"))
        #expect(html.contains("id=\"registration.step1\""))
        #expect(html.contains("name=\"registration.step1\""))
        #expect(html.contains("method=\"post\""))
        #expect(html.contains("novalidate"))
        #expect(html.contains("data-matomo-name=\"registration.step1\""))
    }

    @Test("omits the tracking name when isTracked is false")
    func omitsTrackingName() {
        let html = renderHTML(
            FormBuilder(FormBuilderData(id: "f", isTracked: false)).render()
        )
        #expect(!html.contains("data-matomo-name"))
    }

    @Test("sets action only when given")
    func rendersAction() {
        let without = renderHTML(
            FormBuilder(FormBuilderData(id: "f")).render()
        )
        let with = renderHTML(
            FormBuilder(FormBuilderData(id: "f", action: "/auth2/validate-email/"))
                .render()
        )
        #expect(!without.contains("action="))
        #expect(with.contains("action=\"/auth2/validate-email/\""))
    }

    @Test("renders the csrf token as hidden field only when set")
    func rendersCsrfToken() {
        let with = renderHTML(
            FormBuilder(FormBuilderData(id: "f", csrfToken: "tok_123")).render()
        )
        let without = renderHTML(
            FormBuilder(FormBuilderData(id: "f")).render()
        )
        #expect(with.contains("type=\"hidden\""))
        #expect(with.contains("name=\"X-CSRF-Token\""))
        #expect(with.contains("tok_123"))
        #expect(!without.contains("X-CSRF-Token"))
    }

    @Test("renders fields in the given order")
    func rendersFieldsInOrder() throws {
        let html = renderHTML(
            FormBuilder(
                FormBuilderData(
                    id: "f",
                    fields: [
                        .input(InputFieldData(id: "second_field")),
                        .check(CheckData(id: "first_field", name: "first_field")),
                        .hidden(HiddenFieldData(id: "third_field", value: "x")),
                    ]
                )
            ).render()
        )
        let second = try #require(position(of: "name=\"second_field\"", in: html))
        let first = try #require(position(of: "name=\"first_field\"", in: html))
        let third = try #require(position(of: "name=\"third_field\"", in: html))
        #expect(second < first)
        #expect(first < third)
    }

    @Test("sets multipart enctype for file uploads, also when nested")
    func setsMultipartEnctype() {
        let upload = FormField.singleFileUpload(SingleFileUploadData(id: "image"))
        let multiple = FormField.multipleFileUpload(
            MultipleFileUploadData(id: "images")
        )
        let direct = renderHTML(
            FormBuilder(FormBuilderData(id: "f", fields: [upload])).render()
        )
        let inGroup = renderHTML(
            FormBuilder(
                FormBuilderData(
                    id: "f",
                    fields: [.group(FormGroupData(legend: "Files", fields: [multiple]))]
                )
            ).render()
        )
        let inRow = renderHTML(
            FormBuilder(FormBuilderData(id: "f", fields: [.row([upload])])).render()
        )
        let none = renderHTML(
            FormBuilder(
                FormBuilderData(id: "f", fields: [.input(InputFieldData(id: "a"))])
            ).render()
        )
        #expect(direct.contains("enctype=\"multipart/form-data\""))
        #expect(inGroup.contains("enctype=\"multipart/form-data\""))
        #expect(inRow.contains("enctype=\"multipart/form-data\""))
        #expect(!none.contains("enctype"))
    }

    @Test("renders a group as fieldset with a screen reader only legend by default")
    func rendersHiddenLegend() {
        let html = renderHTML(
            FormBuilder(
                FormBuilderData(
                    id: "f",
                    fields: [
                        .group(
                            FormGroupData(
                                id: "contact",
                                legend: "Your contact details",
                                fields: [.input(InputFieldData(id: "email"))]
                            )
                        )
                    ]
                )
            ).render()
        )
        #expect(html.contains("<fieldset"))
        #expect(html.contains("id=\"contact\""))
        #expect(html.contains("<legend"))
        #expect(html.contains("Your contact details"))
        #expect(html.contains("sr-only"))
    }

    @Test("shows the legend when isLegendVisible is true")
    func rendersVisibleLegend() {
        let html = renderHTML(
            FormBuilder(
                FormBuilderData(
                    id: "f",
                    fields: [
                        .group(
                            FormGroupData(
                                legend: "Visible",
                                fields: [],
                                isLegendVisible: true
                            )
                        )
                    ]
                )
            ).render()
        )
        #expect(html.contains("Visible"))
        #expect(!html.contains("sr-only"))
    }

    @Test("renders a row around its fields")
    func rendersRow() {
        let html = renderHTML(
            FormBuilder(
                FormBuilderData(
                    id: "f",
                    fields: [
                        .row([
                            .input(InputFieldData(id: "first_name")),
                            .input(InputFieldData(id: "last_name")),
                        ])
                    ]
                )
            ).render()
        )
        #expect(html.contains(FormBuilderStyles.row))
        #expect(html.contains("name=\"first_name\""))
        #expect(html.contains("name=\"last_name\""))
    }

    @Test("renders button and link actions in the given order")
    func rendersActions() throws {
        let html = renderHTML(
            FormBuilder(
                FormBuilderData(
                    id: "f",
                    actions: [
                        .button(
                            ActionButtonData(
                                label: "Proceed",
                                buttonType: .primary,
                                contentTracker: tracker("button.proceed")
                            )
                        ),
                        .link(
                            LinkButtonData(
                                label: "Already registered?",
                                href: "/auth2/login",
                                buttonType: .tertiary,
                                contentTracker: tracker("link.login")
                            )
                        ),
                    ]
                )
            ).render()
        )
        let button = try #require(position(of: "Proceed", in: html))
        let link = try #require(position(of: "Already registered?", in: html))
        #expect(html.contains("type=\"submit\""))
        #expect(html.contains("href=\"/auth2/login\""))
        #expect(button < link)
    }

    @Test("renders no action bar without actions")
    func rendersNoActionBar() {
        let html = renderHTML(
            FormBuilder(FormBuilderData(id: "f")).render()
        )
        #expect(!html.contains(FormBuilderStyles.actionsPage))
    }

    @Test("aligns the actions to the trailing edge in a dialog")
    func rendersDialogLayout() {
        let actions: [FormAction] = [
            .button(
                ActionButtonData(
                    label: "Save",
                    buttonType: .primary,
                    contentTracker: tracker("button.save")
                )
            )
        ]
        let dialog = renderHTML(
            FormBuilder(
                FormBuilderData(id: "f", actions: actions, layout: .dialog)
            ).render()
        )
        let page = renderHTML(
            FormBuilder(FormBuilderData(id: "f", actions: actions)).render()
        )
        #expect(dialog.contains(FormBuilderStyles.actionsDialog))
        #expect(page.contains(FormBuilderStyles.actionsPage))
    }

    @Test("renders form-level error messages above the fields")
    func rendersFormErrors() throws {
        let html = renderHTML(
            FormBuilder(
                FormBuilderData(
                    id: "f",
                    fields: [.input(InputFieldData(id: "email"))],
                    errorMessages: ErrorMessageData(
                        errorMessages: ["Sign in failed"]
                    )
                )
            ).render()
        )
        let error = try #require(position(of: "Sign in failed", in: html))
        let field = try #require(position(of: "name=\"email\"", in: html))
        #expect(html.contains("role=\"alert\""))
        #expect(error < field)
    }

    @Test("renders custom templates")
    func rendersCustomTemplate() {
        struct Custom: TemplateRepresentable, Sendable {
            @Builder<Element>
            func render() -> [Element] {
                P("custom content")
            }
        }
        let html = renderHTML(
            FormBuilder(
                FormBuilderData(id: "f", fields: [.custom(Custom())])
            ).render()
        )
        #expect(html.contains("custom content"))
    }

    @Test("sets the accessible name of the form")
    func rendersAriaLabel() {
        let html = renderHTML(
            FormBuilder(FormBuilderData(id: "f", ariaLabel: "Sign up")).render()
        )
        #expect(html.contains("aria-label=\"Sign up\""))
    }
}
