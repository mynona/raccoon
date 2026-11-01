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
                    .class(["mb-8 text-base", CommonStyles.textColorDefault].joined(separator: " "))

                Div {
                    // Card 1: Raccoon UI Kit
                    Div {
                        H2(PreviewTexts.kitTitle.with(variables: name).resolved)
                            .localized(
                                PreviewTexts.kitTitle.with(variables: name)
                            )
                            .class(
                                ["mb-2 text-lg font-bold", CommonStyles.textColorEmphasized].joined(separator: " ")
                            )
                        P(kitText.resolved)
                            .localized(kitText)
                            .class(
                                ["mb-6 text-sm", CommonStyles.textColorDefault].joined(separator: " ")
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
                        [
                            "p-6 flex flex-col justify-between",
                            CommonStyles.cornerRadiusLarge,
                            "border",
                            CommonStyles.borderColorDefault,
                            CommonStyles.backgroundLight,
                        ]
                        .joined(separator: " ")
                    )
                }
                .class("grid grid-cols-1 gap-6 mt-6")

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
