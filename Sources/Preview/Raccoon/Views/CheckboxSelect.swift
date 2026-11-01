import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct CheckboxSelectView: TemplateRepresentable {

    let variants: [PreviewVariant<CheckboxSelectData>] = [
        #previewVariant(
            tr(
                "With Search & Select All",
                [
                    "de": "Mit Suche & Alles auswählen",
                    "fr": "Avec recherche et Tout sélectionner",
                    "es": "Con búsqueda y Seleccionar todo",
                    "it": "Con ricerca e Seleziona tutto",
                    "pt": "Com busca e Selecionar tudo",
                    "nl": "Met zoeken & Alles selecteren",
                    "da": "Med søgning og Vælg alle",
                    "sv": "Med sökning och Markera alla",
                    "nb": "Med søk og Velg alle",
                    "fi": "Haulla ja Valitse kaikki -toiminnolla",
                    "is": "Með leit og Velja allt",
                    "el": "Με αναζήτηση και Επιλογή όλων",
                    "tr": "Arama ve Tümünü Seç ile",
                    "hu": "Kereséssel és Összes kijelölésével",
                    "hr": "S pretraživanjem i Odaberi sve",
                    "pl": "Z wyszukiwaniem i Zaznacz wszystko",
                    "sk": "S vyhľadávaním a Vybrať všetko",
                    "cs": "S vyhledáváním a Vybrat vše",
                    "lb": "Mat Sich & Alles auswielen",
                ]
            ),
            CheckboxSelectData(
                id: "select-1",
                label: LabelData(
                    id: "tags",
                    title: tr(
                        "Tags",
                        de: "Tags",
                        fr: "Tags",
                        es: "Etiquetas",
                        it: "Tag"
                    )
                ),
                values: DemoData.optionList,
                helperText: HelperTextData(
                    id: "helper-1",
                    text: tr(
                        "helper text",
                        de: "Hilfetext",
                        fr: "texte d'aide",
                        es: "texto de ayuda",
                        it: "testo di aiuto"
                    )
                ),
                hasSearch: true,
                hasSelectAll: true
            )
        ),
        #previewVariant(
            tr(
                "List Only Without Search",
                [
                    "de": "Nur Liste ohne Suche",
                    "fr": "Liste seule sans recherche",
                    "es": "Solo lista sin búsqueda",
                    "it": "Solo elenco senza ricerca",
                    "pt": "Apenas lista sem busca",
                    "nl": "Alleen lijst zonder zoeken",
                    "da": "Kun liste uden søgning",
                    "sv": "Endast lista utan sökning",
                    "nb": "Kun liste uten søk",
                    "fi": "Vain luettelo ilman hakua",
                    "is": "Aðeins listi án leitar",
                    "el": "Μόνο λίστα χωρίς αναζήτηση",
                    "tr": "Aramasız yalnızca liste",
                    "hu": "Csak lista keresés nélkül",
                    "hr": "Samo popis bez pretraživanja",
                    "pl": "Tylko lista bez wyszukiwania",
                    "sk": "Iba zoznam bez vyhľadávania",
                    "cs": "Pouze seznam bez vyhledávání",
                    "lb": "Nëmme Lëscht ouni Sich",
                ]
            ),
            CheckboxSelectData(
                id: "select-2",
                label: LabelData(
                    id: "tags-2",
                    title: tr(
                        "Tags",
                        de: "Tags",
                        fr: "Tags",
                        es: "Etiquetas",
                        it: "Tag"
                    )
                ),
                values: DemoData.optionList,
                helperText: nil,
                hasSearch: false,
                hasSelectAll: false
            )
        ),
        #previewVariant(
            tr(
                "With Select All Without Search",
                [
                    "de": "Mit Alles auswählen ohne Suche",
                    "fr": "Avec Tout sélectionner sans recherche",
                    "es": "Con Seleccionar todo sin búsqueda",
                    "it": "Con Seleziona tutto senza ricerca",
                    "pt": "Com Selecionar tudo sem busca",
                    "nl": "Met Alles selecteren zonder zoeken",
                    "da": "Med Vælg alle uden søgning",
                    "sv": "Med Markera alla utan sökning",
                    "nb": "Med Velg alle uten søk",
                    "fi": "Valitse kaikki ilman hakua",
                    "is": "Með Velja allt án leitar",
                    "el": "Με Επιλογή όλων χωρίς αναζήτηση",
                    "tr": "Aramasız Tümünü Seç ile",
                    "hu": "Összes kijelölése keresés nélkül",
                    "hr": "S Odaberi sve bez pretraživanja",
                    "pl": "Z Zaznacz wszystko bez wyszukiwania",
                    "sk": "S Vybrať všetko bez vyhľadávania",
                    "cs": "S Vybrat vše bez vyhledávání",
                    "lb": "Mat Alles auswielen ouni Sich",
                ]
            ),
            CheckboxSelectData(
                id: "select-3",
                label: LabelData(
                    id: "tags-3",
                    title: tr(
                        "Tags",
                        de: "Tags",
                        fr: "Tags",
                        es: "Etiquetas",
                        it: "Tag"
                    )
                ),
                values: DemoData.optionList,
                helperText: nil,
                hasSearch: false,
                hasSelectAll: true
            )
        ),
    ]

    func makeHtml(ctx: CheckboxSelectData) -> String {
        let html = renderFragments(CheckboxSelect(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("CheckboxSelect")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { CheckboxSelect(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()
    }
}
