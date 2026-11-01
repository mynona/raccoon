import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct DatePickerView: TemplateRepresentable {

    let variants: [PreviewVariant<DatePickerData>] = [
        #previewVariant(
            tr(
                "Single Date",
                [
                    "de": "Einzelnes Datum",
                    "fr": "Date unique",
                    "es": "Fecha única",
                    "it": "Data singola",
                    "pt": "Data única",
                    "nl": "Enkele datum",
                    "da": "Enkelt dato",
                    "sv": "Enstaka datum",
                    "nb": "Enkelt dato",
                    "fi": "Yksittäinen päivämäärä",
                    "is": "Stök dagsetning",
                    "el": "Μονή ημερομηνία",
                    "tr": "Tek tarih",
                    "hu": "Egyetlen dátum",
                    "hr": "Jedan datum",
                    "pl": "Pojedyncza data",
                    "sk": "Jeden dátum",
                    "cs": "Jedno datum",
                    "lb": "Eenzelt Datum",
                ]
            ),
            DatePickerData(
                id: "date1",
                label: LabelData(
                    id: "date-label-1",
                    title: tr(
                        "Appointment Date",
                        de: "Termin",
                        fr: "Date du rendez-vous",
                        es: "Fecha de la cita",
                        it: "Data dell'appuntamento"
                    )
                ),
                value: Date(),
                state: .enabled,
                errorMessages: nil,
                backgroundColor: nil
            )
        ),
        #previewVariant(
            tr(
                "Date Range",
                [
                    "de": "Datumsbereich",
                    "fr": "Plage de dates",
                    "es": "Rango de fechas",
                    "it": "Intervallo di date",
                    "pt": "Intervalo de datas",
                    "nl": "Datumbereik",
                    "da": "Datointerval",
                    "sv": "Datumintervall",
                    "nb": "Datointervall",
                    "fi": "Päivämääräväli",
                    "is": "Dagsetningabil",
                    "el": "Εύρος ημερομηνιών",
                    "tr": "Tarih aralığı",
                    "hu": "Dátumtartomány",
                    "hr": "Raspon datuma",
                    "pl": "Zakres dat",
                    "sk": "Rozsah dátumov",
                    "cs": "Rozsah dat",
                    "lb": "Datumsberäich",
                ]
            ),
            DatePickerData(
                id: "date2",
                endId: "date2_end",
                label: LabelData(
                    id: "date-label-2",
                    title: tr(
                        "Vacation Period (Date Range)",
                        de: "Urlaubszeitraum (Datumsbereich)",
                        fr: "Période de vacances (plage de dates)",
                        es: "Período de vacaciones (rango de fechas)",
                        it: "Periodo di vacanza (intervallo di date)"
                    )
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
