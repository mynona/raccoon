import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct ThemeSwitcherView: TemplateRepresentable {

    let variants: [PreviewVariant<ThemeSwitcherData>] = [
        #previewVariant(
            tr(
                "Default Theme Switcher",
                [
                    "de": "Standard-Theme-Umschalter",
                    "fr": "Sélecteur de thème standard",
                    "es": "Selector de tema predeterminado",
                    "it": "Selettore tema predefinito",
                    "pt": "Seletor de tema padrão",
                    "nl": "Standaard themaschakelaar",
                    "da": "Standard temaskifter",
                    "sv": "Standard temaväxlare",
                    "nb": "Standard temaveksler",
                    "fi": "Vakioteemanvaihtaja",
                    "is": "Sjálfgefinn þemaskiptir",
                    "el": "Προεπιλεγμένος εναλλάκτης θέματος",
                    "tr": "Varsayılan tema değiştirici",
                    "hu": "Alapértelmezett témaváltó",
                    "hr": "Zadani prebacivač tema",
                    "pl": "Domyślny przełącznik motywu",
                    "sk": "Predvolený prepínač motívu",
                    "cs": "Výchozí přepínač motivu",
                    "lb": "Standard Theme-Ëmschalter",
                ]
            ),
            ThemeSwitcherData()
        ),
        #previewVariant(
            tr(
                "Theme Switcher with Matomo",
                [
                    "de": "Theme-Umschalter mit Matomo",
                    "fr": "Sélecteur de thème avec Matomo",
                    "es": "Selector de tema con Matomo",
                    "it": "Selettore tema con Matomo",
                    "pt": "Seletor de tema com Matomo",
                    "nl": "Themaschakelaar met Matomo",
                    "da": "Temaskifter med Matomo",
                    "sv": "Temaväxlare med Matomo",
                    "nb": "Temaveksler med Matomo",
                    "fi": "Teemanvaihtaja Matomolla",
                    "is": "Þemaskiptir með Matomo",
                    "el": "Εναλλάκτης θέματος με Matomo",
                    "tr": "Matomo ile tema değiştirici",
                    "hu": "Témaváltó Matomóval",
                    "hr": "Prebacivač tema s Matomom",
                    "pl": "Przełącznik motywu z Matomo",
                    "sk": "Prepínač motívu s Matomom",
                    "cs": "Přepínač motivu s Matomem",
                    "lb": "Theme-Ëmschalter mat Matomo",
                ]
            ),
            ThemeSwitcherData(
                id: "themeSwitcher",
                matomoStatus: .ACCEPTED
            )
        ),
        #previewVariant(
            tr(
                "Custom Theme Options Subset",
                [
                    "de": "Teilmenge benutzerdefinierter Theme-Optionen",
                    "fr": "Sous-ensemble d'options de thème personnalisées",
                    "es": "Subconjunto de opciones de tema personalizadas",
                    "it": "Sottoinsieme di opzioni tema personalizzate",
                    "pt": "Subconjunto de opções de tema personalizadas",
                    "nl": "Deelverzameling aangepaste thema-opties",
                    "da": "Delmængde af brugerdefinerede temaindstillinger",
                    "sv": "Delmängd av anpassade temainställningar",
                    "nb": "Delmengde av egendefinerte temavalg",
                    "fi": "Mukautettujen teemavaihtoehtojen osajoukko",
                    "is": "Hlutmengi sérsniðinna þemavalkosta",
                    "el": "Υποσύνολο προσαρμοσμένων επιλογών θέματος",
                    "tr": "Özel tema seçenekleri alt kümesi",
                    "hu": "Egyéni témalehetőségek részhalmaza",
                    "hr": "Podskup prilagođenih opcija tema",
                    "pl": "Podzbiór niestandardowych opcji motywu",
                    "sk": "Podmnožina vlastných možností motívu",
                    "cs": "Podmnožina vlastních možností motivu",
                    "lb": "Ënnermeng vu personaliséierten Theme-Optiounen",
                ]
            ),
            ThemeSwitcherData(
                defaultTheme: .blackAndWhite,
                themes: [.blackAndWhite, .emeraldMine]
            )
        ),
    ]

    func makeHtml(ctx: ThemeSwitcherData) -> String {
        let html = renderFragments(ThemeSwitcher(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Theme Switcher")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { ThemeSwitcher(variant.data).render() }
                            .class("mb-28 mt-4")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
