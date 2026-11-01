import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct HiddenFieldView: TemplateRepresentable {

    let variants: [PreviewVariant<HiddenFieldData>] = [
        #previewVariant(
            "Key-Value Hidden Input",
            HiddenFieldData(
                id: "hidden-key",
                value: "hidden-value",
                state: .enabled
            )
        )
    ]

    func makeHtml(ctx: HiddenFieldData) -> String {
        let html = renderFragments(HiddenField(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("HiddenField")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { HiddenField(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
