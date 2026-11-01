import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct LabelView: TemplateRepresentable {

    let variants: [PreviewVariant<LabelData>] = [
        #previewVariant(
            """
            // Required
            """,
            LabelData(
                id: "field-1",
                title: "Full name",
                isRequired: true
            )
        ),
        #previewVariant(
            """
            // Optional
            """,
            LabelData(
                id: "field-2",
                title: "Middle name",
                position: .right,
                isRequired: false
            )
        ),
        #previewVariant(
            """
            // Optional
            """,
            LabelData(
                id: "field-3",
                title: "Label",
                position: .left,
                size: .xl,
                isRequired: true,
                xhtml: "'xhtml-test'"
            )
        ),
    ]

    func makeHtml(ctx: LabelData) -> String {
        let html = renderFragments(Label(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Label")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { Label(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
