import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct SingleSelectView: TemplateRepresentable {

    let variants: [PreviewVariant<SingleSelectData>] = [
        #previewVariant(
            tr(
                "Enabled with Helper Text",
                [
                    "de": "Aktiviert mit Hilfetext",
                    "fr": "Activé avec texte d'aide",
                    "es": "Habilitado con texto de ayuda",
                    "it": "Abilitato con testo di aiuto",
                    "pt": "Habilitado com texto de ajuda",
                    "nl": "Ingeschakeld met hulptekst",
                    "da": "Aktiveret med hjælpetekst",
                    "sv": "Aktiverad med hjälptext",
                    "nb": "Aktivert med hjelpetekst",
                    "fi": "Käytössä aputekstillä",
                    "is": "Virkjað með hjálpartexta",
                    "el": "Ενεργοποιημένο με κείμενο βοήθειας",
                    "tr": "Yardımcı metinli etkin",
                    "hu": "Engedélyezve súgószöveggel",
                    "hr": "Omogućeno s tekstom pomoći",
                    "pl": "Włączone z tekstem pomocniczym",
                    "sk": "Povolené s pomocným textom",
                    "cs": "Povoleno s pomocným textem",
                    "lb": "Aktivéiert mat Hëllefstext",
                ]
            ),
            SingleSelectData(
                id: "select-1",
                name: "select-name-for-forms",
                label: LabelData(
                    id: "select-1",
                    title: tr(
                        "Choose option",
                        de: "Option wählen",
                        fr: "Choisir une option",
                        es: "Elegir opción",
                        it: "Scegli un'opzione"
                    )
                ),
                placeholder: tr(
                    "select-placeholder",
                    de: "Platzhalter für die Auswahl",
                    fr: "espace réservé de sélection",
                    es: "marcador de selección",
                    it: "segnaposto di selezione"
                ),
                options: DemoData.optionList,
                errorMessages: nil,
                helperText: HelperTextData(
                    id: "hlp-1",
                    text: tr(
                        "helper-text-1",
                        de: "Hilfetext 1",
                        fr: "texte d'aide 1",
                        es: "texto de ayuda 1",
                        it: "testo di aiuto 1"
                    )
                ),
                state: .enabled,
                backgroundColor: nil,
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
            SingleSelectData(
                id: "select-2",
                name: "select-name-for-forms",
                label: LabelData(
                    id: "select-2",
                    title: tr(
                        "Choose option",
                        de: "Option wählen",
                        fr: "Choisir une option",
                        es: "Elegir opción",
                        it: "Scegli un'opzione"
                    )
                ),
                placeholder: tr(
                    "select-placeholder",
                    de: "Platzhalter für die Auswahl",
                    fr: "espace réservé de sélection",
                    es: "marcador de selección",
                    it: "segnaposto di selezione"
                ),
                options: DemoData.optionList,
                errorMessages: ErrorMessageData(
                    id: "err-2",
                    errorMessages: [
                        tr(
                            "error-one",
                            de: "Fehler eins",
                            fr: "erreur un",
                            es: "error uno",
                            it: "errore uno"
                        )
                    ],
                    hasIcon: false
                ),
                helperText: HelperTextData(
                    id: "hlp-2",
                    text: tr(
                        "helper-text-1",
                        de: "Hilfetext 1",
                        fr: "texte d'aide 1",
                        es: "texto de ayuda 1",
                        it: "testo di aiuto 1"
                    )
                ),
                state: .enabled,
                backgroundColor: nil,
            )
        ),
        #previewVariant(
            tr(
                "Custom Background Color",
                [
                    "de": "Benutzerdefinierte Hintergrundfarbe",
                    "fr": "Couleur d'arrière-plan personnalisée",
                    "es": "Color de fondo personalizado",
                    "it": "Colore di sfondo personalizzato",
                    "pt": "Cor de fundo personalizada",
                    "nl": "Aangepaste achtergrondkleur",
                    "da": "Brugerdefineret baggrundsfarve",
                    "sv": "Anpassad bakgrundsfärg",
                    "nb": "Egendefinert bakgrunnsfarge",
                    "fi": "Mukautettu taustaväri",
                    "is": "Sérsniðinn bakgrunnslitur",
                    "el": "Προσαρμοσμένο χρώμα φόντου",
                    "tr": "Özel arka plan rengi",
                    "hu": "Egyéni háttérszín",
                    "hr": "Prilagođena boja pozadine",
                    "pl": "Niestandardowy kolor tła",
                    "sk": "Vlastná farba pozadia",
                    "cs": "Vlastní barva pozadí",
                    "lb": "Personaliséiert Hannergrondfaarf",
                ]
            ),
            SingleSelectData(
                id: "select-3",
                name: "select-name-for-forms",
                label: LabelData(
                    id: "select-3",
                    title: tr(
                        "Choose option",
                        de: "Option wählen",
                        fr: "Choisir une option",
                        es: "Elegir opción",
                        it: "Scegli un'opzione"
                    )
                ),
                placeholder: tr(
                    "select-placeholder",
                    de: "Platzhalter für die Auswahl",
                    fr: "espace réservé de sélection",
                    es: "marcador de selección",
                    it: "segnaposto di selezione"
                ),
                options: DemoData.optionList,
                errorMessages: nil,
                helperText: nil,
                state: .enabled,
                backgroundColor: "#4365fc",
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
            SingleSelectData(
                id: "select-4",
                name: "select-name-for-forms",
                label: LabelData(
                    id: "select-4",
                    title: tr(
                        "Choose option",
                        de: "Option wählen",
                        fr: "Choisir une option",
                        es: "Elegir opción",
                        it: "Scegli un'opzione"
                    )
                ),
                placeholder: tr(
                    "select-placeholder",
                    de: "Platzhalter für die Auswahl",
                    fr: "espace réservé de sélection",
                    es: "marcador de selección",
                    it: "segnaposto di selezione"
                ),
                options: DemoData.optionList,
                errorMessages: nil,
                helperText: nil,
                state: .disabled,
                backgroundColor: nil,
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
            SingleSelectData(
                id: "select-5",
                name: "select-name-for-forms",
                label: LabelData(
                    id: "select-5",
                    title: tr(
                        "Choose option",
                        de: "Option wählen",
                        fr: "Choisir une option",
                        es: "Elegir opción",
                        it: "Scegli un'opzione"
                    )
                ),
                placeholder: tr(
                    "select-placeholder",
                    de: "Platzhalter für die Auswahl",
                    fr: "espace réservé de sélection",
                    es: "marcador de selección",
                    it: "segnaposto di selezione"
                ),
                options: DemoData.optionList,
                errorMessages: nil,
                helperText: nil,
                state: .info,
                backgroundColor: nil,
            )
        ),
        #previewVariant(
            tr(
                "Minimal without Labels",
                [
                    "de": "Minimal ohne Beschriftungen",
                    "fr": "Minimal sans étiquettes",
                    "es": "Mínimo sin etiquetas",
                    "it": "Minimale senza etichette",
                    "pt": "Mínimo sem etiquetas",
                    "nl": "Minimaal zonder labels",
                    "da": "Minimal uden etiketter",
                    "sv": "Minimal utan etiketter",
                    "nb": "Minimal uten etiketter",
                    "fi": "Minimaalinen ilman nimikkeitä",
                    "is": "Lágmarks án merkja",
                    "el": "Ελάχιστο χωρίς ετικέτες",
                    "tr": "Etiketsiz minimal",
                    "hu": "Minimális címkék nélkül",
                    "hr": "Minimalno bez oznaka",
                    "pl": "Minimalne bez etykiet",
                    "sk": "Minimálne bez štítkov",
                    "cs": "Minimální bez popisků",
                    "lb": "Minimal ouni Etiketten",
                ]
            ),
            SingleSelectData(
                id: "select-6",
                name: nil,
                label: nil,
                placeholder: nil,
                options: DemoData.optionList,
                errorMessages: nil,
                helperText: nil,
                state: .enabled,
                backgroundColor: nil,
            )
        ),
        #previewVariant(
            tr(
                "Unmatched Value Fallback",
                [
                    "de": "Fallback für nicht übereinstimmenden Wert",
                    "fr": "Repli pour valeur non correspondante",
                    "es": "Respaldo para valor no coincidente",
                    "it": "Fallback per valore non corrispondente",
                    "pt": "Alternativa para valor não correspondente",
                    "nl": "Terugval voor niet-overeenkomende waarde",
                    "da": "Fallback for uoverensstemmende værdi",
                    "sv": "Reserv för icke-matchande värde",
                    "nb": "Reserveløsning for verdi som ikke samsvarer",
                    "fi": "Vastaamattoman arvon varavaihtoehto",
                    "is": "Varakostur fyrir ósamræmt gildi",
                    "el": "Εφεδρεία για μη ταιριαστή τιμή",
                    "tr": "Eşleşmeyen değer yedeği",
                    "hu": "Nem egyező érték tartaléka",
                    "hr": "Zamjena za nepodudarnu vrijednost",
                    "pl": "Wartość domyślna dla niedopasowanej wartości",
                    "sk": "Záloha pre nezhodnú hodnotu",
                    "cs": "Záloha pro neodpovídající hodnotu",
                    "lb": "Fallback fir net iwwereneestëmmende Wäert",
                ]
            ),
            SingleSelectData(
                id: "select-7",
                name: "select-name-for-forms",
                label: LabelData(
                    id: "select-7",
                    title: tr(
                        "Choose option",
                        de: "Option wählen",
                        fr: "Choisir une option",
                        es: "Elegir opción",
                        it: "Scegli un'opzione"
                    )
                ),
                placeholder: tr(
                    "select-placeholder",
                    de: "Platzhalter für die Auswahl",
                    fr: "espace réservé de sélection",
                    es: "marcador de selección",
                    it: "segnaposto di selezione"
                ),
                value: "blabla",
                options: DemoData.optionList,
                errorMessages: nil,
                helperText: HelperTextData(
                    id: "hlp-7",
                    text: tr(
                        "helper-text-1",
                        de: "Hilfetext 1",
                        fr: "texte d'aide 1",
                        es: "texto de ayuda 1",
                        it: "testo di aiuto 1"
                    )
                ),
                state: .enabled,
                backgroundColor: nil,
            )
        ),
        #previewVariant(
            tr(
                "Pre-selected Matching Value",
                [
                    "de": "Vorausgewählter passender Wert",
                    "fr": "Valeur correspondante présélectionnée",
                    "es": "Valor coincidente preseleccionado",
                    "it": "Valore corrispondente preselezionato",
                    "pt": "Valor correspondente pré-selecionado",
                    "nl": "Vooraf geselecteerde overeenkomende waarde",
                    "da": "Forudvalgt matchende værdi",
                    "sv": "Förvalt matchande värde",
                    "nb": "Forhåndsvalgt matchende verdi",
                    "fi": "Esivalittu vastaava arvo",
                    "is": "Forvalið samsvarandi gildi",
                    "el": "Προεπιλεγμένη ταιριαστή τιμή",
                    "tr": "Önceden seçilmiş eşleşen değer",
                    "hu": "Előre kiválasztott egyező érték",
                    "hr": "Unaprijed odabrana podudarna vrijednost",
                    "pl": "Wstępnie wybrana pasująca wartość",
                    "sk": "Predvolená zodpovedajúca hodnota",
                    "cs": "Předvolená odpovídající hodnota",
                    "lb": "Virausgewielte passende Wäert",
                ]
            ),
            SingleSelectData(
                id: "select-8",
                name: "select-name-for-forms",
                label: LabelData(
                    id: "select-8",
                    title: tr(
                        "Choose option",
                        de: "Option wählen",
                        fr: "Choisir une option",
                        es: "Elegir opción",
                        it: "Scegli un'opzione"
                    )
                ),
                placeholder: tr(
                    "select-placeholder",
                    de: "Platzhalter für die Auswahl",
                    fr: "espace réservé de sélection",
                    es: "marcador de selección",
                    it: "segnaposto di selezione"
                ),
                value: "a",
                options: DemoData.optionList,
                errorMessages: nil,
                helperText: HelperTextData(
                    id: "hlp-8",
                    text: tr(
                        "helper-text-1",
                        de: "Hilfetext 1",
                        fr: "texte d'aide 1",
                        es: "texto de ayuda 1",
                        it: "testo di aiuto 1"
                    )
                ),
                state: .enabled,
                backgroundColor: nil,
            )
        ),
    ]

    func makeHtml(ctx: SingleSelectData) -> String {
        let html = renderFragments(SingleSelect(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("SingleSelect")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { SingleSelect(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
