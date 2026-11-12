import HTML
import Raccoon
import SGML
import WebBuilders

/// Page to check the validation of the `FormBuilder` against a real server round trip, either with
/// the error summary or with submit validation. Each method has its own page.
///
/// Submitting posts to `FormErrorSummaryController`, which validates on the server and renders
/// this page again with the values kept and the errors set.
struct FormErrorSummaryView: TemplateRepresentable {

    static func slug(for method: FormValidationMethod) -> String {
        method == .submit ? "form-submit-validation" : "form-error-summary"
    }

    static func path(for method: FormValidationMethod) -> String {
        "/preview/\(slug(for: method))"
    }

    let context: FormErrorSummaryContext

    init(_ context: FormErrorSummaryContext) {
        self.context = context
    }

    private var path: String { Self.path(for: context.validationMethod) }

    private var title: String {
        context.validationMethod == .submit
            ? "FormBuilder (submit validation)" : "FormBuilder (error summary)"
    }

    private var formErrors: ErrorMessageData? {
        guard let formError = context.formError else { return nil }
        return ErrorMessageData(
            errorMessages: [LocalizedText(verbatim: formError)]
        )
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic(title: title) {

            Div {

                showComponentTitle(title)

                if context.isSaved {
                    Notification(
                        NotificationData(
                            title: "Saved",
                            text: "The server accepted the submission.",
                            type: .success
                        )
                    )
                    .render()
                }

                Div {
                    FormBuilder(
                        FormBuilderData(
                            id: "error-summary-demo",
                            action: path,
                            csrfToken: context.csrfToken,
                            fields: formFieldsErrorSummary(
                                values: context.values,
                                errors: context.errors,
                                validationMethod: context.validationMethod
                            ),
                            actions: [
                                .button(
                                    ActionButtonData(
                                        label: "Save",
                                        htmlType: .submit,
                                        buttonType: .primary,
                                        hasFullWidth: false,
                                        contentTracker: MatomoContentTracker(
                                            name: "preview-error-summary",
                                            piece: "button.save",
                                            target: ""
                                        )
                                    )
                                ),
                                .link(
                                    LinkButtonData(
                                        label: "Reset",
                                        href: path,
                                        buttonType: .secondary,
                                        hasFullWidth: false,
                                        contentTracker: MatomoContentTracker(
                                            name: "preview-error-summary",
                                            piece: "button.reset",
                                            target: path
                                        )
                                    )
                                ),
                            ],
                            errorMessages: formErrors,
                            validationMethod: context.validationMethod
                        )
                    )
                    .render()
                }
                .class("mb-4 mt-8 max-w-2xl")

            }
            .class("mt-4 space-y-6")

        }
        .render()
    }
}
