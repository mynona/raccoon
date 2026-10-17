import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct InputFieldView: TemplateRepresentable {

    let variants: [(String, InputFieldData)] = [
        (

            "// First & Last Name validation",
            InputFieldData(
                id: "fullname",
                label: LabelData(
                    id: "fullname",
                    title: "Full Name"
                ),
                placeholder: "Jane Doe",
                value: "John Doe",
                helperText: HelperTextData(
                    id: "hlp",
                    text: "Please enter your full name"
                ),
                validation: .firstLastName,
                type: .text
            )
        ),
        (
            "// Email validation",
            InputFieldData(
                id: "email",
                label: LabelData(id: "email", title: "Email"),
                placeholder: "jane@example.com",
                validation: .email,
                type: .email
            )
        ),
        (
            "// URL validation",
            InputFieldData(
                id: "website",
                label: LabelData(id: "website", title: "Website"),
                placeholder: "https://example.com",
                validation: .url,
                type: .url
            )
        ),
        (
            "// Integer validation",
            InputFieldData(
                id: "age",
                label: LabelData(id: "age", title: "Age"),
                placeholder: "18",
                validation: .integer,
                type: .number
            )
        ),
        (
            "// Amount validation",
            InputFieldData(
                id: "amount",
                label: LabelData(id: "amount", title: "Amount"),
                placeholder: "12.34",
                validation: .amount,
                type: .text
            )
        ),
        (
            "// Phone number validation",
            InputFieldData(
                id: "phone",
                label: LabelData(
                    id: "phone",
                    title: "Phone Number"
                ),
                placeholder: "+491234567890",
                validation: .phoneNumber,
                type: .tel
            )
        ),

        (
            "// IPv4 Address validation",
            InputFieldData(
                id: "ip",
                label: LabelData(id: "ip", title: "IPv4 Address"),
                placeholder: "192.168.0.1",
                validation: .ip4vAddress,
                type: .text
            )
        ),
        (
            "// Friendly URL validation",
            InputFieldData(
                id: "slug",
                label: LabelData(id: "slug", title: "Slug"),
                placeholder: "my-article",
                validation: .friendlyUrl,
                type: .text
            )
        ),
        (
            "// Custom validation: must be 'abc123'",
            InputFieldData(
                id: "custom",
                label: LabelData(
                    id: "custom",
                    title: "Custom Field"
                ),
                placeholder: "ABC-1234",
                validation: .custom(
                    pattern: "^[A-Z]{3}-\\d{4}$",
                    message: "Must match pattern ABC-1234"
                ),
                type: .text
            )
        ),
    ]

    func makeHtml(ctx: InputFieldData) -> String {
        let html = renderFragments(InputField(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("InputField")

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { InputField(ctx).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
