import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct AccordionView: TemplateRepresentable {

    let variants: [PreviewVariant<AccordionData>] = [
        #previewVariant(
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
        #previewVariant(
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
        #previewVariant(
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

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { Accordion(variant.data).render() }
                            .class("mb-4 mt-4")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
