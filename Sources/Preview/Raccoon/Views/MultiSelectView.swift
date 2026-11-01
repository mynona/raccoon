import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct MultiSelectView: TemplateRepresentable {

    let variants: [PreviewVariant<MultiSelectData>] = [
        #previewVariant(
            "Pre-selected with Helper Text",
            MultiSelectData(
                id: "multi-1",
                name: "techs",
                label: LabelData(
                    id: "multi-1",
                    title: tr(
                        "Technologies",
                        de: "Technologien",
                        fr: "Technologies",
                        es: "Tecnologías",
                        it: "Tecnologie"
                    )
                ),
                placeholder: tr(
                    "placeholder",
                    de: "Platzhalter",
                    fr: "espace réservé",
                    es: "marcador",
                    it: "segnaposto"
                ),
                values: ["vapor", "html"],
                options: DemoData.optionList,
                state: .enabled,
                helperText: HelperTextData(
                    id: "hlp-1",
                    text: tr(
                        "helper-text-1",
                        de: "Hilfetext 1",
                        fr: "texte d'aide 1",
                        es: "texto de ayuda 1",
                        it: "testo di aiuto 1"
                    )
                )
            )
        ),
        #previewVariant(
            "Validation Error State",
            MultiSelectData(
                id: "multi-3",
                name: "techs",
                label: LabelData(
                    id: "multi-3",
                    title: tr(
                        "Technologies",
                        de: "Technologien",
                        fr: "Technologies",
                        es: "Tecnologías",
                        it: "Tecnologie"
                    )
                ),
                placeholder: tr(
                    "placeholder",
                    de: "Platzhalter",
                    fr: "espace réservé",
                    es: "marcador",
                    it: "segnaposto"
                ),
                values: ["vapor"],
                options: DemoData.optionList,
                state: .enabled,
                errorMessages: ErrorMessageData(
                    id: "err-1",
                    errorMessages: [
                        tr(
                            "error one",
                            de: "Fehler eins",
                            fr: "erreur un",
                            es: "error uno",
                            it: "errore uno"
                        )
                    ],
                    hasIcon: false
                )
            )
        ),
        #previewVariant(
            "Read-Only Info State",
            MultiSelectData(
                id: "multi-41",
                name: "techs",
                label: LabelData(
                    id: "multi-41",
                    title: tr(
                        "Technologies",
                        de: "Technologien",
                        fr: "Technologies",
                        es: "Tecnologías",
                        it: "Tecnologie"
                    )
                ),
                placeholder: tr(
                    "placeholder",
                    de: "Platzhalter",
                    fr: "espace réservé",
                    es: "marcador",
                    it: "segnaposto"
                ),
                values: ["vapor"],
                options: DemoData.optionList,
                state: .info
            )
        ),
        #previewVariant(
            "Read-Only Info with Custom Background",
            MultiSelectData(
                id: "multi-43",
                name: "techs",
                label: LabelData(
                    id: "multi-43",
                    title: tr(
                        "Technologies",
                        de: "Technologien",
                        fr: "Technologies",
                        es: "Tecnologías",
                        it: "Tecnologie"
                    )
                ),
                placeholder: tr(
                    "placeholder",
                    de: "Platzhalter",
                    fr: "espace réservé",
                    es: "marcador",
                    it: "segnaposto"
                ),
                values: ["vapor"],
                options: DemoData.optionList,
                state: .info,
                backgroundColor: "#7e43ac"
            )
        ),
        #previewVariant(
            "Disabled with Custom Background",
            MultiSelectData(
                id: "multi-51",
                name: "techs",
                label: LabelData(
                    id: "multi-51",
                    title: tr(
                        "Technologies",
                        de: "Technologien",
                        fr: "Technologies",
                        es: "Tecnologías",
                        it: "Tecnologie"
                    )
                ),
                placeholder: tr(
                    "placeholder",
                    de: "Platzhalter",
                    fr: "espace réservé",
                    es: "marcador",
                    it: "segnaposto"
                ),
                values: ["vapor"],
                options: DemoData.optionList,
                state: .disabled,
                backgroundColor: "#7e43ac"
            )
        ),
        #previewVariant(
            "Disabled State",
            MultiSelectData(
                id: "multi-52",
                name: "techs",
                label: LabelData(
                    id: "multi-52",
                    title: tr(
                        "Technologies",
                        de: "Technologien",
                        fr: "Technologies",
                        es: "Tecnologías",
                        it: "Tecnologie"
                    )
                ),
                placeholder: tr(
                    "placeholder",
                    de: "Platzhalter",
                    fr: "espace réservé",
                    es: "marcador",
                    it: "segnaposto"
                ),
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

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { MultiSelect(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
