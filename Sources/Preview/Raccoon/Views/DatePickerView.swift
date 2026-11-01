import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct DatePickerView: TemplateRepresentable {

    let variants: [PreviewVariant<DatePickerData>] = [
        #previewVariant(
            """
            // DatePicker (Single Date)
            """,
            DatePickerData(
                id: "date1",
                label: LabelData(
                    id: "date-label-1",
                    title: "Appointment Date"
                ),
                value: Date(),
                state: .enabled,
                errorMessages: nil,
                backgroundColor: nil
            )
        ),
        #previewVariant(
            """
            // DatePicker (Date Range)
            """,
            DatePickerData(
                id: "date2",
                endId: "date2_end",
                label: LabelData(
                    id: "date-label-2",
                    title: "Vacation Period (Date Range)"
                ),
                value: Date(),
                endValue: Date().addingTimeInterval(86400 * 14),
                format: .DD_MM_YYYY,
                state: .enabled,
                errorMessages: nil,
                isRange: true,
                backgroundColor: nil
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

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { DatePicker(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
