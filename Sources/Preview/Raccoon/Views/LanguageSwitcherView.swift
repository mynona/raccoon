import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct LanguageSwitcherView: TemplateRepresentable {

    let variants: [PreviewVariant<LanguageSwitcherData>] = [
        #previewVariant(
            tr(
                "Two Languages (English & German)",
                [
                    "de": "Zwei Sprachen (Englisch & Deutsch)",
                    "fr": "Deux langues (Anglais et Allemand)",
                    "es": "Dos idiomas (Inglés y Alemán)",
                    "it": "Due lingue (Inglese e Tedesco)",
                    "pt": "Dois idiomas (Inglês e Alemão)",
                    "nl": "Twee talen (Engels & Duits)",
                    "da": "To sprog (Engelsk og Tysk)",
                    "sv": "Två språk (Engelska och Tyska)",
                    "nb": "To språk (Engelsk og Tysk)",
                    "fi": "Kaksi kieltä (Englanti ja Saksa)",
                    "is": "Tvö tungumál (Enska og Þýska)",
                    "el": "Δύο γλώσσες (Αγγλικά και Γερμανικά)",
                    "tr": "İki dil (İngilizce ve Almanca)",
                    "hu": "Két nyelv (Angol és Német)",
                    "hr": "Dva jezika (Engleski i Njemački)",
                    "pl": "Dwa języki (Angielski i Niemiecki)",
                    "sk": "Dva jazyky (Angličtina a Nemčina)",
                    "cs": "Dva jazyky (Angličtina a Němčina)",
                    "lb": "Zou Sproochen (Englesch & Däitsch)",
                ]
            ),
            LanguageSwitcherData(
                languages: [
                    LanguageOption(code: "en", name: "English"),
                    LanguageOption(code: "de", name: "Deutsch"),
                ]
            )
        ),
        #previewVariant(
            tr(
                "Four Languages with German Fallback",
                [
                    "de": "Vier Sprachen mit deutschem Fallback",
                    "fr": "Quatre langues avec repli allemand",
                    "es": "Cuatro idiomas con respaldo alemán",
                    "it": "Quattro lingue con fallback tedesco",
                    "pt": "Quatro idiomas com alternativa em alemão",
                    "nl": "Vier talen met Duitse terugval",
                    "da": "Fire sprog med tysk fallback",
                    "sv": "Fyra språk med tysk reserv",
                    "nb": "Fire språk med tysk reserveløsning",
                    "fi": "Neljä kieltä saksalaisella varavaihtoehdolla",
                    "is": "Fjögur tungumál með þýsku sem varakost",
                    "el": "Τέσσερις γλώσσες με γερμανική εφεδρεία",
                    "tr": "Almanca yedekli dört dil",
                    "hu": "Négy nyelv német tartalékkal",
                    "hr": "Četiri jezika s njemačkom zamjenom",
                    "pl": "Cztery języki z niemiecką alternatywą",
                    "sk": "Štyri jazyky s nemeckou zálohou",
                    "cs": "Čtyři jazyky s německou zálohou",
                    "lb": "Véier Sprooche mat däitschem Fallback",
                ]
            ),
            LanguageSwitcherData(
                id: "language-switcher-2",
                languages: [
                    LanguageOption(code: "de", name: "Deutsch"),
                    LanguageOption(code: "fr", name: "Français"),
                    LanguageOption(code: "es", name: "Español"),
                    LanguageOption(code: "it", name: "Italiano"),
                ],
                fallbackLanguage: "de"
            )
        ),
    ]

    func makeHtml(ctx: LanguageSwitcherData) -> String {
        let html = renderFragments(LanguageSwitcher(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Language Switcher")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { LanguageSwitcher(variant.data).render() }
                            .class("mb-28 mt-4 flex justify-end")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
