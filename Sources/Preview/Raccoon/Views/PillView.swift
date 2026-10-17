import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct PillView: TemplateRepresentable {

    let variants: [(String, PillData)] = [
        (
            """
            // Neutral Counter Pill (Default)
            """,
            PillData(
                42,
                variant: .neutral
            )
        ),
        (
            """
            // Theme Accent Counter Pill
            """,
            PillData(
                3124,
                variant: .theme
            )
        ),
        (
            """
            // Text Pill with Status Variant
            """,
            PillData(
                "New",
                variant: .success,
                size: .base
            )
        ),
        (
            """
            // Large Error Pill
            """,
            PillData(
                "Failed",
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

                for (label, ctx) in variants {
                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { Pill(ctx).render() }
                            .class("mb-4 mt-4")
                    }
                }
            }
            .class("mt-4 space-y-6")
        }
        .render()
    }
}
