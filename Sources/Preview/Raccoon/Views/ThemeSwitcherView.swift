import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct ThemeSwitcherView: TemplateRepresentable {

    let variants: [PreviewVariant<ThemeSwitcherData>] = [
        #previewVariant(
            "Default Theme Switcher",
            ThemeSwitcherData()
        ),
        #previewVariant(
            "Theme Switcher with Matomo",
            ThemeSwitcherData(
                id: "themeSwitcher",
                matomoStatus: .ACCEPTED
            )
        ),
        #previewVariant(
            "Custom Theme Options Subset",
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

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { ThemeSwitcher(variant.data).render() }
                            .class("mb-28 mt-4")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
