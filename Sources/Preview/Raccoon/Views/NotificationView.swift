import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct NotificationView: TemplateRepresentable {

    let variants: [PreviewVariant<NotificationData>] = [
        #previewVariant(
            """
            // Info (no text)
            """,
            NotificationData(
                title: tr(
                    "Info title",
                    de: "Info-Titel",
                    fr: "Titre d'information",
                    es: "Título informativo",
                    it: "Titolo informativo"
                ),
                text: nil,
                type: .info
            )
        ),
        #previewVariant(
            """
            // Info (with text)
            """,
            NotificationData(
                title: tr(
                    "Info title",
                    de: "Info-Titel",
                    fr: "Titre d'information",
                    es: "Título informativo",
                    it: "Titolo informativo"
                ),
                text: tr(
                    "Some **detail** here.",
                    de: "Hier ein **Detail**.",
                    fr: "Voici un **détail**.",
                    es: "Aquí hay un **detalle**.",
                    it: "Ecco un **dettaglio**."
                ),
                type: .info
            )
        ),
        #previewVariant(
            """
            // Success
            """,
            NotificationData(
                title: tr(
                    "All done!",
                    de: "Alles erledigt!",
                    fr: "Tout est terminé !",
                    es: "¡Todo listo!",
                    it: "Tutto fatto!"
                ),
                text: tr(
                    "Your changes were saved.",
                    de: "Deine Änderungen wurden gespeichert.",
                    fr: "Vos modifications ont été enregistrées.",
                    es: "Tus cambios se han guardado.",
                    it: "Le tue modifiche sono state salvate."
                ),
                type: .success
            )
        ),
        #previewVariant(
            """
            // Warning
            """,
            NotificationData(
                title: tr(
                    "Watch out",
                    de: "Achtung",
                    fr: "Attention",
                    es: "Atención",
                    it: "Attenzione"
                ),
                text: tr(
                    "This action cannot be undone.",
                    de: "Diese Aktion kann nicht rückgängig gemacht werden.",
                    fr: "Cette action est irréversible.",
                    es: "Esta acción no se puede deshacer.",
                    it: "Questa azione non può essere annullata."
                ),
                type: .warning
            )
        ),
        #previewVariant(
            """
            // Error
            """,
            NotificationData(
                title: tr(
                    "Something went wrong",
                    de: "Etwas ist schiefgelaufen",
                    fr: "Une erreur s'est produite",
                    es: "Algo salió mal",
                    it: "Qualcosa è andato storto"
                ),
                text: tr(
                    "Please try again later.",
                    de: "Bitte versuche es später erneut.",
                    fr: "Veuillez réessayer plus tard.",
                    es: "Inténtalo de nuevo más tarde.",
                    it: "Riprova più tardi."
                ),
                type: .error
            )
        ),
    ]

    func makeHtml(ctx: NotificationData) -> String {
        let html = renderFragments(Notification(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Notification")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { Notification(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
