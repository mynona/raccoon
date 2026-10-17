import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct TextareaFieldView: TemplateRepresentable {

    let variants: [(String, TextAreaFieldData)] = [
        (
            """
            // .firstLastName
            """,
            TextAreaFieldData(
                id: "tf-1",
                label: LabelData(
                    id: "tf-1",
                    title: "Name",
                    isRequired: false
                ),
                placeholder: "Placeholder text",
                rows: 1,
                value:
                    """
                    John Doe
                    """,
                validation: .firstLastName,
                errorMessages: nil,
                helperText: HelperTextData(
                    id: "hlp1",
                    text: "Helper text"
                ),
                isMonospaced: false
            )
        ),
        (
            """
            // .email
            """,
            TextAreaFieldData(
                id: "tf-2",
                label: LabelData(
                    id: "tf-2",
                    title: "Email",
                    isRequired: true
                ),
                placeholder: "john.doe@example.com",
                rows: 1,
                value: nil,
                validation: .email,
                errorMessages: ErrorMessageData(
                    id: "err",
                    errorMessages: ["Test error 1", "Test error 2"],
                    hasIcon: true
                ),
                helperText: HelperTextData(
                    id: "hlp2",
                    text: "Helper text"
                ),
                isMonospaced: false
            )
        ),
        (
            """
            // .url
            """,
            TextAreaFieldData(
                id: "tf-3",
                label: LabelData(
                    id: "tf-3",
                    title: "URL",
                    isRequired: false
                ),
                placeholder: "https://example.com",
                rows: 1,
                value: nil,
                validation: .url,
                errorMessages: nil,
                helperText: HelperTextData(
                    id: "hlp3",
                    text:
                        "Enter a valid URL starting with http:// or https://"
                ),
                isMonospaced: false
            )
        ),
        (
            """
            // .integer
            """,
            TextAreaFieldData(
                id: "tf-4",
                label: LabelData(
                    id: "tf-4",
                    title: "Integer",
                    isRequired: false
                ),
                placeholder: "12345",
                rows: 2,
                value: nil,
                validation: .integer,
                errorMessages: nil,
                helperText: HelperTextData(
                    id: "hlp4",
                    text: "Enter an integer value"
                ),
                isMonospaced: false
            )
        ),
        (
            """
            // .amount
            """,
            TextAreaFieldData(
                id: "tf-5",
                label: LabelData(
                    id: "tf-5",
                    title: "Amount",
                    isRequired: false
                ),
                placeholder: "12.34",
                rows: 1,
                value: nil,
                validation: .amount,
                errorMessages: nil,
                helperText: HelperTextData(
                    id: "hlp5",
                    text: "Enter an amount with 2 decimals"
                ),
                isMonospaced: true
            )
        ),
        (
            """
            // .phoneNumber
            """,
            TextAreaFieldData(
                id: "tf-6",
                label: LabelData(
                    id: "tf-6",
                    title: "Phone Number",
                    isRequired: false
                ),
                placeholder: "+491234567890",
                rows: 1,
                value: nil,
                validation: .phoneNumber,
                errorMessages: nil,
                helperText: HelperTextData(
                    id: "hlp6",
                    text: "Enter a phone number in E.164 format"
                ),
                isMonospaced: false
            )
        ),
        (
            """
            // .ip4vAddress
            """,
            TextAreaFieldData(
                id: "tf-7",
                label: LabelData(
                    id: "tf-7",
                    title: "IPv4 Address",
                    isRequired: false
                ),
                placeholder: "192.168.0.1",
                rows: 1,
                value: nil,
                validation: .ip4vAddress,
                errorMessages: nil,
                helperText: HelperTextData(
                    id: "hlp7",
                    text: "Enter a valid IPv4 address"
                ),
                isMonospaced: true
            )
        ),
        (
            """
            // .custom
            """,
            TextAreaFieldData(
                id: "tf-8",
                label: LabelData(
                    id: "tf-8",
                    title: "Custom Pattern",
                    isRequired: false
                ),
                placeholder: "ABC-1234",
                rows: 8,
                value: nil,
                validation: .custom(
                    pattern: "^[A-Z]{3}-\\d{4}$",
                    message: "Must match pattern ABC-1234"
                ),
                errorMessages: nil,
                helperText: HelperTextData(
                    id: "hlp8",
                    text: "Format: ABC-1234"
                ),
                isMonospaced: false
            )
        ),
    ]

    func makeHtml(ctx: TextAreaFieldData) -> String {
        let html = renderFragments(TextAreaField(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("TextAreaField")

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { TextAreaField(ctx).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
