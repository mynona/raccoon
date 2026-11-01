import HTML
import Raccoon
import SGML
import WebBuilders

struct RadioView: TemplateRepresentable {

    let variants: [PreviewVariant<RadioData>] = [
        #previewVariant(
            "Unchecked Default",
            RadioData(
                id: "radio-1",
                label: tr(
                    "Accept terms",
                    de: "Bedingungen akzeptieren",
                    fr: "Accepter les conditions",
                    es: "Aceptar los términos",
                    it: "Accetta i termini"
                )
            )
        ),
        #previewVariant(
            "Checked State",
            RadioData(
                id: "radio-2",
                label: tr(
                    "Accept terms",
                    de: "Bedingungen akzeptieren",
                    fr: "Accepter les conditions",
                    es: "Aceptar los términos",
                    it: "Accetta i termini"
                ),
                isSelected: true
            )
        ),
        #previewVariant(
            "Disabled Unchecked",
            RadioData(
                id: "radio-3",
                label: tr(
                    "Accept terms",
                    de: "Bedingungen akzeptieren",
                    fr: "Accepter les conditions",
                    es: "Aceptar los términos",
                    it: "Accetta i termini"
                ),
                state: .disabled
            )
        ),
        #previewVariant(
            "Disabled Checked",
            RadioData(
                id: "radio-4",
                label: tr(
                    "Accept terms",
                    de: "Bedingungen akzeptieren",
                    fr: "Accepter les conditions",
                    es: "Aceptar los términos",
                    it: "Accetta i termini"
                ),
                state: .disabled,
                isSelected: true
            )
        ),
        #previewVariant(
            "With Helper Text",
            RadioData(
                id: "radio-5",
                label: tr(
                    "Accept terms",
                    de: "Bedingungen akzeptieren",
                    fr: "Accepter les conditions",
                    es: "Aceptar los términos",
                    it: "Accetta i termini"
                ),
                helperText: HelperTextData(
                    id: "radio-5",
                    text: tr(
                        "helper text",
                        de: "Hilfetext",
                        fr: "texte d'aide",
                        es: "texto de ayuda",
                        it: "testo di aiuto"
                    )
                )
            )
        ),
        #previewVariant(
            "With Error Message",
            RadioData(
                id: "radio-6",
                label: tr(
                    "Accept terms",
                    de: "Bedingungen akzeptieren",
                    fr: "Accepter les conditions",
                    es: "Aceptar los términos",
                    it: "Accetta i termini"
                ),
                errorMessages: ErrorMessageData(
                    id: "radio-6",
                    errorMessages: [
                        tr(
                            "error one",
                            de: "Fehler eins",
                            fr: "erreur un",
                            es: "error uno",
                            it: "errore uno"
                        )
                    ],
                    hasIcon: true
                ),
                helperText: HelperTextData(
                    id: "radio-6",
                    text: tr(
                        "helper text",
                        de: "Hilfetext",
                        fr: "texte d'aide",
                        es: "texto de ayuda",
                        it: "testo di aiuto"
                    )
                )
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
