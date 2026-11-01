import HTML
import Raccoon
import SGML
import WebBuilders

struct RadioView: TemplateRepresentable {

    let variants: [PreviewVariant<RadioData>] = [
        #previewVariant(
            tr(
                "Unchecked Default",
                [
                    "de": "Nicht ausgewählt Standard",
                    "fr": "Non coché par défaut",
                    "es": "Sin marcar por defecto",
                    "it": "Non selezionato predefinito",
                    "pt": "Desmarcado padrão",
                    "nl": "Niet-aangevinkt standaard",
                    "da": "Ikke afkrydset standard",
                    "sv": "Omarkerad standard",
                    "nb": "Ikke avkrysset standard",
                    "fi": "Valitsematon oletus",
                    "is": "Óhakað sjálfgefið",
                    "el": "Μη επιλεγμένο προεπιλεγμένο",
                    "tr": "Varsayılan işaretsiz",
                    "hu": "Alapértelmezetten nincs bejelölve",
                    "hr": "Neoznačeno zadano",
                    "pl": "Domyślnie niezaznaczone",
                    "sk": "Nezačiarknuté predvolené",
                    "cs": "Nezaškrtnuto výchozí",
                    "lb": "Net ausgewielt Standard",
                ]
            ),
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
            tr(
                "Checked State",
                [
                    "de": "Ausgewählter Zustand",
                    "fr": "État coché",
                    "es": "Estado marcado",
                    "it": "Stato selezionato",
                    "pt": "Estado marcado",
                    "nl": "Aangevinkte status",
                    "da": "Afkrydset tilstand",
                    "sv": "Markerat tillstånd",
                    "nb": "Avkrysset tilstand",
                    "fi": "Valittu tila",
                    "is": "Hakað við staða",
                    "el": "Επιλεγμένη κατάσταση",
                    "tr": "İşaretli durum",
                    "hu": "Bejelölt állapot",
                    "hr": "Označeno stanje",
                    "pl": "Stan zaznaczony",
                    "sk": "Začiarknutý stav",
                    "cs": "Zaškrtnutý stav",
                    "lb": "Ausgewielten Zoustand",
                ]
            ),
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
            tr(
                "Disabled Unchecked",
                [
                    "de": "Deaktiviert nicht ausgewählt",
                    "fr": "Désactivé non coché",
                    "es": "Deshabilitado sin marcar",
                    "it": "Disabilitato non selezionato",
                    "pt": "Desativado desmarcado",
                    "nl": "Uitgeschakeld niet-aangevinkt",
                    "da": "Deaktiveret ikke afkrydset",
                    "sv": "Inaktiverad omarkerad",
                    "nb": "Deaktivert ikke avkrysset",
                    "fi": "Pois käytöstä valitsematon",
                    "is": "Óvirkt óhakað",
                    "el": "Απενεργοποιημένο μη επιλεγμένο",
                    "tr": "Devre dışı işaretsiz",
                    "hu": "Letiltva nincs bejelölve",
                    "hr": "Onemogućeno neoznačeno",
                    "pl": "Wyłączone niezaznaczone",
                    "sk": "Zakázané nezačiarknuté",
                    "cs": "Zakázáno nezaškrtnuto",
                    "lb": "Desaktivéiert net ausgewielt",
                ]
            ),
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
            tr(
                "Disabled Checked",
                [
                    "de": "Deaktiviert ausgewählt",
                    "fr": "Désactivé coché",
                    "es": "Deshabilitado marcado",
                    "it": "Disabilitato selezionato",
                    "pt": "Desativado marcado",
                    "nl": "Uitgeschakeld aangevinkt",
                    "da": "Deaktiveret afkrydset",
                    "sv": "Inaktiverad markerad",
                    "nb": "Deaktivert avkrysset",
                    "fi": "Pois käytöstä valittu",
                    "is": "Óvirkt hakað við",
                    "el": "Απενεργοποιημένο επιλεγμένο",
                    "tr": "Devre dışı işaretli",
                    "hu": "Letiltva bejelölve",
                    "hr": "Onemogućeno označeno",
                    "pl": "Wyłączone zaznaczone",
                    "sk": "Zakázané začiarknuté",
                    "cs": "Zakázáno zaškrtnuto",
                    "lb": "Desaktivéiert ausgewielt",
                ]
            ),
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
            tr(
                "With Helper Text",
                [
                    "de": "Mit Hilfetext",
                    "fr": "Avec texte d'aide",
                    "es": "Con texto de ayuda",
                    "it": "Con testo di aiuto",
                    "pt": "Com texto de ajuda",
                    "nl": "Met hulptekst",
                    "da": "Med hjælpetekst",
                    "sv": "Med hjälptext",
                    "nb": "Med hjelpetekst",
                    "fi": "Aputekstillä",
                    "is": "Með hjálpartexta",
                    "el": "Με κείμενο βοήθειας",
                    "tr": "Yardımcı metin ile",
                    "hu": "Súgószöveggel",
                    "hr": "S tekstom pomoći",
                    "pl": "Z tekstem pomocniczym",
                    "sk": "S pomocným textom",
                    "cs": "S pomocným textem",
                    "lb": "Mat Hëllefstext",
                ]
            ),
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
            tr(
                "With Error Message",
                [
                    "de": "Mit Fehlermeldung",
                    "fr": "Avec message d'erreur",
                    "es": "Con mensaje de error",
                    "it": "Con messaggio di errore",
                    "pt": "Com mensagem de erro",
                    "nl": "Met foutmelding",
                    "da": "Med fejlmeddelelse",
                    "sv": "Med felmeddelande",
                    "nb": "Med feilmelding",
                    "fi": "Virheilmoituksella",
                    "is": "Með villuskilaboðum",
                    "el": "Με μήνυμα σφάλματος",
                    "tr": "Hata mesajı ile",
                    "hu": "Hibaüzenettel",
                    "hr": "S porukom o pogrešci",
                    "pl": "Z komunikatem o błędzie",
                    "sk": "S chybovou správou",
                    "cs": "S chybovou zprávou",
                    "lb": "Mat Feelermeldung",
                ]
            ),
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
