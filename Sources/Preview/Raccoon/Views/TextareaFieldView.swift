import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct TextareaFieldView: TemplateRepresentable {

    let variants: [PreviewVariant<TextAreaFieldData>] = [
        #previewVariant(
            tr(
                "First & Last Name Validation",
                [
                    "de": "Vor- und Nachnamens-Validierung",
                    "fr": "Validation nom et prénom",
                    "es": "Validación de nombre y apellido",
                    "it": "Validazione nome e cognome",
                    "pt": "Validação de nome e sobrenome",
                    "nl": "Voor- en achternaamvalidatie",
                    "da": "Validering af for- og efternavn",
                    "sv": "Validering av för- och efternamn",
                    "nb": "Validering av for- og etternavn",
                    "fi": "Etu- ja sukunimen vahvistus",
                    "is": "Sannprófun fornafns og eftirnafns",
                    "el": "Επαλήθευση ονόματος και επωνύμου",
                    "tr": "Ad ve soyad doğrulaması",
                    "hu": "Kereszt- és vezetéknév érvényesítése",
                    "hr": "Provjera imena i prezimena",
                    "pl": "Walidacja imienia i nazwiska",
                    "sk": "Overenie mena a priezviska",
                    "cs": "Ověření jména a příjmení",
                    "lb": "Vir- a Familljennumm-Validéierung",
                ]
            ),
            TextAreaFieldData(
                id: "tf-1",
                label: LabelData(
                    id: "tf-1",
                    title: tr(
                        "Name",
                        de: "Name",
                        fr: "Nom",
                        es: "Nombre",
                        it: "Nome"
                    ),
                    isRequired: false
                ),
                placeholder: tr(
                    "Placeholder text",
                    de: "Platzhaltertext",
                    fr: "Texte d'espace réservé",
                    es: "Texto de marcador",
                    it: "Testo segnaposto"
                ),
                rows: 1,
                value:
                    """
                    John Doe
                    """,
                validation: .firstLastName,
                errorMessages: nil,
                helperText: HelperTextData(
                    id: "hlp1",
                    text: tr(
                        "Helper text",
                        de: "Hilfetext",
                        fr: "Texte d'aide",
                        es: "Texto de ayuda",
                        it: "Testo di aiuto"
                    )
                ),
                isMonospaced: false
            )
        ),
        #previewVariant(
            tr(
                "Required Email with Validation Errors",
                [
                    "de": "Erforderliche E-Mail mit Validierungsfehlern",
                    "fr": "E-mail obligatoire avec erreurs de validation",
                    "es": "Correo obligatorio con errores de validación",
                    "it": "E-mail obbligatoria con errori di validazione",
                    "pt": "E-mail obrigatório com erros de validação",
                    "nl": "Verplichte e-mail met validatiefouten",
                    "da": "Påkrævet e-mail med valideringsfejl",
                    "sv": "Obligatorisk e-post med valideringsfel",
                    "nb": "Obligatorisk e-post med valideringsfeil",
                    "fi": "Pakollinen sähköposti vahvistusvirheillä",
                    "is": "Áskilið netfang með villum",
                    "el": "Απαιτούμενο email με σφάλματα επικύρωσης",
                    "tr": "Doğrulama hatalı zorunlu e-posta",
                    "hu": "Kötelező e-mail érvényesítési hibákkal",
                    "hr": "Obavezna e-pošta s pogreškama provjere",
                    "pl": "Wymagany adres e-mail z błędami walidacji",
                    "sk": "Povinný e-mail s chybami overenia",
                    "cs": "Povinný e-mail s chybami ověření",
                    "lb": "Erfuerderlech E-Mail mat Validéierungsfeeleren",
                ]
            ),
            TextAreaFieldData(
                id: "tf-2",
                label: LabelData(
                    id: "tf-2",
                    title: tr(
                        "Email",
                        de: "E-Mail",
                        fr: "E-mail",
                        es: "Correo electrónico",
                        it: "E-mail"
                    ),
                    isRequired: true
                ),
                placeholder: "john.doe@example.com",
                rows: 1,
                value: nil,
                validation: .email,
                errorMessages: ErrorMessageData(
                    id: "err",
                    errorMessages: [
                        tr(
                            "Test error 1",
                            de: "Testfehler 1",
                            fr: "Erreur de test 1",
                            es: "Error de prueba 1",
                            it: "Errore di test 1"
                        ),
                        tr(
                            "Test error 2",
                            de: "Testfehler 2",
                            fr: "Erreur de test 2",
                            es: "Error de prueba 2",
                            it: "Errore di test 2"
                        ),
                    ],
                    hasIcon: true
                ),
                helperText: HelperTextData(
                    id: "hlp2",
                    text: tr(
                        "Helper text",
                        de: "Hilfetext",
                        fr: "Texte d'aide",
                        es: "Texto de ayuda",
                        it: "Testo di aiuto"
                    )
                ),
                isMonospaced: false
            )
        ),
        #previewVariant(
            tr(
                "URL Validation",
                [
                    "de": "URL-Validierung",
                    "fr": "Validation d'URL",
                    "es": "Validación de URL",
                    "it": "Validazione URL",
                    "pt": "Validação de URL",
                    "nl": "URL-validatie",
                    "da": "URL-validering",
                    "sv": "URL-validering",
                    "nb": "URL-validering",
                    "fi": "URL-osoitteen vahvistus",
                    "is": "Sannprófun vefslóðar",
                    "el": "Επαλήθευση URL",
                    "tr": "URL doğrulaması",
                    "hu": "URL érvényesítése",
                    "hr": "Provjera URL-a",
                    "pl": "Walidacja adresu URL",
                    "sk": "Overenie URL",
                    "cs": "Ověření URL",
                    "lb": "URL-Validéierung",
                ]
            ),
            TextAreaFieldData(
                id: "tf-3",
                label: LabelData(
                    id: "tf-3",
                    title: "URL",
                    isRequired: false
                ),
                placeholder: "https://example.com",
                rows: 1,
                value: nil,
                validation: .url,
                errorMessages: nil,
                helperText: HelperTextData(
                    id: "hlp3",
                    text:
                        tr(
                            "Enter a valid URL starting with http:// or https://",
                            de:
                                "Gib eine gültige URL ein, die mit http:// oder https:// beginnt",
                            fr:
                                "Saisissez une URL valide commençant par http:// ou https://",
                            es:
                                "Introduce una URL válida que empiece por http:// o https://",
                            it:
                                "Inserisci un URL valido che inizi con http:// o https://"
                        )
                ),
                isMonospaced: false
            )
        ),
        #previewVariant(
            tr(
                "Integer Validation (2 Rows)",
                [
                    "de": "Ganzzahl-Validierung (2 Zeilen)",
                    "fr": "Validation d'entier (2 lignes)",
                    "es": "Validación de entero (2 filas)",
                    "it": "Validazione intero (2 righe)",
                    "pt": "Validação de inteiro (2 linhas)",
                    "nl": "Geheel getal-validatie (2 regels)",
                    "da": "Heltalsvalidering (2 rækker)",
                    "sv": "Heltalsvalidering (2 rader)",
                    "nb": "Heltallsvalidering (2 rader)",
                    "fi": "Kokonaisluvun vahvistus (2 riviä)",
                    "is": "Sannprófun heiltölu (2 línur)",
                    "el": "Επαλήθευση ακέραιου αριθμού (2 γραμμές)",
                    "tr": "Tam sayı doğrulaması (2 satır)",
                    "hu": "Egész szám érvényesítése (2 sor)",
                    "hr": "Provjera cijelog broja (2 retka)",
                    "pl": "Walidacja liczby całkowitej (2 wiersze)",
                    "sk": "Overenie celého čísla (2 riadky)",
                    "cs": "Ověření celého čísla (2 řádky)",
                    "lb": "Ganzzuel-Validéierung (2 Zeilen)",
                ]
            ),
            TextAreaFieldData(
                id: "tf-4",
                label: LabelData(
                    id: "tf-4",
                    title: tr(
                        "Integer",
                        de: "Ganzzahl",
                        fr: "Entier",
                        es: "Entero",
                        it: "Intero"
                    ),
                    isRequired: false
                ),
                placeholder: "12345",
                rows: 2,
                value: nil,
                validation: .integer,
                errorMessages: nil,
                helperText: HelperTextData(
                    id: "hlp4",
                    text: tr(
                        "Enter an integer value",
                        de: "Gib eine ganze Zahl ein",
                        fr: "Saisissez un nombre entier",
                        es: "Introduce un número entero",
                        it: "Inserisci un numero intero"
                    )
                ),
                isMonospaced: false
            )
        ),
        #previewVariant(
            tr(
                "Monospaced Amount Validation",
                [
                    "de": "Monospaced Betrags-Validierung",
                    "fr": "Validation de montant à chasse fixe",
                    "es": "Validación de importe monoespaciado",
                    "it": "Validazione importo a spaziatura fissa",
                    "pt": "Validação de valor com fonte monoespaçada",
                    "nl": "Monospaced bedragvalidatie",
                    "da": "Monospace-beløbsvalidering",
                    "sv": "Beloppsvalidering med fast bredd",
                    "nb": "Beløpsvalidering med fast tegnbredde",
                    "fi": "Tasavälisen summan vahvistus",
                    "is": "Sannprófun upphæðar með jafnbreiðu letri",
                    "el": "Επαλήθευση ποσού σταθερού πλάτους",
                    "tr": "Eşaralıklı tutar doğrulaması",
                    "hu": "Fix szélességű összeg érvényesítése",
                    "hr": "Provjera iznosa s fiksnom širinom znakova",
                    "pl": "Walidacja kwoty o stałej szerokości znaków",
                    "sk": "Overenie sumy s neproporcionálnym písmom",
                    "cs": "Ověření částky s neproporcionálním písmem",
                    "lb": "Monospaced Betrags-Validéierung",
                ]
            ),
            TextAreaFieldData(
                id: "tf-5",
                label: LabelData(
                    id: "tf-5",
                    title: tr(
                        "Amount",
                        de: "Betrag",
                        fr: "Montant",
                        es: "Importe",
                        it: "Importo"
                    ),
                    isRequired: false
                ),
                placeholder: "12.34",
                rows: 1,
                value: nil,
                validation: .amount,
                errorMessages: nil,
                helperText: HelperTextData(
                    id: "hlp5",
                    text: tr(
                        "Enter an amount with 2 decimals",
                        de: "Gib einen Betrag mit 2 Nachkommastellen ein",
                        fr: "Saisissez un montant avec 2 décimales",
                        es: "Introduce un importe con 2 decimales",
                        it: "Inserisci un importo con 2 decimali"
                    )
                ),
                isMonospaced: true
            )
        ),
        #previewVariant(
            tr(
                "Phone Number Validation",
                [
                    "de": "Telefonnummern-Validierung",
                    "fr": "Validation de numéro de téléphone",
                    "es": "Validación de número de teléfono",
                    "it": "Validazione numero di telefono",
                    "pt": "Validação de número de telefone",
                    "nl": "Telefoonnummervalidatie",
                    "da": "Telefonnummervalidering",
                    "sv": "Telefonnummervalidering",
                    "nb": "Telefonnummervalidering",
                    "fi": "Puhelinnumeron vahvistus",
                    "is": "Sannprófun símanúmers",
                    "el": "Επαλήθευση αριθμού τηλεφώνου",
                    "tr": "Telefon numarası doğrulaması",
                    "hu": "Telefonszám érvényesítése",
                    "hr": "Provjera telefonskog broja",
                    "pl": "Walidacja numeru telefonu",
                    "sk": "Overenie telefónneho čísla",
                    "cs": "Ověření telefonního čísla",
                    "lb": "Telefonsnummer-Validéierung",
                ]
            ),
            TextAreaFieldData(
                id: "tf-6",
                label: LabelData(
                    id: "tf-6",
                    title: tr(
                        "Phone Number",
                        de: "Telefonnummer",
                        fr: "Numéro de téléphone",
                        es: "Número de teléfono",
                        it: "Numero di telefono"
                    ),
                    isRequired: false
                ),
                placeholder: "+491234567890",
                rows: 1,
                value: nil,
                validation: .phoneNumber,
                errorMessages: nil,
                helperText: HelperTextData(
                    id: "hlp6",
                    text: tr(
                        "Enter a phone number in E.164 format",
                        de: "Gib eine Telefonnummer im E.164-Format ein",
                        fr: "Saisissez un numéro de téléphone au format E.164",
                        es: "Introduce un número de teléfono en formato E.164",
                        it: "Inserisci un numero di telefono nel formato E.164"
                    )
                ),
                isMonospaced: false
            )
        ),
        #previewVariant(
            tr(
                "Monospaced IPv4 Address Validation",
                [
                    "de": "Monospaced IPv4-Adressen-Validierung",
                    "fr": "Validation d'adresse IPv4 à chasse fixe",
                    "es": "Validación de dirección IPv4 monoespaciada",
                    "it": "Validazione indirizzo IPv4 a spaziatura fissa",
                    "pt": "Validação de endereço IPv4 monoespaçado",
                    "nl": "Monospaced IPv4-adresvalidatie",
                    "da": "Monospace IPv4-adressevalidering",
                    "sv": "IPv4-adressvalidering med fast bredd",
                    "nb": "IPv4-adressevalidering med fast tegnbredde",
                    "fi": "Tasavälisen IPv4-osoitteen vahvistus",
                    "is": "Sannprófun IPv4-vistfangs með jafnbreiðu letri",
                    "el": "Επαλήθευση διεύθυνσης IPv4 σταθερού πλάτους",
                    "tr": "Eşaralıklı IPv4 adresi doğrulaması",
                    "hu": "Fix szélességű IPv4-cím érvényesítése",
                    "hr": "Provjera IPv4 adrese s fiksnom širinom znakova",
                    "pl": "Walidacja adresu IPv4 o stałej szerokości znaków",
                    "sk": "Overenie adresy IPv4 s neproporcionálnym písmom",
                    "cs": "Ověření adresy IPv4 s neproporcionálním písmem",
                    "lb": "Monospaced IPv4-Adress-Validéierung",
                ]
            ),
            TextAreaFieldData(
                id: "tf-7",
                label: LabelData(
                    id: "tf-7",
                    title: tr(
                        "IPv4 Address",
                        de: "IPv4-Adresse",
                        fr: "Adresse IPv4",
                        es: "Dirección IPv4",
                        it: "Indirizzo IPv4"
                    ),
                    isRequired: false
                ),
                placeholder: "192.168.0.1",
                rows: 1,
                value: nil,
                validation: .ip4vAddress,
                errorMessages: nil,
                helperText: HelperTextData(
                    id: "hlp7",
                    text: tr(
                        "Enter a valid IPv4 address",
                        de: "Gib eine gültige IPv4-Adresse ein",
                        fr: "Saisissez une adresse IPv4 valide",
                        es: "Introduce una dirección IPv4 válida",
                        it: "Inserisci un indirizzo IPv4 valido"
                    )
                ),
                isMonospaced: true
            )
        ),
        #previewVariant(
            tr(
                "Custom Pattern Validation (8 Rows)",
                [
                    "de": "Benutzerdefiniertes Muster (8 Zeilen)",
                    "fr": "Motif personnalisé (8 lignes)",
                    "es": "Patrón personalizado (8 filas)",
                    "it": "Pattern personalizzato (8 righe)",
                    "pt": "Padrão personalizado (8 linhas)",
                    "nl": "Aangepast patroon (8 regels)",
                    "da": "Brugerdefineret mønster (8 rækker)",
                    "sv": "Anpassat mönster (8 rader)",
                    "nb": "Egendefinert mønster (8 rader)",
                    "fi": "Mukautettu kuvio (8 riviä)",
                    "is": "Sérsniðið mynstur (8 línur)",
                    "el": "Προσαρμοσμένο μοτίβο (8 γραμμές)",
                    "tr": "Özel kalıp doğrulaması (8 satır)",
                    "hu": "Egyéni minta érvényesítése (8 sor)",
                    "hr": "Prilagođeni uzorak (8 redaka)",
                    "pl": "Wzorzec niestandardowy (8 wierszy)",
                    "sk": "Vlastný vzor (8 riadkov)",
                    "cs": "Vlastní vzor (8 řádků)",
                    "lb": "Personaliséiert Muster (8 Zeilen)",
                ]
            ),
            TextAreaFieldData(
                id: "tf-8",
                label: LabelData(
                    id: "tf-8",
                    title: tr(
                        "Custom Pattern",
                        de: "Benutzerdefiniertes Muster",
                        fr: "Motif personnalisé",
                        es: "Patrón personalizado",
                        it: "Modello personalizzato"
                    ),
                    isRequired: false
                ),
                placeholder: "ABC-1234",
                rows: 8,
                value: nil,
                validation: .custom(
                    pattern: "^[A-Z]{3}-\\d{4}$",
                    message: tr(
                        "Must match pattern ABC-1234",
                        de: "Muss dem Muster ABC-1234 entsprechen",
                        fr: "Doit correspondre au motif ABC-1234",
                        es: "Debe coincidir con el patrón ABC-1234",
                        it: "Deve corrispondere al modello ABC-1234"
                    )
                ),
                errorMessages: nil,
                helperText: HelperTextData(
                    id: "hlp8",
                    text: tr(
                        "Format: ABC-1234",
                        de: "Format: ABC-1234",
                        fr: "Format : ABC-1234",
                        es: "Formato: ABC-1234",
                        it: "Formato: ABC-1234"
                    )
                ),
                isMonospaced: false
            )
        ),
    ]

    func makeHtml(ctx: TextAreaFieldData) -> String {
        let html = renderFragments(TextAreaField(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("TextAreaField")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { TextAreaField(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
