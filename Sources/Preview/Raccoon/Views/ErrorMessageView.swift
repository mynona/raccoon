import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct ErrorMessageView: TemplateRepresentable {

    let variants: [PreviewVariant<ErrorMessageData>] = [
        #previewVariant(
            tr(
                "Multiple Errors with Icon",
                [
                    "de": "Mehrere Fehler mit Icon",
                    "fr": "Plusieurs erreurs avec icône",
                    "es": "Varios errores con icono",
                    "it": "Errori multipli con icona",
                    "pt": "Vários erros com ícone",
                    "nl": "Meerdere fouten met pictogram",
                    "da": "Flere fejl med ikon",
                    "sv": "Flera fel med ikon",
                    "nb": "Flere feil med ikon",
                    "fi": "Useita virheitä kuvakkeella",
                    "is": "Margar villur með tákni",
                    "el": "Πολλαπλά σφάλματα με εικονίδιο",
                    "tr": "Simgeli çoklu hata",
                    "hu": "Több hiba ikonnal",
                    "hr": "Više pogrešaka s ikonom",
                    "pl": "Wiele błędów z ikoną",
                    "sk": "Viacero chýb s ikonou",
                    "cs": "Více chyb s ikonou",
                    "lb": "Méi Feeleren mat Ikon",
                ]
            ),
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
            tr(
                "Single Error without Icon",
                [
                    "de": "Einzelfehler ohne Icon",
                    "fr": "Erreur unique sans icône",
                    "es": "Error único sin icono",
                    "it": "Errore singolo senza icona",
                    "pt": "Erro único sem ícone",
                    "nl": "Enkele fout zonder pictogram",
                    "da": "Enkelt fejl uden ikon",
                    "sv": "Enstaka fel utan ikon",
                    "nb": "Enkelt feil uten ikon",
                    "fi": "Yksittäinen virhe ilman kuvaketta",
                    "is": "Stök villa án tákns",
                    "el": "Μονό σφάλμα χωρίς εικονίδιο",
                    "tr": "Simgesiz tek hata",
                    "hu": "Egyetlen hiba ikon nélkül",
                    "hr": "Jedna pogreška bez ikone",
                    "pl": "Pojedynczy błąd bez ikony",
                    "sk": "Jedna chyba bez ikony",
                    "cs": "Jedna chyba bez ikony",
                    "lb": "Eenzelfeeler ouni Ikon",
                ]
            ),
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
            tr(
                "Localized Error with Icon",
                [
                    "de": "Lokalisierter Fehler mit Icon",
                    "fr": "Erreur localisée avec icône",
                    "es": "Error localizado con icono",
                    "it": "Errore localizzato con icona",
                    "pt": "Erro localizado com ícone",
                    "nl": "Gelokaliseerde fout met pictogram",
                    "da": "Lokaliseret fejl med ikon",
                    "sv": "Lokaliserat fel med ikon",
                    "nb": "Lokalisert feil med ikon",
                    "fi": "Lokalisoitu virhe kuvakkeella",
                    "is": "Staðfærð villa með tákni",
                    "el": "Τοπικοποιημένο σφάλμα με εικονίδιο",
                    "tr": "Simgeli yerelleştirilmiş hata",
                    "hu": "Honosított hiba ikonnal",
                    "hr": "Lokalizirana pogreška s ikonom",
                    "pl": "Zlokalizowany błąd z ikoną",
                    "sk": "Lokalizovaná chyba s ikonou",
                    "cs": "Lokalizovaná chyba s ikonou",
                    "lb": "Lokaliséierte Feeler mat Ikon",
                ]
            ),
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
