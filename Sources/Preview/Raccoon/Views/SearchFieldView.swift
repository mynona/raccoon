import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct SearchFieldView: TemplateRepresentable {

    let variants: [PreviewVariant<SearchFieldData>] = [
        #previewVariant(
            tr(
                "Default Search Field",
                [
                    "de": "Standard-Suchfeld",
                    "fr": "Champ de recherche standard",
                    "es": "Campo de búsqueda predeterminado",
                    "it": "Campo di ricerca predefinito",
                    "pt": "Campo de busca padrão",
                    "nl": "Standaard zoekveld",
                    "da": "Standard søgefelt",
                    "sv": "Standard sökfält",
                    "nb": "Standard søkefelt",
                    "fi": "Oletushakukenttä",
                    "is": "Sjálfgefinn leitarreitur",
                    "el": "Προεπιλεγμένο πεδίο αναζήτησης",
                    "tr": "Varsayılan arama alanı",
                    "hu": "Alapértelmezett keresőmező",
                    "hr": "Zadano polje za pretraživanje",
                    "pl": "Domyślne pole wyszukiwania",
                    "sk": "Predvolené pole vyhľadávania",
                    "cs": "Výchozí vyhledávací pole",
                    "lb": "Standard-Sichfeld",
                ]
            ),
            SearchFieldData()
        ),
        #previewVariant(
            tr(
                "Localized Texts with Icon Title",
                [
                    "de": "Lokalisierte Texte mit Icon-Titel",
                    "fr": "Textes localisés avec titre d'icône",
                    "es": "Textos localizados con título de icono",
                    "it": "Testi localizzati con titolo icona",
                    "pt": "Textos localizados com título do ícone",
                    "nl": "Gelokaliseerde teksten met pictogramtitel",
                    "da": "Lokaliserede tekster med ikontitel",
                    "sv": "Lokaliserade texter med ikontitel",
                    "nb": "Lokaliserte tekster med ikontittel",
                    "fi": "Lokalisoidut tekstit kuvakeotsikolla",
                    "is": "Staðfærðir textar með tákntitli",
                    "el": "Τοπικοποιημένα κείμενα με τίτλο εικονιδίου",
                    "tr": "Simge başlıklı yerelleştirilmiş metinler",
                    "hu": "Honosított szövegek ikoncímmel",
                    "hr": "Lokalizirani tekstovi s naslovom ikone",
                    "pl": "Zlokalizowane teksty z tytułem ikony",
                    "sk": "Lokalizované texty s názvom ikony",
                    "cs": "Lokalizované texty s názvem ikony",
                    "lb": "Lokaliséiert Texter mat Ikon-Titel",
                ]
            ),
            SearchFieldData(
                placeholder: tr(
                    "Find articles",
                    de: "Artikel finden",
                    fr: "Trouver des articles",
                    es: "Buscar artículos",
                    it: "Trova articoli"
                ),
                ariaLabel: tr(
                    "Find articles",
                    de: "Artikel finden",
                    fr: "Trouver des articles",
                    es: "Buscar artículos",
                    it: "Trova articoli"
                ),
                iconTitle: tr(
                    "Search icon",
                    de: "Suchsymbol",
                    fr: "Icône de recherche",
                    es: "Icono de búsqueda",
                    it: "Icona di ricerca"
                )
            )
        ),
        #previewVariant(
            tr(
                "Compact Size Variant",
                [
                    "de": "Kompakte Größenvariante",
                    "fr": "Variante de taille compacte",
                    "es": "Variante de tamaño compacto",
                    "it": "Variante di dimensioni compatte",
                    "pt": "Variante de tamanho compacto",
                    "nl": "Compacte groottevariant",
                    "da": "Kompakt størrelsesvariant",
                    "sv": "Kompakt storleksvariant",
                    "nb": "Kompakt størrelsesvariant",
                    "fi": "Kompakti kokovaihtoehto",
                    "is": "Þétt stærðarafbrigði",
                    "el": "Συμπαγής παραλλαγή μεγέθους",
                    "tr": "Kompakt boyut varyantı",
                    "hu": "Kompakt méretváltozat",
                    "hr": "Kompaktna varijanta veličine",
                    "pl": "Wariant o kompaktowym rozmiarze",
                    "sk": "Variant kompaktnej veľkosti",
                    "cs": "Varianta kompaktní velikosti",
                    "lb": "Kompakt Gréisst-Variant",
                ]
            ),
            SearchFieldData(
                placeholder: tr(
                    "Filter components...",
                    de: "Komponenten filtern …",
                    fr: "Filtrer les composants…",
                    es: "Filtrar componentes…",
                    it: "Filtra i componenti…"
                ),
                ariaLabel: tr(
                    "Filter components",
                    de: "Komponenten filtern",
                    fr: "Filtrer les composants",
                    es: "Filtrar componentes",
                    it: "Filtra i componenti"
                ),
                size: .sm
            )
        ),
        #previewVariant(
            tr(
                "Animated Loading State",
                [
                    "de": "Animierter Ladezustand",
                    "fr": "État de chargement animé",
                    "es": "Estado de carga animado",
                    "it": "Stato di caricamento animato",
                    "pt": "Estado de carregamento animado",
                    "nl": "Geanimeerde laadstatus",
                    "da": "Animeret indlæsningstilstand",
                    "sv": "Animerat laddningstillstånd",
                    "nb": "Animert lastetilstand",
                    "fi": "Animoitu lataustila",
                    "is": "Hreyfð hleðslustaða",
                    "el": "Κινούμενη κατάσταση φόρτωσης",
                    "tr": "Animasyonlu yükleme durumu",
                    "hu": "Animált betöltési állapot",
                    "hr": "Animirano stanje učitavanja",
                    "pl": "Animowany stan ładowania",
                    "sk": "Animovaný stav načítania",
                    "cs": "Animovaný stav načítání",
                    "lb": "Animéierte Luedzoustand",
                ]
            ),
            SearchFieldData(
                placeholder: tr(
                    "Searching items...",
                    de: "Elemente werden gesucht …",
                    fr: "Recherche d'éléments…",
                    es: "Buscando elementos…",
                    it: "Ricerca di elementi…"
                ),
                ariaLabel: tr(
                    "Search",
                    de: "Suchen",
                    fr: "Rechercher",
                    es: "Buscar",
                    it: "Cerca"
                ),
                loadingBind: "isLoading"
            )
        ),
        #previewVariant(
            tr(
                "Disabled State",
                [
                    "de": "Deaktivierter Zustand",
                    "fr": "État désactivé",
                    "es": "Estado deshabilitado",
                    "it": "Stato disabilitato",
                    "pt": "Estado desativado",
                    "nl": "Uitgeschakelde status",
                    "da": "Deaktiveret tilstand",
                    "sv": "Inaktiverat tillstånd",
                    "nb": "Deaktivert tilstand",
                    "fi": "Pois käytöstä -tila",
                    "is": "Óvirk staða",
                    "el": "Απενεργοποιημένη κατάσταση",
                    "tr": "Devre dışı durum",
                    "hu": "Letiltott állapot",
                    "hr": "Onemogućeno stanje",
                    "pl": "Stan wyłączony",
                    "sk": "Zakázaný stav",
                    "cs": "Zakázaný stav",
                    "lb": "Desaktivéierten Zoustand",
                ]
            ),
            SearchFieldData(
                placeholder: tr(
                    "Search disabled",
                    de: "Suche deaktiviert",
                    fr: "Recherche désactivée",
                    es: "Búsqueda deshabilitada",
                    it: "Ricerca disabilitata"
                ),
                ariaLabel: tr(
                    "Search disabled",
                    de: "Suche deaktiviert",
                    fr: "Recherche désactivée",
                    es: "Búsqueda deshabilitada",
                    it: "Ricerca disabilitata"
                ),
                state: .disabled
            )
        ),
        #previewVariant(
            tr(
                "Custom Alpine Model Bindings",
                [
                    "de": "Benutzerdefinierte Alpine-Model-Bindings",
                    "fr": "Liaisons de modèle Alpine personnalisées",
                    "es": "Enlaces de modelo Alpine personalizados",
                    "it": "Binding modello Alpine personalizzati",
                    "pt": "Ligações de modelo Alpine personalizadas",
                    "nl": "Aangepaste Alpine model-bindings",
                    "da": "Brugerdefinerede Alpine-modelbindinger",
                    "sv": "Anpassade Alpine-modellbindningar",
                    "nb": "Egendefinerte Alpine-modellbindinger",
                    "fi": "Mukautetut Alpine-mallisidonnat",
                    "is": "Sérsniðnar Alpine-módelbindingar",
                    "el": "Προσαρμοσμένες συνδέσεις μοντέλου Alpine",
                    "tr": "Özel Alpine model bağlamaları",
                    "hu": "Egyéni Alpine modellkötések",
                    "hr": "Prilagođena vezivanja Alpine modela",
                    "pl": "Niestandardowe powiązania modelu Alpine",
                    "sk": "Vlastné väzby modelu Alpine",
                    "cs": "Vlastní vazby modelu Alpine",
                    "lb": "Personaliséiert Alpine-Model-Bindings",
                ]
            ),
            SearchFieldData(
                name: "customSearchInput",
                bindModel: "customQuery",
                bindRef: "customInputRef",
                placeholder: tr(
                    "Custom bindings...",
                    de: "Eigene Bindings …",
                    fr: "Liaisons personnalisées…",
                    es: "Enlaces personalizados…",
                    it: "Binding personalizzati…"
                ),
                ariaLabel: tr(
                    "Custom search",
                    de: "Eigene Suche",
                    fr: "Recherche personnalisée",
                    es: "Búsqueda personalizada",
                    it: "Ricerca personalizzata"
                )
            )
        ),
        #previewVariant(
            tr(
                "Transparent Container Background",
                [
                    "de": "Transparenter Container-Hintergrund",
                    "fr": "Arrière-plan de conteneur transparent",
                    "es": "Fondo de contenedor transparente",
                    "it": "Sfondo contenitore trasparente",
                    "pt": "Fundo de contêiner transparente",
                    "nl": "Transparante containerachtergrond",
                    "da": "Gennemsigtig beholderbaggrund",
                    "sv": "Genomskinlig behållarbakgrund",
                    "nb": "Gjennomsiktig beholderbakgrunn",
                    "fi": "Läpinäkyvä säiliön tausta",
                    "is": "Gegnsær bakgrunnur íláts",
                    "el": "Διαφανές φόντο πλαισίου",
                    "tr": "Şeffaf kapsayıcı arka planı",
                    "hu": "Átlátszó tárolóháttér",
                    "hr": "Prozirna pozadina spremnika",
                    "pl": "Przezroczyste tło kontenera",
                    "sk": "Priehľadné pozadie kontajnera",
                    "cs": "Průhledné pozadí kontejneru",
                    "lb": "Transparenten Hannergrond vum Container",
                ]
            ),
            SearchFieldData(
                placeholder: tr(
                    "Transparent background...",
                    de: "Transparenter Hintergrund …",
                    fr: "Arrière-plan transparent…",
                    es: "Fondo transparente…",
                    it: "Sfondo trasparente…"
                ),
                ariaLabel: tr(
                    "Search",
                    de: "Suchen",
                    fr: "Rechercher",
                    es: "Buscar",
                    it: "Cerca"
                ),
                hasTransparentBackground: true
            )
        ),
    ]

    func makeHtml(ctx: SearchFieldData) -> String {
        let html = renderFragments(SearchField(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic(title: "SearchField") {

            Div {

                showComponentTitle("SearchField")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div {
                            SearchField(variant.data).render()
                        }
                        .setAttribute(
                            name: "x-data",
                            value:
                                "{ search: '', customQuery: '', isLoading: true }"
                        )
                        .class("mb-4 mt-6 max-w-xl")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
