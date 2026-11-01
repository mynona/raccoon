import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct SearchFieldView: TemplateRepresentable {

    let variants: [PreviewVariant<SearchFieldData>] = [
        #previewVariant(
            """
            // Default search field
            """,
            SearchFieldData()
        ),
        #previewVariant(
            """
            // Own texts with translations (en, de, fr)
            """,
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
            """
            // Small size variant (.sm) for compact sidebars and headers
            """,
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
            """
            // Loading state (animated heart icon while querying server)
            """,
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
            """
            // Disabled state
            """,
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
            """
            // Custom Alpine bindings and clear actions
            """,
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
            """
            // Transparent container background
            """,
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
