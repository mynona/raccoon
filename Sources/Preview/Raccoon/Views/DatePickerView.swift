import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct DatePickerView: TemplateRepresentable {

    let variants: [(String, DatePickerData)] = [
        (
            """
            // .enabled
            """,
            DatePickerData(
                id: "date1",
                label: LabelData(
                    id: "date-label-1",
                    title: "date-label"
                ),
                value: Date(),
                state: .enabled,
                errorMessages: nil,
                backgroundColor: nil,
            )
        ),
        (
            """
            // .enabled + error
            """,
            DatePickerData(
                id: "date2",
                label: LabelData(
                    id: "date-label-2",
                    title: "date-label"
                ),
                value: Date(),
                state: .enabled,
                errorMessages: ErrorMessageData(
                    id: "err1",
                    errorMessages: ["error-one"],
                    hasIcon: true
                ),
                backgroundColor: nil,
            )
        ),
        (
            """
            // .enabled + backgroundColor
            """,
            DatePickerData(
                id: "date3",
                label: LabelData(
                    id: "date-label-3",
                    title: "date-label"
                ),
                value: Date(),
                state: .enabled,
                errorMessages: nil,
                backgroundColor: "#fecead",
            )
        ),
        // info
        (
            """
            // .info 
            """,
            DatePickerData(
                id: "date4",
                label: LabelData(
                    id: "date-label-4",
                    title: "date-label"
                ),
                value: Date(),
                state: .info,
                errorMessages: nil,
                backgroundColor: nil,
            )
        ),
        (
            """
            // .info + backgroundColor
            """,
            DatePickerData(
                id: "date5",
                label: LabelData(
                    id: "date-label-5",
                    title: "date-label"
                ),
                value: Date(),
                state: .info,
                errorMessages: nil,
                backgroundColor: "#fecead",
            )
        ),
        // disabled
        (
            """
            // .disabled 
            """,
            DatePickerData(
                id: "date6",
                label: LabelData(
                    id: "date-label-6",
                    title: "date-label"
                ),
                value: Date(),
                state: .disabled,
                errorMessages: nil,
                backgroundColor: nil,
            )
        ),
        (
            """
            // .disabled + backgroundColor
            """,
            DatePickerData(
                id: "date7",
                label: LabelData(
                    id: "date-label-7",
                    title: "date-label"
                ),
                value: Date(),
                state: .disabled,
                errorMessages: nil,
                backgroundColor: "#fecead",
            )
        ),
        (
            """
            // .enabled + format: .YYYY_MM_DD (ISO 8601)
            """,
            DatePickerData(
                id: "date8",
                label: LabelData(
                    id: "date-label-8",
                    title: "date-label (ISO 8601: YYYY-MM-DD)"
                ),
                value: Date(),
                format: .YYYY_MM_DD,
                state: .enabled,
                errorMessages: nil,
                backgroundColor: nil,
            )
        ),
        (
            """
            // .enabled + format: .DD_SLASH_MM_SLASH_YYYY (UK / Europe)
            """,
            DatePickerData(
                id: "date9",
                label: LabelData(
                    id: "date-label-9",
                    title: "date-label (DD/MM/YYYY)"
                ),
                value: Date(),
                format: .DD_SLASH_MM_SLASH_YYYY,
                state: .enabled,
                errorMessages: nil,
                backgroundColor: nil,
            )
        ),
        (
            """
            // .enabled + format: .MM_DD_YYYY (US)
            """,
            DatePickerData(
                id: "date10",
                label: LabelData(
                    id: "date-label-10",
                    title: "date-label (US: MM/DD/YYYY)"
                ),
                value: Date(),
                format: .MM_DD_YYYY,
                state: .enabled,
                errorMessages: nil,
                backgroundColor: nil,
            )
        ),
    ]

    func makeHtml(ctx: DatePickerData) -> String {
        let html = renderFragments(DatePicker(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("DatePicker")

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { DatePicker(ctx).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
