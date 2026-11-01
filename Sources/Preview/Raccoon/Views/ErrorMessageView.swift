import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct ErrorMessageView: TemplateRepresentable {

    let variants: [PreviewVariant<ErrorMessageData>] = [
        #previewVariant(
            """
            // With error messages
            """,
            ErrorMessageData(
                id: "err2",
                errorMessages: [
                    tr(
                        "Error 1",
                        de: "Fehler 1",
                        fr: "Erreur 1",
                        es: "Error 1",
                        it: "Errore 1"
                    ),
                    tr(
                        "Error 2",
                        de: "Fehler 2",
                        fr: "Erreur 2",
                        es: "Error 2",
                        it: "Errore 2"
                    ),
                ],
                hasIcon: true
            )
        ),
        #previewVariant(
            """
            // With error messages
            """,
            ErrorMessageData(
                id: "err3",
                errorMessages: [
                    tr(
                        "Error 3",
                        de: "Fehler 3",
                        fr: "Erreur 3",
                        es: "Error 3",
                        it: "Errore 3"
                    )
                ],
                hasIcon: false
            )
        ),
        #previewVariant(
            """
            // Messages with translations
            """,
            ErrorMessageData(
                id: "err4",
                errorMessages: [
                    tr(
                        "This field is required.",
                        de: "Dieses Feld ist erforderlich.",
                        fr: "Ce champ est obligatoire.",
                        es: "Este campo es obligatorio.",
                        it: "Questo campo è obbligatorio."
                    )
                ],
                hasIcon: true
            )
        ),
    ]

    func makeHtml(ctx: ErrorMessageData) -> String {
        let html = renderFragments(ErrorMessage(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("ErrorMessage")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { ErrorMessage(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
