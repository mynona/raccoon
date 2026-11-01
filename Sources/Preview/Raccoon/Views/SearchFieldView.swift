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
                placeholder: LocalizedText(
                    en: "Find articles",
                    translations: [
                        "de": "Artikel finden", "fr": "Trouver des articles",
                    ]
                ),
                ariaLabel: LocalizedText(
                    en: "Find articles",
                    translations: [
                        "de": "Artikel finden", "fr": "Trouver des articles",
                    ]
                ),
                iconTitle: LocalizedText(
                    en: "Search icon",
                    translations: [
                        "de": "Suchsymbol", "fr": "Icône de recherche",
                    ]
                )
            )
        ),
        #previewVariant(
            """
            // Small size variant (.sm) for compact sidebars and headers
            """,
            SearchFieldData(
                placeholder: "Filter components...",
                ariaLabel: "Filter components",
                size: .sm
            )
        ),
        #previewVariant(
            """
            // Loading state (animated heart icon while querying server)
            """,
            SearchFieldData(
                placeholder: "Searching items...",
                ariaLabel: "Search",
                loadingBind: "isLoading"
            )
        ),
        #previewVariant(
            """
            // Disabled state
            """,
            SearchFieldData(
                placeholder: "Search disabled",
                ariaLabel: "Search disabled",
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
                placeholder: "Custom bindings...",
                ariaLabel: "Custom search"
            )
        ),
        #previewVariant(
            """
            // Transparent container background
            """,
            SearchFieldData(
                placeholder: "Transparent background...",
                ariaLabel: "Search",
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
