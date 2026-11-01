import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct BreadcrumbView: TemplateRepresentable {

    let variants: [PreviewVariant<BreadcrumbData>] = [
        #previewVariant(
            """
            //
            """,
            BreadcrumbData(
                paths: DemoData.breadcrumbPaths
            )
        ),
        #previewVariant(
            """
            // with Matomo
            """,
            BreadcrumbData(
                paths: DemoData.breadcrumbPaths,
                hasHome: true,
                matomoStatus: .ACCEPTED
            )
        ),
    ]

    func makeHtml(ctx: BreadcrumbData) -> String {
        let html = renderFragments(Breadcrumb(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Breadcrumb")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { Breadcrumb(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
