import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct NotificationView: TemplateRepresentable {

    let variants: [PreviewVariant<NotificationData>] = [
        #previewVariant(
            tr(
                "Info Title Only",
                [
                    "de": "Nur Info-Titel",
                    "fr": "Titre d'information seul",
                    "es": "Solo título informativo",
                    "it": "Solo titolo informativo",
                    "pt": "Apenas título informativo",
                    "nl": "Alleen infotitel",
                    "da": "Kun infotitel",
                    "sv": "Endast infotitel",
                    "nb": "Kun infotittel",
                    "fi": "Vain info-otsikko",
                    "is": "Aðeins upplýsingatitill",
                    "el": "Μόνο τίτλος πληροφοριών",
                    "tr": "Yalnızca bilgi başlığı",
                    "hu": "Csak információs cím",
                    "hr": "Samo naslov informacija",
                    "pl": "Tylko tytuł informacyjny",
                    "sk": "Iba informačný názov",
                    "cs": "Pouze informační název",
                    "lb": "Nëmmen Info-Titel",
                ]
            ),
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
            tr(
                "Info with Markdown Text",
                [
                    "de": "Info mit Markdown-Text",
                    "fr": "Information avec texte Markdown",
                    "es": "Información con texto Markdown",
                    "it": "Info con testo Markdown",
                    "pt": "Informação com texto Markdown",
                    "nl": "Info met Markdown-tekst",
                    "da": "Info med Markdown-tekst",
                    "sv": "Info med Markdown-text",
                    "nb": "Info med Markdown-tekst",
                    "fi": "Info Markdown-tekstillä",
                    "is": "Upplýsingar með Markdown-texta",
                    "el": "Πληροφορίες με κείμενο Markdown",
                    "tr": "Markdown metinli bilgi",
                    "hu": "Infó Markdown szöveggel",
                    "hr": "Informacije s Markdown tekstom",
                    "pl": "Informacja z tekstem Markdown",
                    "sk": "Informácie s textom Markdown",
                    "cs": "Informace s textem Markdown",
                    "lb": "Info mat Markdown-Text",
                ]
            ),
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
            tr(
                "Success Message",
                [
                    "de": "Erfolgsmeldung",
                    "fr": "Message de succès",
                    "es": "Mensaje de éxito",
                    "it": "Messaggio di successo",
                    "pt": "Mensagem de sucesso",
                    "nl": "Succesbericht",
                    "da": "Succesmeddelelse",
                    "sv": "Framgångsmeddelande",
                    "nb": "Suksessmelding",
                    "fi": "Onnistumisviesti",
                    "is": "Árangursskilaboð",
                    "el": "Μήνυμα επιτυχίας",
                    "tr": "Başarı mesajı",
                    "hu": "Sikerüzenet",
                    "hr": "Poruka o uspjehu",
                    "pl": "Komunikat o powodzeniu",
                    "sk": "Správa o úspechu",
                    "cs": "Zpráva o úspěchu",
                    "lb": "Erfollegsmeldung",
                ]
            ),
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
            tr(
                "Warning Message",
                [
                    "de": "Warnmeldung",
                    "fr": "Message d'avertissement",
                    "es": "Mensaje de advertencia",
                    "it": "Messaggio di avviso",
                    "pt": "Mensagem de aviso",
                    "nl": "Waarschuwingsbericht",
                    "da": "Advarselsmeddelelse",
                    "sv": "Varningsmeddelande",
                    "nb": "Advarselsmelding",
                    "fi": "Varoitusviesti",
                    "is": "Viðvörunarskilaboð",
                    "el": "Μήνυμα προειδοποίησης",
                    "tr": "Uyarı mesajı",
                    "hu": "Figyelmeztető üzenet",
                    "hr": "Poruka upozorenja",
                    "pl": "Komunikat ostrzegawczy",
                    "sk": "Varovná správa",
                    "cs": "Varovná zpráva",
                    "lb": "Warnmeldung",
                ]
            ),
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
            tr(
                "Error Message",
                [
                    "de": "Fehlermeldung",
                    "fr": "Message d'erreur",
                    "es": "Mensaje de error",
                    "it": "Messaggio di errore",
                    "pt": "Mensagem de erro",
                    "nl": "Foutbericht",
                    "da": "Fejlmeddelelse",
                    "sv": "Felmeddelande",
                    "nb": "Feilmelding",
                    "fi": "Virheviesti",
                    "is": "Villuboð",
                    "el": "Μήνυμα σφάλματος",
                    "tr": "Hata mesajı",
                    "hu": "Hibaüzenet",
                    "hr": "Poruka o pogrešci",
                    "pl": "Komunikat o błędzie",
                    "sk": "Chybová správa",
                    "cs": "Chybová zpráva",
                    "lb": "Feelermeldung",
                ]
            ),
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
