import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct PillView: TemplateRepresentable {

    let variants: [PreviewVariant<PillData>] = [
        #previewVariant(
            "Neutral Counter",
            PillData(
                42,
                variant: .neutral
            )
        ),
        #previewVariant(
            "Theme Accent Counter",
            PillData(
                3124,
                variant: .theme
            )
        ),
        #previewVariant(
            "Success Status Text",
            PillData(
                tr("New", de: "Neu", fr: "Nouveau", es: "Nuevo", it: "Nuovo"),
                variant: .success,
                size: .base
            )
        ),
        #previewVariant(
            "Large Error Status Text",
            PillData(
                tr(
                    "Failed",
                    de: "Fehlgeschlagen",
                    fr: "Échec",
                    es: "Fallido",
                    it: "Non riuscito"
                ),
                variant: .error,
                size: .xl
            )
        ),
    ]

    func makeHtml(ctx: PillData) -> String {
        let html = renderFragments(Pill(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {
        Basic {
            Div {
                showComponentTitle("Pill")

                for variant in variants {
                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { Pill(variant.data).render() }
                            .class("mb-4 mt-4")
                    }
                }
            }
            .class("mt-4 space-y-6")
        }
        .render()
    }
}
