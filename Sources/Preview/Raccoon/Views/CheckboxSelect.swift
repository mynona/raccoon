import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct CheckboxSelectView: TemplateRepresentable {

    let variants: [PreviewVariant<CheckboxSelectData>] = [
        #previewVariant(
            "With Search & Select All",
            CheckboxSelectData(
                id: "select-1",
                label: LabelData(
                    id: "tags",
                    title: tr(
                        "Tags",
                        de: "Tags",
                        fr: "Tags",
                        es: "Etiquetas",
                        it: "Tag"
                    )
                ),
                values: DemoData.optionList,
                helperText: HelperTextData(
                    id: "helper-1",
                    text: tr(
                        "helper text",
                        de: "Hilfetext",
                        fr: "texte d'aide",
                        es: "texto de ayuda",
                        it: "testo di aiuto"
                    )
                ),
                hasSearch: true,
                hasSelectAll: true
            )
        ),
        #previewVariant(
            "List Only Without Search",
            CheckboxSelectData(
                id: "select-2",
                label: LabelData(
                    id: "tags-2",
                    title: tr(
                        "Tags",
                        de: "Tags",
                        fr: "Tags",
                        es: "Etiquetas",
                        it: "Tag"
                    )
                ),
                values: DemoData.optionList,
                helperText: nil,
                hasSearch: false,
                hasSelectAll: false
            )
        ),
        #previewVariant(
            "With Select All Without Search",
            CheckboxSelectData(
                id: "select-3",
                label: LabelData(
                    id: "tags-3",
                    title: tr(
                        "Tags",
                        de: "Tags",
                        fr: "Tags",
                        es: "Etiquetas",
                        it: "Tag"
                    )
                ),
                values: DemoData.optionList,
                helperText: nil,
                hasSearch: false,
                hasSelectAll: true
            )
        ),
    ]

    func makeHtml(ctx: CheckboxSelectData) -> String {
        let html = renderFragments(CheckboxSelect(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("CheckboxSelect")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { CheckboxSelect(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()
    }
}
