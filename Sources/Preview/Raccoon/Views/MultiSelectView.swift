import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct MultiSelectView: TemplateRepresentable {

    let variants: [PreviewVariant<MultiSelectData>] = [
        #previewVariant(
            tr(
                "Pre-selected with Helper Text",
                [
                    "de": "Vorausgewählt mit Hilfetext",
                    "fr": "Présélectionné avec texte d'aide",
                    "es": "Preseleccionado con texto de ayuda",
                    "it": "Preselezionato con testo di aiuto",
                    "pt": "Pré-selecionado com texto de ajuda",
                    "nl": "Vooraf geselecteerd met hulptekst",
                    "da": "Forudvalgt med hjælpetekst",
                    "sv": "Förvalt med hjälptext",
                    "nb": "Forhåndsvalgt med hjelpetekst",
                    "fi": "Esivalittu aputekstillä",
                    "is": "Forvalið með hjálpartexta",
                    "el": "Προεπιλεγμένο με κείμενο βοήθειας",
                    "tr": "Yardımcı metinli önceden seçilmiş",
                    "hu": "Előre kiválasztva súgószöveggel",
                    "hr": "Unaprijed odabrano s tekstom pomoći",
                    "pl": "Wstępnie wybrane z tekstem pomocniczym",
                    "sk": "Predvolené s pomocným textom",
                    "cs": "Předvoleno s pomocným textem",
                    "lb": "Virausgewielt mat Hëllefstext",
                ]
            ),
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
            tr(
                "Validation Error State",
                [
                    "de": "Validierungsfehler-Zustand",
                    "fr": "État d'erreur de validation",
                    "es": "Estado de error de validación",
                    "it": "Stato di errore di validazione",
                    "pt": "Estado de erro de validação",
                    "nl": "Validatiefoutstatus",
                    "da": "Valideringsfejltilstand",
                    "sv": "Valideringsfeltillstånd",
                    "nb": "Valideringsfeiltilstand",
                    "fi": "Vahvistusvirhetila",
                    "is": "Villustaða sannprófunar",
                    "el": "Κατάσταση σφάλματος επικύρωσης",
                    "tr": "Doğrulama hatası durumu",
                    "hu": "Érvényesítési hibaállapot",
                    "hr": "Stanje pogreške provjere",
                    "pl": "Stan błędu walidacji",
                    "sk": "Stav chyby overenia",
                    "cs": "Stav chyby ověření",
                    "lb": "Validéierungsfeeler-Zoustand",
                ]
            ),
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
            tr(
                "Read-Only Info State",
                [
                    "de": "Schreibgeschützter Info-Zustand",
                    "fr": "État d'information en lecture seule",
                    "es": "Estado informativo de solo lectura",
                    "it": "Stato informativo di sola lettura",
                    "pt": "Estado de informação somente leitura",
                    "nl": "Alleen-lezen informatiestatus",
                    "da": "Skrivebeskyttet informationstilstand",
                    "sv": "Skrivskyddat informationstillstånd",
                    "nb": "Skrivebeskyttet informasjonstilstand",
                    "fi": "Vain luku -tietotila",
                    "is": "Skrifvarin upplýsingastaða",
                    "el": "Κατάσταση πληροφοριών μόνο για ανάγνωση",
                    "tr": "Salt okunur bilgi durumu",
                    "hu": "Csak olvasható információs állapot",
                    "hr": "Samo za čitanje stanje informacija",
                    "pl": "Stan informacyjny tylko do odczytu",
                    "sk": "Stav informácií len na čítanie",
                    "cs": "Stav informací pouze pro čtení",
                    "lb": "Schreifgeschützte Info-Zoustand",
                ]
            ),
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
            tr(
                "Read-Only Info with Custom Background",
                [
                    "de": "Schreibgeschützte Info mit benutzerdefiniertem Hintergrund",
                    "fr": "Info en lecture seule avec arrière-plan personnalisé",
                    "es": "Información de solo lectura con fondo personalizado",
                    "it": "Info di sola lettura con sfondo personalizzato",
                    "pt": "Informação somente leitura com fundo personalizado",
                    "nl": "Alleen-lezen info met aangepaste achtergrond",
                    "da": "Skrivebeskyttet info med brugerdefineret baggrund",
                    "sv": "Skrivskyddad info med anpassad bakgrund",
                    "nb": "Skrivebeskyttet info med egendefinert bakgrunn",
                    "fi": "Vain luku -info mukautetulla taustalla",
                    "is": "Skrifvarðar upplýsingar með sérsniðnum bakgrunni",
                    "el": "Πληροφορίες μόνο για ανάγνωση με προσαρμοσμένο φόντο",
                    "tr": "Özel arka planlı salt okunur bilgi",
                    "hu": "Csak olvasható infó egyéni háttérrel",
                    "hr": "Informacije samo za čitanje s prilagođenom pozadinom",
                    "pl": "Informacja tylko do odczytu z niestandardowym tłem",
                    "sk": "Informácie len na čítanie s vlastným pozadím",
                    "cs": "Informace pouze pro čtení s vlastním pozadím",
                    "lb": "Schreifgeschützt Info mat personaliséiertem Hannergrond",
                ]
            ),
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
            tr(
                "Disabled with Custom Background",
                [
                    "de": "Deaktiviert mit benutzerdefiniertem Hintergrund",
                    "fr": "Désactivé avec arrière-plan personnalisé",
                    "es": "Deshabilitado con fondo personalizado",
                    "it": "Disabilitato con sfondo personalizzato",
                    "pt": "Desativado com fundo personalizado",
                    "nl": "Uitgeschakeld met aangepaste achtergrond",
                    "da": "Deaktiveret med brugerdefineret baggrund",
                    "sv": "Inaktiverad med anpassad bakgrund",
                    "nb": "Deaktivert med egendefinert bakgrunn",
                    "fi": "Pois käytöstä mukautetulla taustalla",
                    "is": "Óvirkt með sérsniðnum bakgrunni",
                    "el": "Απενεργοποιημένο με προσαρμοσμένο φόντο",
                    "tr": "Özel arka planlı devre dışı",
                    "hu": "Letiltva egyéni háttérrel",
                    "hr": "Onemogućeno s prilagođenom pozadinom",
                    "pl": "Wyłączone z niestandardowym tłem",
                    "sk": "Zakázané s vlastným pozadím",
                    "cs": "Zakázáno s vlastním pozadím",
                    "lb": "Desaktivéiert mat personaliséiertem Hannergrond",
                ]
            ),
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
            tr(
                "Disabled State",
                [
                    "de": "Deaktivierter Zustand",
                    "fr": "État désactivé",
                    "es": "Estado deshabilitado",
                    "it": "Stato disabilitato",
                    "pt": "Estado desativado",
                    "nl": "Uitgeschakelde status",
                    "da": "Deaktiveret tilstand",
                    "sv": "Inaktiverat tillstånd",
                    "nb": "Deaktivert tilstand",
                    "fi": "Pois käytöstä -tila",
                    "is": "Óvirk staða",
                    "el": "Απενεργοποιημένη κατάσταση",
                    "tr": "Devre dışı durum",
                    "hu": "Letiltott állapot",
                    "hr": "Onemogućeno stanje",
                    "pl": "Stan wyłączony",
                    "sk": "Zakázaný stav",
                    "cs": "Zakázaný stav",
                    "lb": "Desaktivéierten Zoustand",
                ]
            ),
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
