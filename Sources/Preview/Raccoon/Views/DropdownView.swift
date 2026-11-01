import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct DropdownView: TemplateRepresentable {

    static let sampleOptions = [
        OptionValue(
            title: tr(
                "Architecture & Systems",
                de: "Architektur & Systeme",
                fr: "Architecture et systèmes",
                es: "Arquitectura y sistemas",
                it: "Architettura e sistemi"
            ),
            value: "arch"
        ),
        OptionValue(
            title: tr(
                "Product Thinking",
                de: "Produktdenken",
                fr: "Réflexion produit",
                es: "Pensamiento de producto",
                it: "Pensiero di prodotto"
            ),
            value: "product"
        ),
        OptionValue(
            title: tr(
                "Design Systems",
                de: "Designsysteme",
                fr: "Systèmes de design",
                es: "Sistemas de diseño",
                it: "Design system"
            ),
            value: "design"
        ),
        OptionValue(
            title: tr(
                "Engineering Culture",
                de: "Engineering-Kultur",
                fr: "Culture d'ingénierie",
                es: "Cultura de ingeniería",
                it: "Cultura ingegneristica"
            ),
            value: "culture"
        ),
    ]

    let variants: [PreviewVariant<DropdownData>] = [
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
            DropdownData(
                id: "topic_select",
                label: LabelData(
                    id: "topic_select",
                    title: tr(
                        "Topic",
                        de: "Thema",
                        fr: "Sujet",
                        es: "Tema",
                        it: "Argomento"
                    )
                ),
                value: "product",
                options: sampleOptions,
                helperText: HelperTextData(
                    id: "topic_helper",
                    text: tr(
                        "Choose the primary category for this publication.",
                        de:
                            "Wähle die Hauptkategorie für diese Veröffentlichung.",
                        fr:
                            "Choisissez la catégorie principale de cette publication.",
                        es: "Elige la categoría principal de esta publicación.",
                        it:
                            "Scegli la categoria principale per questa pubblicazione."
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
            DropdownData(
                id: "required_topic",
                label: LabelData(
                    id: "required_topic",
                    title: tr(
                        "Required Category",
                        de: "Erforderliche Kategorie",
                        fr: "Catégorie obligatoire",
                        es: "Categoría obligatoria",
                        it: "Categoria obbligatoria"
                    ),
                    isRequired: true
                ),
                placeholderText: tr(
                    "Please choose a category...",
                    de: "Bitte wähle eine Kategorie …",
                    fr: "Veuillez choisir une catégorie…",
                    es: "Elige una categoría…",
                    it: "Scegli una categoria…"
                ),
                options: sampleOptions,
                errorMessages: ErrorMessageData(
                    id: "required_topic",
                    errorMessages: [
                        tr(
                            "Please select a valid category before publishing.",
                            de:
                                "Bitte wähle vor der Veröffentlichung eine gültige Kategorie.",
                            fr:
                                "Veuillez sélectionner une catégorie valide avant de publier.",
                            es:
                                "Selecciona una categoría válida antes de publicar.",
                            it:
                                "Seleziona una categoria valida prima di pubblicare."
                        )
                    ]
                )
            )
        ),
        #previewVariant(
            tr(
                "SingleSelectData Compatibility",
                [
                    "de": "SingleSelectData-Kompatibilität",
                    "fr": "Compatibilité SingleSelectData",
                    "es": "Compatibilidad con SingleSelectData",
                    "it": "Compatibilità SingleSelectData",
                    "pt": "Compatibilidade com SingleSelectData",
                    "nl": "SingleSelectData-compatibiliteit",
                    "da": "SingleSelectData-kompatibilitet",
                    "sv": "SingleSelectData-kompatibilitet",
                    "nb": "SingleSelectData-kompatibilitet",
                    "fi": "SingleSelectData-yhteensopivuus",
                    "is": "SingleSelectData samhæfni",
                    "el": "Συμβατότητα SingleSelectData",
                    "tr": "SingleSelectData uyumluluğu",
                    "hu": "SingleSelectData kompatibilitás",
                    "hr": "Kompatibilnost sa SingleSelectData",
                    "pl": "Zgodność z SingleSelectData",
                    "sk": "Kompatibilita so SingleSelectData",
                    "cs": "Kompatibilita se SingleSelectData",
                    "lb": "SingleSelectData-Kompatibilitéit",
                ]
            ),
            DropdownData(
                SingleSelectData(
                    id: "author_single_select",
                    label: LabelData(
                        id: "author_single_select",
                        title: tr(
                            "Author (from SingleSelectData)",
                            de: "Autor (aus SingleSelectData)",
                            fr: "Auteur (depuis SingleSelectData)",
                            es: "Autor (desde SingleSelectData)",
                            it: "Autore (da SingleSelectData)"
                        )
                    ),
                    value: "arch",
                    options: sampleOptions,
                    state: .enabled
                )
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
            DropdownData(
                id: "disabled_dropdown",
                label: LabelData(
                    id: "disabled_dropdown",
                    title: tr(
                        "Locked Field",
                        de: "Gesperrtes Feld",
                        fr: "Champ verrouillé",
                        es: "Campo bloqueado",
                        it: "Campo bloccato"
                    )
                ),
                value: "design",
                options: sampleOptions,
                state: .disabled
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
            DropdownData(
                id: "info_dropdown",
                label: LabelData(
                    id: "info_dropdown",
                    title: tr(
                        "Published Category",
                        de: "Veröffentlichte Kategorie",
                        fr: "Catégorie publiée",
                        es: "Categoría publicada",
                        it: "Categoria pubblicata"
                    )
                ),
                value: "culture",
                options: sampleOptions,
                state: .info
            )
        ),
    ]

    func makeHtml(ctx: DropdownData) -> String {
        let html = renderFragments(Dropdown(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {
        Basic(title: "Dropdown") {
            Div {
                showComponentTitle("Dropdown")

                for variant in variants {
                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div {
                            Dropdown(variant.data).render()
                        }
                        .class("mb-32 mt-4 max-w-md")
                    }
                }
            }
            .class("mt-4 space-y-6")
        }
        .render()
    }
}
