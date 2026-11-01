import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct SpacerView: TemplateRepresentable {

    let variants: [PreviewVariant<SpacerData>] = (1...10)
        .map { n in
            #previewVariant(
                "Spacing Level \(n)",
                SpacerData(space: UInt(n))
            )
        }

    func makeHtml(ctx: SpacerData) -> String {
        let html = renderFragments(Spacer(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Spacer")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { Spacer(variant.data).render() }
                            .class(
                                [
                                    "mb-4 mt-12 border",
                                    CommonStyles.buttonBackgroundColorTertiary,
                                    CommonStyles.borderColorDefault,
                                ]
                                .joined(separator: " ")
                            )
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
