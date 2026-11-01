import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct LogoView: TemplateRepresentable {

    let variants: [PreviewVariant<LogoData>] = [
        #previewVariant(
            "Default Static Logo",
            LogoData()
        ),
        #previewVariant(
            "Linked Logo Destination",
            LogoData(destination: "/")
        ),
    ]

    func makeHtml(ctx: LogoData) -> String {
        let html = renderFragments(Logo(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Logo")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { Logo(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
