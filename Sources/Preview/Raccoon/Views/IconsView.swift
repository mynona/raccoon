import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct IconsView: TemplateRepresentable {

    @Builder<Element>
    func render() -> [Element] {

        Basic(title: "Icons") {

            Div {

                showComponentTitle("Icons")

                // Search field
                Div {
                    SearchField(
                        SearchFieldData(
                            name: "iconSearchInput",
                            bindModel: "search",
                            bindRef: "searchInput",
                            placeholder: "Search icons...",
                            ariaLabel: "Search icons"
                        )
                    )
                    .render()
                }
                .class("mb-8")

                // Icons Grid
                Div {

                    let allIcons = SvgIcon.allCases

                    allIcons.map { icon in

                        Div {
                            Svg.icon(icon, width: 24, height: 24)

                            P(icon.rawValue)
                                .class(
                                    "text-xs font-mono text-center break-all text-gray-700 dark:text-gray-300"
                                )
                        }
                        .class(
                            "flex flex-col items-center gap-2 p-4 rounded border border-gray-200 dark:border-gray-700 hover:bg-tertiary dark:hover:bg-surface-dark bg-white dark:bg-surface-dark transition-colors"
                        )
                        .setAttribute(
                            name: "x-show",
                            value:
                                "search === '' || '\(icon.rawValue)'.includes(search.toLowerCase())"
                        )

                    }

                }
                .style(
                    "display:grid;grid-template-columns:repeat(auto-fill,minmax(110px,1fr));gap:0.75rem;"
                )

            }
            .class("mt-4 space-y-6")
            .setAttribute(name: "x-data", value: "{ search: '' }")

        }
        .render()

    }
}
