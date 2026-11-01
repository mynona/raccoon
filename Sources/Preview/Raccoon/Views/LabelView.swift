import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct LabelView: TemplateRepresentable {

    let variants: [PreviewVariant<LabelData>] = [
        #previewVariant(
            tr(
                "Required Field",
                [
                    "de": "Erforderliches Feld",
                    "fr": "Champ obligatoire",
                    "es": "Campo obligatorio",
                    "it": "Campo obbligatorio",
                    "pt": "Campo obrigatório",
                    "nl": "Verplicht veld",
                    "da": "Påkrævet felt",
                    "sv": "Obligatoriskt fält",
                    "nb": "Obligatorisk felt",
                    "fi": "Pakollinen kenttä",
                    "is": "Áskilinn reitur",
                    "el": "Υποχρεωτικό πεδίο",
                    "tr": "Zorunlu alan",
                    "hu": "Kötelező mező",
                    "hr": "Obavezno polje",
                    "pl": "Pole wymagane",
                    "sk": "Povinné pole",
                    "cs": "Povinné pole",
                    "lb": "Erfuerderlecht Feld",
                ]
            ),
            LabelData(
                id: "field-1",
                title: tr(
                    "Full name",
                    de: "Vollständiger Name",
                    fr: "Nom complet",
                    es: "Nombre completo",
                    it: "Nome completo"
                ),
                isRequired: true
            )
        ),
        #previewVariant(
            tr(
                "Optional Right-Aligned",
                [
                    "de": "Optional rechtsbündig",
                    "fr": "Optionnel aligné à droite",
                    "es": "Opcional alineado a la derecha",
                    "it": "Opzionale allineato a destra",
                    "pt": "Opcional alinhado à direita",
                    "nl": "Optioneel rechts uitgelijnd",
                    "da": "Valgfrit højrejusteret",
                    "sv": "Valfritt högerjusterat",
                    "nb": "Valgfritt høyrejustert",
                    "fi": "Valinnainen oikealle tasattu",
                    "is": "Valfrjálst hægrijafnað",
                    "el": "Προαιρετικό στοιχισμένο δεξιά",
                    "tr": "Sağa hizalı isteğe bağlı",
                    "hu": "Opcionális jobbra zárt",
                    "hr": "Opcionalno desno poravnato",
                    "pl": "Opcjonalne wyrównane do prawej",
                    "sk": "Voliteľné zarovnané doprava",
                    "cs": "Volitelné zarovnané doprava",
                    "lb": "Fakultativ rietsbünnegt",
                ]
            ),
            LabelData(
                id: "field-2",
                title: tr(
                    "Middle name",
                    de: "Zweiter Vorname",
                    fr: "Deuxième prénom",
                    es: "Segundo nombre",
                    it: "Secondo nome"
                ),
                position: .right,
                isRequired: false
            )
        ),
        #previewVariant(
            tr(
                "Extra Large Left-Aligned",
                [
                    "de": "Extra groß linksbündig",
                    "fr": "Très grand aligné à gauche",
                    "es": "Extragrande alineado a la izquierda",
                    "it": "Extra large allineato a sinistra",
                    "pt": "Extra grande alinhado à esquerda",
                    "nl": "Extra groot links uitgelijnd",
                    "da": "Ekstra stor venstrejusteret",
                    "sv": "Extra stor vänsterjusterad",
                    "nb": "Ekstra stor venstrejustert",
                    "fi": "Erittäin suuri vasemmalle tasattu",
                    "is": "Mjög stórt vinstrijafnað",
                    "el": "Πολύ μεγάλο στοιχισμένο αριστερά",
                    "tr": "Sola hizalı ekstra büyük",
                    "hu": "Extra nagy balra zárt",
                    "hr": "Vrlo veliko lijevo poravnato",
                    "pl": "Bardzo duże wyrównane do lewej",
                    "sk": "Extra veľké zarovnané doľava",
                    "cs": "Extra velké zarovnané doleva",
                    "lb": "Extra grouss lénksbünnegt",
                ]
            ),
            LabelData(
                id: "field-3",
                title: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                position: .left,
                size: .xl,
                isRequired: true,
                xhtml: "'xhtml-test'"
            )
        ),
        #previewVariant(
            tr(
                "Localized Required Email",
                [
                    "de": "Lokalisierte erforderliche E-Mail",
                    "fr": "E-mail obligatoire localisé",
                    "es": "Correo obligatorio localizado",
                    "it": "E-mail obbligatoria localizzata",
                    "pt": "E-mail obrigatório localizado",
                    "nl": "Gelokaliseerde verplichte e-mail",
                    "da": "Lokaliseret påkrævet e-mail",
                    "sv": "Lokaliserad obligatorisk e-post",
                    "nb": "Lokalisert obligatorisk e-post",
                    "fi": "Lokalisoitu pakollinen sähköposti",
                    "is": "Staðfært áskilið netfang",
                    "el": "Τοπικοποιημένο απαιτούμενο email",
                    "tr": "Yerelleştirilmiş zorunlu e-posta",
                    "hu": "Honosított kötelező e-mail",
                    "hr": "Lokalizirana obavezna e-pošta",
                    "pl": "Zlokalizowany wymagany e-mail",
                    "sk": "Lokalizovaný povinný e-mail",
                    "cs": "Lokalizovaný povinný e-mail",
                    "lb": "Lokaliséiert erfuerderlech E-Mail",
                ]
            ),
            LabelData(
                id: "field-4",
                title: tr(
                    "Email address",
                    de: "E-Mail-Adresse",
                    fr: "Adresse e-mail",
                    es: "Dirección de correo electrónico",
                    it: "Indirizzo e-mail"
                ),
                isRequired: true
            )
        ),
    ]

    func makeHtml(ctx: LabelData) -> String {
        let html = renderFragments(Label(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Label")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { Label(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
