import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct CookieBannerView: TemplateRepresentable {

    let variants: [(String, CookieBannerData)] = [
        (
            """
            // With default url
            """,
            CookieBannerData(url: "/test-page", matomoStatus: .BANNER)
        )
    ]

    func makeHtml(ctx: CookieBannerData) -> String {
        let html = renderFragments(CookieBanner(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("CookieBanner")

                // Remove Matomo cookie
                Script(
                    """
                    document.cookie = "raumnebenan-matomo=; path=/; max-age=0; expires=Thu, 01 Jan 1970 00:00:00 GMT";
                    """
                )

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { CookieBanner(ctx).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
