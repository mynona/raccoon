import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct SingleSelectView: TemplateRepresentable {

    let variants: [(String, SingleSelectData)] = [
        (
            """
            // state = .enabled
            """,
            SingleSelectData(
                id: "select-1",
                name: "select-name-for-forms",
                label: LabelData(
                    id: "select-1",
                    title: "Choose option"
                ),
                placeholder: "select-placeholder",
                options: DemoData.optionList,
                errorMessages: nil,
                helperText: HelperTextData(
                    id: "hlp-1",
                    text: "helper-text-1"
                ),
                state: .enabled,
                backgroundColor: nil,
            )
        ),
        (
            """
            // state = .enabled
            """,
            SingleSelectData(
                id: "select-2",
                name: "select-name-for-forms",
                label: LabelData(
                    id: "select-2",
                    title: "Choose option"
                ),
                placeholder: "select-placeholder",
                options: DemoData.optionList,
                errorMessages: ErrorMessageData(
                    id: "err-2",
                    errorMessages: ["error-one"],
                    hasIcon: false
                ),
                helperText: HelperTextData(
                    id: "hlp-2",
                    text: "helper-text-1"
                ),
                state: .enabled,
                backgroundColor: nil,
            )
        ),
        (
            """
            // backgroundColor
            """,
            SingleSelectData(
                id: "select-3",
                name: "select-name-for-forms",
                label: LabelData(
                    id: "select-3",
                    title: "Choose option"
                ),
                placeholder: "select-placeholder",
                options: DemoData.optionList,
                errorMessages: nil,
                helperText: nil,
                state: .enabled,
                backgroundColor: "#4365fc",
            )
        ),
        (
            """
            // state: .disabled
            """,
            SingleSelectData(
                id: "select-4",
                name: "select-name-for-forms",
                label: LabelData(
                    id: "select-4",
                    title: "Choose option"
                ),
                placeholder: "select-placeholder",
                options: DemoData.optionList,
                errorMessages: nil,
                helperText: nil,
                state: .disabled,
                backgroundColor: nil,
            )
        ),
        (
            """
            // state: .info
            """,
            SingleSelectData(
                id: "select-5",
                name: "select-name-for-forms",
                label: LabelData(
                    id: "select-5",
                    title: "Choose option"
                ),
                placeholder: "select-placeholder",
                options: DemoData.optionList,
                errorMessages: nil,
                helperText: nil,
                state: .info,
                backgroundColor: nil,
            )
        ),
        (
            """
            // no label + no name + no title + no placeholder
            """,
            SingleSelectData(
                id: "select-6",
                name: nil,
                label: nil,
                placeholder: nil,
                options: DemoData.optionList,
                errorMessages: nil,
                helperText: nil,
                state: .enabled,
                backgroundColor: nil,
            )
        ),
        (
            """
            // value set in backend but does not match any value in 
            // the option list, then no option is selected
            """,
            SingleSelectData(
                id: "select-7",
                name: "select-name-for-forms",
                label: LabelData(
                    id: "select-7",
                    title: "Choose option"
                ),
                placeholder: "select-placeholder",
                value: "blabla",
                options: DemoData.optionList,
                errorMessages: nil,
                helperText: HelperTextData(
                    id: "hlp-7",
                    text: "helper-text-1"
                ),
                state: .enabled,
                backgroundColor: nil,
            )
        ),
        (
            """
            // value set in backend with a correct value
            """,
            SingleSelectData(
                id: "select-8",
                name: "select-name-for-forms",
                label: LabelData(
                    id: "select-8",
                    title: "Choose option"
                ),
                placeholder: "select-placeholder",
                value: "a",
                options: DemoData.optionList,
                errorMessages: nil,
                helperText: HelperTextData(
                    id: "hlp-8",
                    text: "helper-text-1"
                ),
                state: .enabled,
                backgroundColor: nil,
            )
        ),
    ]

    func makeHtml(ctx: SingleSelectData) -> String {
        let html = renderFragments(SingleSelect(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("SingleSelect")

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { SingleSelect(ctx).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
