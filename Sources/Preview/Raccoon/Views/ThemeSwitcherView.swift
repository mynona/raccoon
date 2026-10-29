import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct ThemeSwitcherView: TemplateRepresentable {

    let variants: [(String, ThemeSwitcherData)] = [
        (
            """
            // With default context
            """,
            ThemeSwitcherData()
        ),
        (
            """
            // With id and Matomo tracking enabled
            """,
            ThemeSwitcherData(
                id: "themeSwitcher",
                matomoStatus: .ACCEPTED
            )
        ),
        (
            """
            // With custom theme options
            """,
            ThemeSwitcherData(
                defaultTheme: .blackAndWhite,
                themes: [.blackAndWhite, .emeraldMine]
            )
        ),
    ]

    func makeHtml(ctx: ThemeSwitcherData) -> String {
        let html = renderFragments(ThemeSwitcher(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Theme Switcher")

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { ThemeSwitcher(ctx).render() }
                            .class("mb-28 mt-4")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
