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

        Basic(title: PreviewTexts.overview.resolved, contentPadding: false) {

            Div {
                // Subtle decorative background illustration stretching across the full content area
                Div {
                    Img(src: "/images/raccoon-sketch-branch.png", alt: "")
                        .setAttribute(name: "aria-hidden", value: "true")
                        .setAttribute(
                            name: "style",
                            value: "opacity: 0.10; mix-blend-mode: multiply;"
                        )
                        .class("w-full h-full object-cover object-center pointer-events-none select-none dark:invert")
                }
                .class("pointer-events-none select-none absolute inset-0 w-full h-full overflow-hidden -z-0")
                .setAttribute(name: "aria-hidden", value: "true")

                Div {
                    Div {
                        showComponentTitle(
                            PreviewTexts.homeTitle.with(variables: name).resolved
                        )

                        P(PreviewTexts.homeIntro.with(variables: name).resolved)
                            .localized(PreviewTexts.homeIntro.with(variables: name))
                            .class(["mb-8 text-base", CommonStyles.textColorDefault].joined(separator: " "))
                    }
                    .class("max-w-6xl mx-auto p-6 md:p-8 lg:p-10")
                }
                .class("relative z-10 w-full")

            }
            .class("relative w-full min-h-screen overflow-hidden")

        }
        .render()

    }
}
