import HTML
import Raccoon
import SGML
import WebBuilders

struct RadioGroupView: TemplateRepresentable {

    /// Option ids must be unique on the page, so every group gets its own prefix.
    private static func plans(_ prefix: String) -> [RadioData] {
        [
            RadioData(
                id: "\(prefix)-free",
                label: tr(
                    "Free",
                    de: "Kostenlos",
                    fr: "Gratuit",
                    es: "Gratis",
                    it: "Gratuito"
                ),
                value: "free"
            ),
            RadioData(
                id: "\(prefix)-pro",
                label: tr("Pro", de: "Pro", fr: "Pro", es: "Pro", it: "Pro"),
                value: "pro"
            ),
            RadioData(
                id: "\(prefix)-team",
                label: tr(
                    "Team",
                    de: "Team",
                    fr: "Équipe",
                    es: "Equipo",
                    it: "Team"
                ),
                value: "team"
            ),
        ]
    }

    let variants: [PreviewVariant<RadioGroupData>] = [
        #previewVariant(
            tr(
                "Unselected Optional Group",
                [
                    "de": "Nicht ausgewählte optionale Gruppe",
                    "fr": "Groupe optionnel non sélectionné",
                    "es": "Grupo opcional sin seleccionar",
                    "it": "Gruppo opzionale non selezionato",
                    "pt": "Grupo opcional não selecionado",
                    "nl": "Niet-geselecteerde optionele groep",
                    "da": "Ikke-valgt valgfri gruppe",
                    "sv": "Omarkerad valfri grupp",
                    "nb": "Ikke-valgt valgfri gruppe",
                    "fi": "Valitsematon valinnainen ryhmä",
                    "is": "Óvalinn valfrjáls hópur",
                    "el": "Μη επιλεγμένη προαιρετική ομάδα",
                    "tr": "Seçilmemiş isteğe bağlı grup",
                    "hu": "Kijelöletlen opcionális csoport",
                    "hr": "Neodabrana opcionalna grupa",
                    "pl": "Niezaznaczona grupa opcjonalna",
                    "sk": "Nevybraná voliteľná skupina",
                    "cs": "Nevybraná volitelná skupina",
                    "lb": "Net ausgewielt fakultativ Grupp",
                ]
            ),
            RadioGroupData(
                id: "group-1",
                name: "plan-1",
                label: LabelData(
                    id: "group-1",
                    title: tr(
                        "Plan",
                        de: "Tarif",
                        fr: "Forfait",
                        es: "Plan",
                        it: "Piano"
                    ),
                    isRequired: false
                ),
                options: plans("g1")
            )
        ),
        #previewVariant(
            tr(
                "Preselected Required Group",
                [
                    "de": "Vorausgewählte erforderliche Gruppe",
                    "fr": "Groupe obligatoire présélectionné",
                    "es": "Grupo obligatorio preseleccionado",
                    "it": "Gruppo obbligatorio preselezionato",
                    "pt": "Grupo obrigatório pré-selecionado",
                    "nl": "Vooraf geselecteerde verplichte groep",
                    "da": "Forudvalgt påkrævet gruppe",
                    "sv": "Förvald obligatorisk grupp",
                    "nb": "Forhåndsvalgt obligatorisk gruppe",
                    "fi": "Esivalittu pakollinen ryhmä",
                    "is": "Forvalinn áskilinn hópur",
                    "el": "Προεπιλεγμένη απαιτούμενη ομάδα",
                    "tr": "Önceden seçilmiş zorunlu grup",
                    "hu": "Előre kiválasztott kötelező csoport",
                    "hr": "Unaprijed odabrana obavezna grupa",
                    "pl": "Wstępnie wybrana grupa wymagana",
                    "sk": "Predvolená povinná skupina",
                    "cs": "Předvolená povinná skupina",
                    "lb": "Virausgewielt erfuerderlech Grupp",
                ]
            ),
            RadioGroupData(
                id: "group-2",
                name: "plan-2",
                label: LabelData(
                    id: "group-2",
                    title: tr(
                        "Plan",
                        de: "Tarif",
                        fr: "Forfait",
                        es: "Plan",
                        it: "Piano"
                    )
                ),
                selectedValue: "pro",
                options: plans("g2")
            )
        ),
        #previewVariant(
            tr(
                "Group with Helper Text",
                [
                    "de": "Gruppe mit Hilfetext",
                    "fr": "Groupe avec texte d'aide",
                    "es": "Grupo con texto de ayuda",
                    "it": "Gruppo con testo di aiuto",
                    "pt": "Grupo com texto de ajuda",
                    "nl": "Groep met hulptekst",
                    "da": "Gruppe med hjælpetekst",
                    "sv": "Grupp med hjälptext",
                    "nb": "Gruppe med hjelpetekst",
                    "fi": "Ryhmä aputekstillä",
                    "is": "Hópur með hjálpartexta",
                    "el": "Ομάδα με κείμενο βοήθειας",
                    "tr": "Yardımcı metinli grup",
                    "hu": "Csoport súgószöveggel",
                    "hr": "Grupa s tekstom pomoći",
                    "pl": "Grupa z tekstem pomocniczym",
                    "sk": "Skupina s pomocným textom",
                    "cs": "Skupina s pomocným textem",
                    "lb": "Grupp mat Hëllefstext",
                ]
            ),
            RadioGroupData(
                id: "group-3",
                name: "plan-3",
                label: LabelData(
                    id: "group-3",
                    title: tr(
                        "Plan",
                        de: "Tarif",
                        fr: "Forfait",
                        es: "Plan",
                        it: "Piano"
                    ),
                    isRequired: false
                ),
                selectedValue: "free",
                options: plans("g3"),
                helperText: HelperTextData(
                    id: "group-3",
                    text: tr(
                        "You can change your plan at any time.",
                        de: "Du kannst deinen Tarif jederzeit ändern.",
                        fr: "Vous pouvez changer de forfait à tout moment.",
                        es: "Puedes cambiar de plan en cualquier momento.",
                        it: "Puoi cambiare piano in qualsiasi momento."
                    )
                )
            )
        ),
        #previewVariant(
            tr(
                "Group Validation Error",
                [
                    "de": "Gruppen-Validierungsfehler",
                    "fr": "Erreur de validation de groupe",
                    "es": "Error de validación de grupo",
                    "it": "Errore di validazione del gruppo",
                    "pt": "Erro de validação do grupo",
                    "nl": "Groepsvalidatiefout",
                    "da": "Gruppe-valideringsfejl",
                    "sv": "Gruppvalideringsfel",
                    "nb": "Gruppe-valideringsfeil",
                    "fi": "Ryhmän vahvistusvirhe",
                    "is": "Villuboð hópsannprófunar",
                    "el": "Σφάλμα επικύρωσης ομάδας",
                    "tr": "Grup doğrulama hatası",
                    "hu": "Csoportos érvényesítési hiba",
                    "hr": "Pogreška provjere grupe",
                    "pl": "Błąd walidacji grupy",
                    "sk": "Chyba overenia skupiny",
                    "cs": "Chyba ověření skupiny",
                    "lb": "Gruppe-Validéierungsfeeler",
                ]
            ),
            RadioGroupData(
                id: "group-4",
                name: "plan-4",
                label: LabelData(
                    id: "group-4",
                    title: tr(
                        "Plan",
                        de: "Tarif",
                        fr: "Forfait",
                        es: "Plan",
                        it: "Piano"
                    )
                ),
                options: plans("g4"),
                errorMessages: ErrorMessageData(
                    id: "group-4",
                    errorMessages: [
                        tr(
                            "Select a plan.",
                            de: "Wähle einen Tarif.",
                            fr: "Sélectionnez un forfait.",
                            es: "Selecciona un plan.",
                            it: "Seleziona un piano."
                        )
                    ],
                    hasIcon: true
                ),
                helperText: HelperTextData(
                    id: "group-4",
                    text: tr(
                        "You can change your plan at any time.",
                        de: "Du kannst deinen Tarif jederzeit ändern.",
                        fr: "Vous pouvez changer de forfait à tout moment.",
                        es: "Puedes cambiar de plan en cualquier momento.",
                        it: "Puoi cambiare piano in qualsiasi momento."
                    )
                )
            )
        ),
        #previewVariant(
            tr(
                "Individual Option Disabled with Helper Text",
                [
                    "de": "Einzelne Option deaktiviert mit Hilfetext",
                    "fr": "Option individuelle désactivée avec texte d'aide",
                    "es": "Opción individual deshabilitada con texto de ayuda",
                    "it": "Opzione singola disabilitata con testo di aiuto",
                    "pt": "Opção individual desativada com texto de ajuda",
                    "nl": "Individuele optie uitgeschakeld met hulptekst",
                    "da": "Individuel mulighed deaktiveret med hjælpetekst",
                    "sv": "Enskilt alternativ inaktiverat med hjälptext",
                    "nb": "Individuelt alternativ deaktivert med hjelpetekst",
                    "fi": "Yksittäinen vaihtoehto pois käytöstä aputekstillä",
                    "is": "Einstakur valkostur óvirkur með hjálpartexta",
                    "el": "Μεμονωμένη επιλογή απενεργοποιημένη με κείμενο βοήθειας",
                    "tr": "Yardımcı metinli devre dışı bireysel seçenek",
                    "hu": "Egyedi opció letiltva súgószöveggel",
                    "hr": "Pojedinačna opcija onemogućena s tekstom pomoći",
                    "pl": "Pojedyncza opcja wyłączona z tekstem pomocniczym",
                    "sk": "Jednotlivá možnosť zakázaná s pomocným textom",
                    "cs": "Jednotlivá možnost zakázána s pomocným textem",
                    "lb": "Eenzel Optioun desaktivéiert mat Hëllefstext",
                ]
            ),
            RadioGroupData(
                id: "group-5",
                name: "plan-5",
                label: LabelData(
                    id: "group-5",
                    title: tr(
                        "Plan",
                        de: "Tarif",
                        fr: "Forfait",
                        es: "Plan",
                        it: "Piano"
                    ),
                    isRequired: false
                ),
                selectedValue: "free",
                options: [
                    RadioData(
                        id: "plan-5-free",
                        label: tr(
                            "Free",
                            de: "Kostenlos",
                            fr: "Gratuit",
                            es: "Gratis",
                            it: "Gratuito"
                        ),
                        value: "free"
                    ),
                    RadioData(
                        id: "plan-5-pro",
                        label: tr(
                            "Pro",
                            de: "Pro",
                            fr: "Pro",
                            es: "Pro",
                            it: "Pro"
                        ),
                        value: "pro",
                        helperText: HelperTextData(
                            id: "plan-5-pro",
                            text: tr(
                                "Includes support.",
                                de: "Inklusive Support.",
                                fr: "Support inclus.",
                                es: "Incluye soporte.",
                                it: "Supporto incluso."
                            )
                        ),
                        state: .disabled
                    ),
                    RadioData(
                        id: "plan-5-team",
                        label: tr(
                            "Team",
                            de: "Team",
                            fr: "Équipe",
                            es: "Equipo",
                            it: "Team"
                        ),
                        value: "team"
                    ),
                ]
            )
        ),
        #previewVariant(
            tr(
                "Entire Group Disabled",
                [
                    "de": "Ganze Gruppe deaktiviert",
                    "fr": "Groupe entier désactivé",
                    "es": "Grupo entero deshabilitado",
                    "it": "Intero gruppo disabilitato",
                    "pt": "Grupo inteiro desativado",
                    "nl": "Hele groep uitgeschakeld",
                    "da": "Hele gruppen deaktiveret",
                    "sv": "Hela gruppen inaktiverad",
                    "nb": "Hele gruppen deaktivert",
                    "fi": "Koko ryhmä pois käytöstä",
                    "is": "Allur hópurinn óvirkur",
                    "el": "Ολόκληρη η ομάδα απενεργοποιημένη",
                    "tr": "Tüm grup devre dışı",
                    "hu": "Egész csoport letiltva",
                    "hr": "Cijela grupa onemogućena",
                    "pl": "Cała grupa wyłączona",
                    "sk": "Celá skupina zakázaná",
                    "cs": "Celá skupina zakázána",
                    "lb": "Ganz Grupp desaktivéiert",
                ]
            ),
            RadioGroupData(
                id: "group-6",
                name: "plan-6",
                label: LabelData(
                    id: "group-6",
                    title: tr(
                        "Plan",
                        de: "Tarif",
                        fr: "Forfait",
                        es: "Plan",
                        it: "Piano"
                    ),
                    isRequired: false
                ),
                selectedValue: "pro",
                options: plans("g6"),
                state: .disabled
            )
        ),
    ]

    func makeHtml(ctx: RadioGroupData) -> String {
        let html = renderFragments(RadioGroup(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("RadioGroup")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { RadioGroup(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
