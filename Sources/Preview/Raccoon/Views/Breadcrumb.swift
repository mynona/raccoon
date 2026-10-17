import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct BreadcrumbView: TemplateRepresentable {

    let variants: [(String, BreadcrumbData)] = [
        (
            """
            //
            """,
            BreadcrumbData(
                paths: DemoData.breadcrumbPaths
            )
        ),
        (
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

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { Breadcrumb(ctx).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
