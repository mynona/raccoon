import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct TextareaFieldView: TemplateRepresentable {

    let variants: [PreviewVariant<TextAreaFieldData>] = [
        #previewVariant(
            """
            // .firstLastName
            """,
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
            """
            // .email
            """,
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
            """
            // .url
            """,
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
            """
            // .integer
            """,
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
            """
            // .amount
            """,
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
            """
            // .phoneNumber
            """,
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
            """
            // .ip4vAddress
            """,
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
            """
            // .custom
            """,
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
