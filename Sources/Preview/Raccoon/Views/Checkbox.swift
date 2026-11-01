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
                label: tr(
                    "Accept terms",
                    de: "Bedingungen akzeptieren",
                    fr: "Accepter les conditions",
                    es: "Aceptar los términos",
                    it: "Accetta i termini"
                ),
                name: "name",
                isSelected: true,
                state: .enabled,
                errorMessages: nil,
                helperText: HelperTextData(
                    id: "helper-1",
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
            """
            //
            """,
            CheckData(
                id: "cb-10",
                label: tr(
                    "Accept terms",
                    de: "Bedingungen akzeptieren",
                    fr: "Accepter les conditions",
                    es: "Aceptar los términos",
                    it: "Accetta i termini"
                ),
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
                label: tr(
                    "Accept terms",
                    de: "Bedingungen akzeptieren",
                    fr: "Accepter les conditions",
                    es: "Aceptar los términos",
                    it: "Accetta i termini"
                ),
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
                label: tr(
                    "Accept terms",
                    de: "Bedingungen akzeptieren",
                    fr: "Accepter les conditions",
                    es: "Aceptar los términos",
                    it: "Accetta i termini"
                ),
                name: "name",
                isSelected: false,
                state: .enabled,
                errorMessages: ErrorMessageData(
                    id: "error-1",
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
                    id: "helper-1-2",
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
