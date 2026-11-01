import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct CheckboxView: TemplateRepresentable {

    let variants: [PreviewVariant<CheckData>] = [
        #previewVariant(
            """
            //
            """,
            CheckData(
                id: "cb-1",
                label: "Accept terms",
                name: "name",
                isSelected: true,
                state: .enabled,
                errorMessages: nil,
                helperText: HelperTextData(
                    id: "helper-1",
                    text: "helper text"
                )
            )
        ),
        #previewVariant(
            """
            //
            """,
            CheckData(
                id: "cb-10",
                label: "Accept terms",
                name: "name",
                isSelected: false,
                state: .enabled,
                errorMessages: nil,
                helperText: nil
            )
        ),
        #previewVariant(
            """
            //
            """,
            CheckData(
                id: "cb-11",
                label: "Accept terms",
                name: "name",
                isSelected: true,
                state: .disabled,
                errorMessages: nil,
                helperText: nil
            )
        ),
        #previewVariant(
            """
            //
            """,
            CheckData(
                id: "cb-30",
                label: "Accept terms",
                name: "name",
                isSelected: false,
                state: .enabled,
                errorMessages: ErrorMessageData(
                    id: "error-1",
                    errorMessages: ["error one"],
                    hasIcon: true
                ),
                helperText: HelperTextData(
                    id: "helper-1-2",
                    text: "helper text"
                )
            )
        ),

    ]

    func makeHtml(ctx: CheckData) -> String {
        let html = renderFragments(Check(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Checkbox")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { Check(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
