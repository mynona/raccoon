import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct SingleSelectView: TemplateRepresentable {

    let variants: [PreviewVariant<SingleSelectData>] = [
        #previewVariant(
            "Enabled with Helper Text",
            SingleSelectData(
                id: "select-1",
                name: "select-name-for-forms",
                label: LabelData(
                    id: "select-1",
                    title: tr(
                        "Choose option",
                        de: "Option wählen",
                        fr: "Choisir une option",
                        es: "Elegir opción",
                        it: "Scegli un'opzione"
                    )
                ),
                placeholder: tr(
                    "select-placeholder",
                    de: "Platzhalter für die Auswahl",
                    fr: "espace réservé de sélection",
                    es: "marcador de selección",
                    it: "segnaposto di selezione"
                ),
                options: DemoData.optionList,
                errorMessages: nil,
                helperText: HelperTextData(
                    id: "hlp-1",
                    text: tr(
                        "helper-text-1",
                        de: "Hilfetext 1",
                        fr: "texte d'aide 1",
                        es: "texto de ayuda 1",
                        it: "testo di aiuto 1"
                    )
                ),
                state: .enabled,
                backgroundColor: nil,
            )
        ),
        #previewVariant(
            "Validation Error State",
            SingleSelectData(
                id: "select-2",
                name: "select-name-for-forms",
                label: LabelData(
                    id: "select-2",
                    title: tr(
                        "Choose option",
                        de: "Option wählen",
                        fr: "Choisir une option",
                        es: "Elegir opción",
                        it: "Scegli un'opzione"
                    )
                ),
                placeholder: tr(
                    "select-placeholder",
                    de: "Platzhalter für die Auswahl",
                    fr: "espace réservé de sélection",
                    es: "marcador de selección",
                    it: "segnaposto di selezione"
                ),
                options: DemoData.optionList,
                errorMessages: ErrorMessageData(
                    id: "err-2",
                    errorMessages: [
                        tr(
                            "error-one",
                            de: "Fehler eins",
                            fr: "erreur un",
                            es: "error uno",
                            it: "errore uno"
                        )
                    ],
                    hasIcon: false
                ),
                helperText: HelperTextData(
                    id: "hlp-2",
                    text: tr(
                        "helper-text-1",
                        de: "Hilfetext 1",
                        fr: "texte d'aide 1",
                        es: "texto de ayuda 1",
                        it: "testo di aiuto 1"
                    )
                ),
                state: .enabled,
                backgroundColor: nil,
            )
        ),
        #previewVariant(
            "Custom Background Color",
            SingleSelectData(
                id: "select-3",
                name: "select-name-for-forms",
                label: LabelData(
                    id: "select-3",
                    title: tr(
                        "Choose option",
                        de: "Option wählen",
                        fr: "Choisir une option",
                        es: "Elegir opción",
                        it: "Scegli un'opzione"
                    )
                ),
                placeholder: tr(
                    "select-placeholder",
                    de: "Platzhalter für die Auswahl",
                    fr: "espace réservé de sélection",
                    es: "marcador de selección",
                    it: "segnaposto di selezione"
                ),
                options: DemoData.optionList,
                errorMessages: nil,
                helperText: nil,
                state: .enabled,
                backgroundColor: "#4365fc",
            )
        ),
        #previewVariant(
            "Disabled State",
            SingleSelectData(
                id: "select-4",
                name: "select-name-for-forms",
                label: LabelData(
                    id: "select-4",
                    title: tr(
                        "Choose option",
                        de: "Option wählen",
                        fr: "Choisir une option",
                        es: "Elegir opción",
                        it: "Scegli un'opzione"
                    )
                ),
                placeholder: tr(
                    "select-placeholder",
                    de: "Platzhalter für die Auswahl",
                    fr: "espace réservé de sélection",
                    es: "marcador de selección",
                    it: "segnaposto di selezione"
                ),
                options: DemoData.optionList,
                errorMessages: nil,
                helperText: nil,
                state: .disabled,
                backgroundColor: nil,
            )
        ),
        #previewVariant(
            "Read-Only Info State",
            SingleSelectData(
                id: "select-5",
                name: "select-name-for-forms",
                label: LabelData(
                    id: "select-5",
                    title: tr(
                        "Choose option",
                        de: "Option wählen",
                        fr: "Choisir une option",
                        es: "Elegir opción",
                        it: "Scegli un'opzione"
                    )
                ),
                placeholder: tr(
                    "select-placeholder",
                    de: "Platzhalter für die Auswahl",
                    fr: "espace réservé de sélection",
                    es: "marcador de selección",
                    it: "segnaposto di selezione"
                ),
                options: DemoData.optionList,
                errorMessages: nil,
                helperText: nil,
                state: .info,
                backgroundColor: nil,
            )
        ),
        #previewVariant(
            "Minimal without Labels",
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
        #previewVariant(
            "Unmatched Value Fallback",
            SingleSelectData(
                id: "select-7",
                name: "select-name-for-forms",
                label: LabelData(
                    id: "select-7",
                    title: tr(
                        "Choose option",
                        de: "Option wählen",
                        fr: "Choisir une option",
                        es: "Elegir opción",
                        it: "Scegli un'opzione"
                    )
                ),
                placeholder: tr(
                    "select-placeholder",
                    de: "Platzhalter für die Auswahl",
                    fr: "espace réservé de sélection",
                    es: "marcador de selección",
                    it: "segnaposto di selezione"
                ),
                value: "blabla",
                options: DemoData.optionList,
                errorMessages: nil,
                helperText: HelperTextData(
                    id: "hlp-7",
                    text: tr(
                        "helper-text-1",
                        de: "Hilfetext 1",
                        fr: "texte d'aide 1",
                        es: "texto de ayuda 1",
                        it: "testo di aiuto 1"
                    )
                ),
                state: .enabled,
                backgroundColor: nil,
            )
        ),
        #previewVariant(
            "Pre-selected Matching Value",
            SingleSelectData(
                id: "select-8",
                name: "select-name-for-forms",
                label: LabelData(
                    id: "select-8",
                    title: tr(
                        "Choose option",
                        de: "Option wählen",
                        fr: "Choisir une option",
                        es: "Elegir opción",
                        it: "Scegli un'opzione"
                    )
                ),
                placeholder: tr(
                    "select-placeholder",
                    de: "Platzhalter für die Auswahl",
                    fr: "espace réservé de sélection",
                    es: "marcador de selección",
                    it: "segnaposto di selezione"
                ),
                value: "a",
                options: DemoData.optionList,
                errorMessages: nil,
                helperText: HelperTextData(
                    id: "hlp-8",
                    text: tr(
                        "helper-text-1",
                        de: "Hilfetext 1",
                        fr: "texte d'aide 1",
                        es: "texto de ayuda 1",
                        it: "testo di aiuto 1"
                    )
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

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { SingleSelect(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
