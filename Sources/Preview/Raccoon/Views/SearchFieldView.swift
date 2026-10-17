import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct SearchFieldView: TemplateRepresentable {

    let variants: [(String, SearchFieldData)] = [
        (
            """
            // Default search field
            """,
            SearchFieldData()
        ),
        (
            """
            // Small size variant (.sm) for compact sidebars and headers
            """,
            SearchFieldData(
                placeholder: "Filter components...",
                ariaLabel: "Filter components",
                size: .sm
            )
        ),
        (
            """
            // Loading state (animated heart icon while querying server)
            """,
            SearchFieldData(
                placeholder: "Searching items...",
                ariaLabel: "Search",
                loadingBind: "isLoading"
            )
        ),
        (
            """
            // Disabled state
            """,
            SearchFieldData(
                placeholder: "Search disabled",
                ariaLabel: "Search disabled",
                state: .disabled
            )
        ),
        (
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
        (
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

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div {
                            SearchField(ctx).render()
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
