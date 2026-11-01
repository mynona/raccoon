import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct KbdView: TemplateRepresentable {

    let variants: [PreviewVariant<KeyboardKeyData>] = [
        #previewVariant(
            tr(
                "Shift Key",
                [
                    "de": "Umschalttaste",
                    "fr": "Touche Maj",
                    "es": "Tecla Shift",
                    "it": "Tasto Maiusc",
                    "pt": "Tecla Shift",
                    "nl": "Shift-toets",
                    "da": "Shift-tast",
                    "sv": "Skifttangent",
                    "nb": "Shift-tast",
                    "fi": "Vaihtonäppäin",
                    "is": "Shift-lykill",
                    "el": "Πλήκτρο Shift",
                    "tr": "Shift tuşu",
                    "hu": "Shift billentyű",
                    "hr": "Tipka Shift",
                    "pl": "Klawisz Shift",
                    "sk": "Kláves Shift",
                    "cs": "Klávesa Shift",
                    "lb": "Ëmschalt-Tast",
                ]
            ),
            KeyboardKeyData(key: .shift)
        ),
        #previewVariant(
            tr(
                "Command Key",
                [
                    "de": "Befehlstaste (Cmd)",
                    "fr": "Touche Commande",
                    "es": "Tecla Comando",
                    "it": "Tasto Comando",
                    "pt": "Tecla Command",
                    "nl": "Command-toets",
                    "da": "Kommando-tast",
                    "sv": "Kommando-tangent",
                    "nb": "Kommando-tast",
                    "fi": "Komentonäppäin",
                    "is": "Command-lykill",
                    "el": "Πλήκτρο Command",
                    "tr": "Komut tuşu",
                    "hu": "Command billentyű",
                    "hr": "Tipka Command",
                    "pl": "Klawisz Command",
                    "sk": "Kláves Command",
                    "cs": "Klávesa Command",
                    "lb": "Befehlstast (Cmd)",
                ]
            ),
            KeyboardKeyData(key: .command)
        ),
        #previewVariant(
            tr(
                "Control Key",
                [
                    "de": "Steuerungstaste (Strg)",
                    "fr": "Touche Contrôle",
                    "es": "Tecla Control",
                    "it": "Tasto Controllo",
                    "pt": "Tecla Control",
                    "nl": "Control-toets",
                    "da": "Control-tast",
                    "sv": "Kontrolltangent",
                    "nb": "Ctrl-tast",
                    "fi": "Ohjausnäppäin",
                    "is": "Control-lykill",
                    "el": "Πλήκτρο Control",
                    "tr": "Kontrol tuşu",
                    "hu": "Control billentyű",
                    "hr": "Tipka Control",
                    "pl": "Klawisz Control",
                    "sk": "Kláves Control",
                    "cs": "Klávesa Control",
                    "lb": "Steierungstast (Ctrl)",
                ]
            ),
            KeyboardKeyData(key: .ctrl)
        ),
        #previewVariant(
            tr(
                "Single Letter Key",
                [
                    "de": "Einzelner Buchstabentaste",
                    "fr": "Touche à lettre unique",
                    "es": "Tecla de una sola letra",
                    "it": "Tasto singola lettera",
                    "pt": "Tecla de letra única",
                    "nl": "Enkele lettertoets",
                    "da": "Enkelt bogstavtast",
                    "sv": "Enstaka bokstavstangent",
                    "nb": "Enkeltbokstavtast",
                    "fi": "Yksittäinen kirjainnäppäin",
                    "is": "Eins stafs lykill",
                    "el": "Πλήκτρο ενός γράμματος",
                    "tr": "Tek harf tuşu",
                    "hu": "Egybetűs billentyű",
                    "hr": "Tipka jednog slova",
                    "pl": "Klawisz pojedynczej litery",
                    "sk": "Kláves jedného písmena",
                    "cs": "Klávesa jednoho písmene",
                    "lb": "Eenzel Buschtawentast",
                ]
            ),
            KeyboardKeyData(key: .text("K"))
        ),
        #previewVariant(
            tr(
                "Named Text Key",
                [
                    "de": "Benannte Texttaste",
                    "fr": "Touche texte nommée",
                    "es": "Tecla de texto con nombre",
                    "it": "Tasto di testo con nome",
                    "pt": "Tecla de texto nomeada",
                    "nl": "Benoemde teksttoets",
                    "da": "Navngiven teksttast",
                    "sv": "Namngiven texttangent",
                    "nb": "Navngitt teksttast",
                    "fi": "Nimetty tekstinäppäin",
                    "is": "Nafngreindur textalykill",
                    "el": "Πλήκτρο ονοματισμένου κειμένου",
                    "tr": "Adlandırılmış metin tuşu",
                    "hu": "Megnevezett szöveges billentyű",
                    "hr": "Imenovana tekstualna tipka",
                    "pl": "Nazwany klawisz tekstowy",
                    "sk": "Pomenovaný textový kláves",
                    "cs": "Pojmenovaná textová klávesa",
                    "lb": "Benannte Texttast",
                ]
            ),
            KeyboardKeyData(key: .text("esc"))
        ),
    ]

    func makeHtml(ctx: KeyboardKeyData) -> String {
        let html = renderFragments(KeyboardKey(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Kbd")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { KeyboardKey(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
