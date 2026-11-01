import HTML
import Raccoon
import SGML
import WebBuilders

struct RadioView: TemplateRepresentable {

    let variants: [PreviewVariant<RadioData>] = [
        #previewVariant(
            """
            // Default
            """,
            RadioData(id: "radio-1", label: "Accept terms")
        ),
        #previewVariant(
            """
            // Selected
            """,
            RadioData(id: "radio-2", label: "Accept terms", isSelected: true)
        ),
        #previewVariant(
            """
            // Disabled
            """,
            RadioData(id: "radio-3", label: "Accept terms", state: .disabled)
        ),
        #previewVariant(
            """
            // Disabled and selected
            """,
            RadioData(
                id: "radio-4",
                label: "Accept terms",
                state: .disabled,
                isSelected: true
            )
        ),
        #previewVariant(
            """
            // Helper text
            """,
            RadioData(
                id: "radio-5",
                label: "Accept terms",
                helperText: HelperTextData(id: "radio-5", text: "helper text")
            )
        ),
        #previewVariant(
            """
            // Error
            """,
            RadioData(
                id: "radio-6",
                label: "Accept terms",
                errorMessages: ErrorMessageData(
                    id: "radio-6",
                    errorMessages: ["error one"],
                    hasIcon: true
                ),
                helperText: HelperTextData(id: "radio-6", text: "helper text")
            )
        ),
    ]

    func makeHtml(ctx: RadioData) -> String {
        let html = renderFragments(Radio(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Radio")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { Radio(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
