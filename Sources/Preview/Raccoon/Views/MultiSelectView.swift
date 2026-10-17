import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct MultiSelectView: TemplateRepresentable {

    let variants: [(String, MultiSelectData)] = [
        (
            """
            // .enabled
            """,
            MultiSelectData(
                id: "multi-1",
                name: "techs",
                label: LabelData(
                    id: "multi-1",
                    title: "Technologies"
                ),
                placeholder: "placeholder",
                values: ["vapor", "html"],
                options: DemoData.optionList,
                state: .enabled,
                helperText: HelperTextData(
                    id: "hlp-1",
                    text: "helper-text-1"
                )
            )
        ),
        (
            """
            // .enabled + error
            """,
            MultiSelectData(
                id: "multi-3",
                name: "techs",
                label: LabelData(
                    id: "multi-3",
                    title: "Technologies"
                ),
                placeholder: "placeholder",
                values: ["vapor"],
                options: DemoData.optionList,
                state: .enabled,
                errorMessages: ErrorMessageData(
                    id: "err-1",
                    errorMessages: ["error one"],
                    hasIcon: false
                )
            )
        ),
        (
            """
            // .info
            """,
            MultiSelectData(
                id: "multi-41",
                name: "techs",
                label: LabelData(
                    id: "multi-41",
                    title: "Technologies"
                ),
                placeholder: "placeholder",
                values: ["vapor"],
                options: DemoData.optionList,
                state: .info
            )
        ),
        (
            """
            // .info + background
            """,
            MultiSelectData(
                id: "multi-43",
                name: "techs",
                label: LabelData(
                    id: "multi-43",
                    title: "Technologies"
                ),
                placeholder: "placeholder",
                values: ["vapor"],
                options: DemoData.optionList,
                state: .info,
                backgroundColor: "#7e43ac"
            )
        ),
        (
            """
            // .disabled + backgroundColor
            """,
            MultiSelectData(
                id: "multi-51",
                name: "techs",
                label: LabelData(
                    id: "multi-51",
                    title: "Technologies"
                ),
                placeholder: "placeholder",
                values: ["vapor"],
                options: DemoData.optionList,
                state: .disabled,
                backgroundColor: "#7e43ac"
            )
        ),
        (
            """
            // .disabled 
            """,
            MultiSelectData(
                id: "multi-52",
                name: "techs",
                label: LabelData(
                    id: "multi-52",
                    title: "Technologies"
                ),
                placeholder: "placeholder",
                values: ["vapor"],
                options: DemoData.optionList,
                state: .disabled
            )
        ),
    ]

    func makeHtml(ctx: MultiSelectData) -> String {
        let html = renderFragments(MultiSelect(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("MultiSelect")

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { MultiSelect(ctx).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
