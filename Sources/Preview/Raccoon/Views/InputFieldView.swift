import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct InputFieldView: TemplateRepresentable {

    let variants: [PreviewVariant<InputFieldData>] = [
        #previewVariant(

            "// First & Last Name validation",
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
            "// Email validation",
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
            "// URL validation",
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
            "// Integer validation",
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
            "// Amount validation",
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
            "// Phone number validation",
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
            "// IPv4 Address validation",
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
            "// Friendly URL validation",
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
            "// Custom validation: must be 'abc123'",
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
