import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct HomeView: TemplateRepresentable {

    @Builder<Element>
    func render() -> [Element] {

        Basic(title: "Overview") {

            Div {

                showComponentTitle("Raccoon Component Preview")

                P(
                    "Welcome to the Raccoon component and template preview environment. Select a component or template from the sidebar to inspect its rendering, data model, and HTML output."
                )
                .class("text-base text-gray-700 dark:text-gray-300 mb-8")

                Div {
                    // Card 1: Raccoon UI Kit
                    Div {
                        H2("Raccoon UI Kit")
                            .class(
                                "text-lg font-bold mb-2 text-gray-900 dark:text-white"
                            )
                        P("Core domain-agnostic UI components (54 components).")
                            .class(
                                "text-sm text-gray-600 dark:text-gray-400 mb-6"
                            )
                        LinkButton(
                            LinkButtonData(
                                label: "Browse Raccoon Components",
                                href: "/preview/accordion",
                                buttonType: .secondary,
                                icon: .arrow_right_circle,
                                contentTracker: tracker
                            )
                        )
                        .render()
                    }
                    .class(
                        "p-6 rounded-lg border border-gray-300 dark:border-gray-700 bg-white dark:bg-surface-dark flex flex-col justify-between"
                    )
                }
                .class("grid grid-cols-1 gap-6 mt-6")

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
