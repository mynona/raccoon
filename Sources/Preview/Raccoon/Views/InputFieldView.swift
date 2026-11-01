import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct InputFieldView: TemplateRepresentable {

    let variants: [PreviewVariant<InputFieldData>] = [
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
            InputFieldData(
                id: "fullname",
                label: LabelData(
                    id: "fullname",
                    title: tr(
                        "Full Name",
                        de: "Vollständiger Name",
                        fr: "Nom complet",
                        es: "Nombre completo",
                        it: "Nome completo"
                    )
                ),
                placeholder: "Jane Doe",
                value: "John Doe",
                helperText: HelperTextData(
                    id: "hlp",
                    text: tr(
                        "Please enter your full name",
                        de: "Bitte gib deinen vollständigen Namen ein",
                        fr: "Veuillez saisir votre nom complet",
                        es: "Introduce tu nombre completo",
                        it: "Inserisci il tuo nome completo"
                    )
                ),
                validation: .firstLastName,
                type: .text
            )
        ),
        #previewVariant(
            tr(
                "Email Validation",
                [
                    "de": "E-Mail-Validierung",
                    "fr": "Validation d'e-mail",
                    "es": "Validación de correo electrónico",
                    "it": "Validazione e-mail",
                    "pt": "Validação de e-mail",
                    "nl": "E-mailvalidatie",
                    "da": "E-mailvalidering",
                    "sv": "E-postvalidering",
                    "nb": "E-postvalidering",
                    "fi": "Sähköpostin vahvistus",
                    "is": "Sannprófun netfangs",
                    "el": "Επαλήθευση email",
                    "tr": "E-posta doğrulaması",
                    "hu": "E-mail érvényesítése",
                    "hr": "Provjera e-pošte",
                    "pl": "Walidacja adresu e-mail",
                    "sk": "Overenie e-mailu",
                    "cs": "Ověření e-mailu",
                    "lb": "E-Mail-Validéierung",
                ]
            ),
            InputFieldData(
                id: "email",
                label: LabelData(
                    id: "email",
                    title: tr(
                        "Email",
                        de: "E-Mail",
                        fr: "E-mail",
                        es: "Correo electrónico",
                        it: "E-mail"
                    )
                ),
                placeholder: "jane@example.com",
                validation: .email,
                type: .email
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
            InputFieldData(
                id: "website",
                label: LabelData(
                    id: "website",
                    title: tr(
                        "Website",
                        de: "Website",
                        fr: "Site web",
                        es: "Sitio web",
                        it: "Sito web"
                    )
                ),
                placeholder: "https://example.com",
                validation: .url,
                type: .url
            )
        ),
        #previewVariant(
            tr(
                "Integer Validation",
                [
                    "de": "Ganzzahl-Validierung",
                    "fr": "Validation d'entier",
                    "es": "Validación de entero",
                    "it": "Validazione numero intero",
                    "pt": "Validação de número inteiro",
                    "nl": "Geheel getal-validatie",
                    "da": "Heltalsvalidering",
                    "sv": "Heltalsvalidering",
                    "nb": "Heltallsvalidering",
                    "fi": "Kokonaisluvun vahvistus",
                    "is": "Sannprófun heiltölu",
                    "el": "Επαλήθευση ακέραιου αριθμού",
                    "tr": "Tam sayı doğrulaması",
                    "hu": "Egész szám érvényesítése",
                    "hr": "Provjera cijelog broja",
                    "pl": "Walidacja liczby całkowitej",
                    "sk": "Overenie celého čísla",
                    "cs": "Ověření celého čísla",
                    "lb": "Ganzzuel-Validéierung",
                ]
            ),
            InputFieldData(
                id: "age",
                label: LabelData(
                    id: "age",
                    title: tr(
                        "Age",
                        de: "Alter",
                        fr: "Âge",
                        es: "Edad",
                        it: "Età"
                    )
                ),
                placeholder: "18",
                validation: .integer,
                type: .number
            )
        ),
        #previewVariant(
            tr(
                "Amount Validation",
                [
                    "de": "Betrags-Validierung",
                    "fr": "Validation de montant",
                    "es": "Validación de importe",
                    "it": "Validazione importo",
                    "pt": "Validação de valor",
                    "nl": "Bedragvalidatie",
                    "da": "Beløbsvalidering",
                    "sv": "Beloppsvalidering",
                    "nb": "Beløpsvalidering",
                    "fi": "Määrän vahvistus",
                    "is": "Sannprófun upphæðar",
                    "el": "Επαλήθευση ποσού",
                    "tr": "Tutar doğrulaması",
                    "hu": "Összeg érvényesítése",
                    "hr": "Provjera iznosa",
                    "pl": "Walidacja kwoty",
                    "sk": "Overenie sumy",
                    "cs": "Ověření částky",
                    "lb": "Betrags-Validéierung",
                ]
            ),
            InputFieldData(
                id: "amount",
                label: LabelData(
                    id: "amount",
                    title: tr(
                        "Amount",
                        de: "Betrag",
                        fr: "Montant",
                        es: "Importe",
                        it: "Importo"
                    )
                ),
                placeholder: "12.34",
                validation: .amount,
                type: .text
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
            InputFieldData(
                id: "phone",
                label: LabelData(
                    id: "phone",
                    title: tr(
                        "Phone Number",
                        de: "Telefonnummer",
                        fr: "Numéro de téléphone",
                        es: "Número de teléfono",
                        it: "Numero di telefono"
                    )
                ),
                placeholder: "+491234567890",
                validation: .phoneNumber,
                type: .tel
            )
        ),

        #previewVariant(
            tr(
                "IPv4 Address Validation",
                [
                    "de": "IPv4-Adressen-Validierung",
                    "fr": "Validation d'adresse IPv4",
                    "es": "Validación de dirección IPv4",
                    "it": "Validazione indirizzo IPv4",
                    "pt": "Validação de endereço IPv4",
                    "nl": "IPv4-adresvalidatie",
                    "da": "IPv4-adressevalidering",
                    "sv": "IPv4-adressvalidering",
                    "nb": "IPv4-adressevalidering",
                    "fi": "IPv4-osoitteen vahvistus",
                    "is": "Sannprófun IPv4-vistfangs",
                    "el": "Επαλήθευση διεύθυνσης IPv4",
                    "tr": "IPv4 adresi doğrulaması",
                    "hu": "IPv4-cím érvényesítése",
                    "hr": "Provjera IPv4 adrese",
                    "pl": "Walidacja adresu IPv4",
                    "sk": "Overenie adresy IPv4",
                    "cs": "Ověření adresy IPv4",
                    "lb": "IPv4-Adress-Validéierung",
                ]
            ),
            InputFieldData(
                id: "ip",
                label: LabelData(
                    id: "ip",
                    title: tr(
                        "IPv4 Address",
                        de: "IPv4-Adresse",
                        fr: "Adresse IPv4",
                        es: "Dirección IPv4",
                        it: "Indirizzo IPv4"
                    )
                ),
                placeholder: "192.168.0.1",
                validation: .ip4vAddress,
                type: .text
            )
        ),
        #previewVariant(
            tr(
                "Friendly URL Slug Validation",
                [
                    "de": "Slug-Validierung für lesbare URLs",
                    "fr": "Validation de slug d'URL conviviale",
                    "es": "Validación de slug de URL amigable",
                    "it": "Validazione slug URL descrittivo",
                    "pt": "Validação de slug de URL amigável",
                    "nl": "Leesbare URL-slugvalidatie",
                    "da": "Validering af brugervenlig URL-slug",
                    "sv": "Validering av användarvänlig URL-slug",
                    "nb": "Validering av brukervennlig URL-slug",
                    "fi": "Käyttäjäystävällisen URL-tunnisteen vahvistus",
                    "is": "Sannprófun vinalegrar vefslóðar",
                    "el": "Επαλήθευση φιλικού slug διεύθυνσης URL",
                    "tr": "Kullanıcı dostu URL slug doğrulaması",
                    "hu": "Keresőbarát URL-azonosító érvényesítése",
                    "hr": "Provjera prilagođenog URL sluga",
                    "pl": "Walidacja przyjaznego sluga URL",
                    "sk": "Overenie prehľadného URL slugu",
                    "cs": "Ověření čitelného URL slugu",
                    "lb": "Frëndlech URL-Slug-Validéierung",
                ]
            ),
            InputFieldData(
                id: "slug",
                label: LabelData(
                    id: "slug",
                    title: tr(
                        "Slug",
                        de: "Slug",
                        fr: "Slug",
                        es: "Slug",
                        it: "Slug"
                    )
                ),
                placeholder: "my-article",
                validation: .friendlyUrl,
                type: .text
            )
        ),
        #previewVariant(
            tr(
                "Custom Regex Pattern Validation",
                [
                    "de": "Benutzerdefinierte Regex-Muster-Validierung",
                    "fr": "Validation par motif regex personnalisé",
                    "es": "Validación de patrón regex personalizado",
                    "it": "Validazione pattern regex personalizzato",
                    "pt": "Validação de padrão regex personalizado",
                    "nl": "Validatie via aangepast regex-patroon",
                    "da": "Brugerdefineret regex-mønstervalidering",
                    "sv": "Anpassad regex-mönsterinmatning",
                    "nb": "Egendefinert regex-mønstervalidering",
                    "fi": "Mukautetun säännöllisen lausekkeen vahvistus",
                    "is": "Sérsniðin regex-mynstursannprófun",
                    "el": "Επαλήθευση προσαρμοσμένου μοτίβου regex",
                    "tr": "Özel normal ifade kalıbı doğrulaması",
                    "hu": "Egyéni reguláris kifejezés minta érvényesítése",
                    "hr": "Provjera prilagođenog regex uzorka",
                    "pl": "Niestandardowa walidacja wzorca wyrażenia regularnego",
                    "sk": "Vlastné overenie vzorom regulárneho výrazu",
                    "cs": "Vlastní ověření vzorem regulárního výrazu",
                    "lb": "Personaliséiert Regex-Muster-Validéierung",
                ]
            ),
            InputFieldData(
                id: "custom",
                label: LabelData(
                    id: "custom",
                    title: tr(
                        "Custom Field",
                        de: "Benutzerdefiniertes Feld",
                        fr: "Champ personnalisé",
                        es: "Campo personalizado",
                        it: "Campo personalizzato"
                    )
                ),
                placeholder: "ABC-1234",
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
                type: .text
            )
        ),
    ]

    func makeHtml(ctx: InputFieldData) -> String {
        let html = renderFragments(InputField(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("InputField")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { InputField(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
