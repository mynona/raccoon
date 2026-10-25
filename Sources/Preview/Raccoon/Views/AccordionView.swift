import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct AccordionView: TemplateRepresentable {

    let variants: [(String, AccordionData)] = [
        (
            """
            // Border 
            """,
            AccordionData(
                label: "What is product thinking?",
                content: .html(
                    "Product thinking means solving the <em>right</em> problems, not just building features."
                ),
                icon: .journal_text,
                isLabelMonospaced: true,
                hasBorder: true,
                matomoStatus: .DECLINED
            )
        ),
        (
            """
            // No border + with Matomo
            """,
            AccordionData(
                label: "No border applied",
                content: .markdown("# Content"),
                hasBorder: false,
                matomoStatus: .ACCEPTED
            )
        ),
        (
            """
            // element
            """,
            AccordionData(
                label: "No border applied",
                content: .element {
                    H1("H1 Header").class("test")
                    P("Paragraph")
                },
                hasBorder: false
            )
        ),
    ]

    func makeHtml(ctx: AccordionData) -> String {
        let html = renderFragments(Accordion(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Accordion")

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { Accordion(ctx).render() }
                            .class("mb-4 mt-4")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
