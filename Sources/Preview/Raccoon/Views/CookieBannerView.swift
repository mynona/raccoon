import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct CookieBannerView: TemplateRepresentable {

    let variants: [PreviewVariant<CookieBannerData>] = [
        #previewVariant(
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

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { CookieBanner(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
