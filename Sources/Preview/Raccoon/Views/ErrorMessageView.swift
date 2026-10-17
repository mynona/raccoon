import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct ErrorMessageView: TemplateRepresentable {

    let variants: [(String, ErrorMessageData)] = [
        (
            """
            // With error messages
            """,
            ErrorMessageData(
                id: "err2",
                errorMessages: [
                    "Error 1",
                    "Error 2",
                ],
                hasIcon: true
            )
        ),
        (
            """
            // With error messages
            """,
            ErrorMessageData(
                id: "err3",
                errorMessages: [
                    "Error 3"
                ],
                hasIcon: false
            )
        ),
    ]

    func makeHtml(ctx: ErrorMessageData) -> String {
        let html = renderFragments(ErrorMessage(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("ErrorMessage")

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { ErrorMessage(ctx).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
