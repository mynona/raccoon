import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct CheckboxView: TemplateRepresentable {

    let variants: [PreviewVariant<CheckData>] = [
        #previewVariant(
            tr(
                "Checked with Helper Text",
                [
                    "de": "Ausgewählt mit Hilfetext",
                    "fr": "Coché avec texte d'aide",
                    "es": "Marcado con texto de ayuda",
                    "it": "Selezionato con testo di aiuto",
                    "pt": "Marcado com texto de ajuda",
                    "nl": "Aangevinkt met hulptekst",
                    "da": "Afkrydset med hjælpetekst",
                    "sv": "Markerad med hjälptext",
                    "nb": "Avkrysset med hjelpetekst",
                    "fi": "Valittu aputekstillä",
                    "is": "Hakað við með hjálpartexta",
                    "el": "Επιλεγμένο με κείμενο βοήθειας",
                    "tr": "Yardımcı metinli işaretli",
                    "hu": "Bejelölve súgószöveggel",
                    "hr": "Označeno s tekstom pomoći",
                    "pl": "Zaznaczone z tekstem pomocniczym",
                    "sk": "Začiarknuté s pomocným textom",
                    "cs": "Zaškrtnuto s pomocným textem",
                    "lb": "Ausgewielt mat Hëllefstext",
                ]
            ),
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
            tr(
                "Checked Disabled",
                [
                    "de": "Ausgewählt deaktiviert",
                    "fr": "Coché désactivé",
                    "es": "Marcado deshabilitado",
                    "it": "Selezionato disabilitato",
                    "pt": "Marcado desativado",
                    "nl": "Aangevinkt uitgeschakeld",
                    "da": "Afkrydset deaktiveret",
                    "sv": "Markerad inaktiverad",
                    "nb": "Avkrysset deaktivert",
                    "fi": "Valittu pois käytöstä",
                    "is": "Hakað við óvirkt",
                    "el": "Επιλεγμένο απενεργοποιημένο",
                    "tr": "İşaretli devre dışı",
                    "hu": "Bejelölve letiltva",
                    "hr": "Označeno onemogućeno",
                    "pl": "Zaznaczone wyłączone",
                    "sk": "Začiarknuté zakázané",
                    "cs": "Zaškrtnuto zakázáno",
                    "lb": "Ausgewielt desaktivéiert",
                ]
            ),
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
            tr(
                "With Error and Helper Text",
                [
                    "de": "Mit Fehler und Hilfetext",
                    "fr": "Avec erreur et texte d'aide",
                    "es": "Con error y texto de ayuda",
                    "it": "Con errore e testo di aiuto",
                    "pt": "Com erro e texto de ajuda",
                    "nl": "Met fout en hulptekst",
                    "da": "Med fejl og hjælpetekst",
                    "sv": "Med fel och hjälptext",
                    "nb": "Med feil og hjelpetekst",
                    "fi": "Virheellä ja aputekstillä",
                    "is": "Með villu og hjálpartexta",
                    "el": "Με σφάλμα και κείμενο βοήθειας",
                    "tr": "Hata ve yardımcı metin ile",
                    "hu": "Hibával és súgószöveggel",
                    "hr": "S pogreškom i tekstom pomoći",
                    "pl": "Z błędem i tekstem pomocniczym",
                    "sk": "S chybou a pomocným textom",
                    "cs": "S chybou a pomocným textem",
                    "lb": "Mat Feeler an Hëllefstext",
                ]
            ),
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
