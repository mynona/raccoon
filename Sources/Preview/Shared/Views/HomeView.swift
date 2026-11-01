import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct HomeView: TemplateRepresentable {

    @Builder<Element>
    func render() -> [Element] {

        let name = ["name": PreviewTexts.productName]
        let componentCount = PreviewNavigation.groups.flatMap(\.sections)
            .flatMap(\.items).filter { !$0.isOpenInNewTab }.count
        let kitText = PreviewTexts.kitText.with(
            variables: ["count": "\(componentCount)"]
        )

        Basic(title: PreviewTexts.overview.resolved) {

            Div {

                showComponentTitle(
                    PreviewTexts.homeTitle.with(variables: name).resolved
                )

                P(PreviewTexts.homeIntro.with(variables: name).resolved)
                    .localized(PreviewTexts.homeIntro.with(variables: name))
                    .class("text-base text-gray-700 dark:text-gray-300 mb-8")

                Div {
                    // Card 1: Raccoon UI Kit
                    Div {
                        H2(PreviewTexts.kitTitle.with(variables: name).resolved)
                            .localized(
                                PreviewTexts.kitTitle.with(variables: name)
                            )
                            .class(
                                "text-lg font-bold mb-2 text-gray-900 dark:text-white"
                            )
                        P(kitText.resolved)
                            .localized(kitText)
                            .class(
                                "text-sm text-gray-600 dark:text-gray-400 mb-6"
                            )
                        LinkButton(
                            LinkButtonData(
                                label: PreviewTexts.browse.with(
                                    variables: name
                                ),
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
