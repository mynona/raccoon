import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct SingleSelectView: TemplateRepresentable {

    let variants: [PreviewVariant<SingleSelectData>] = [
        #previewVariant(
            """
            // state = .enabled
            """,
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
            """
            // state = .enabled
            """,
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
            """
            // backgroundColor
            """,
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
            """
            // state: .disabled
            """,
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
            """
            // state: .info
            """,
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
        #previewVariant(
            """
            // value set in backend but does not match any value in 
            // the option list, then no option is selected
            """,
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
            """
            // value set in backend with a correct value
            """,
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
