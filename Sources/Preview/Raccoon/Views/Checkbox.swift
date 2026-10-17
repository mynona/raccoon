import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct CheckboxView: TemplateRepresentable {

    let variants: [(String, CheckData)] = [
        (
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
        (
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
        (
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
        (
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

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { Check(ctx).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
