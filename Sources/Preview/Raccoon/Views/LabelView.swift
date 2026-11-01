import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct LabelView: TemplateRepresentable {

    let variants: [PreviewVariant<LabelData>] = [
        #previewVariant(
            """
            // Required
            """,
            LabelData(
                id: "field-1",
                title: tr(
                    "Full name",
                    de: "Vollständiger Name",
                    fr: "Nom complet",
                    es: "Nombre completo",
                    it: "Nome completo"
                ),
                isRequired: true
            )
        ),
        #previewVariant(
            """
            // Optional
            """,
            LabelData(
                id: "field-2",
                title: tr(
                    "Middle name",
                    de: "Zweiter Vorname",
                    fr: "Deuxième prénom",
                    es: "Segundo nombre",
                    it: "Secondo nome"
                ),
                position: .right,
                isRequired: false
            )
        ),
        #previewVariant(
            """
            // Optional
            """,
            LabelData(
                id: "field-3",
                title: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                position: .left,
                size: .xl,
                isRequired: true,
                xhtml: "'xhtml-test'"
            )
        ),
        #previewVariant(
            """
            // Title with translations (en, de, fr)
            """,
            LabelData(
                id: "field-4",
                title: tr(
                    "Email address",
                    de: "E-Mail-Adresse",
                    fr: "Adresse e-mail",
                    es: "Dirección de correo electrónico",
                    it: "Indirizzo e-mail"
                ),
                isRequired: true
            )
        ),
    ]

    func makeHtml(ctx: LabelData) -> String {
        let html = renderFragments(Label(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Label")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { Label(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
