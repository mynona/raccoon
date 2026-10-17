import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct PasswordInputView: TemplateRepresentable {

    let variants: [(String, PasswordInputData)] = [
        (
            """
            // Default
            """,
            PasswordInputData(
                passwordId: "password",
                passwordLabel: LabelData(
                    id: "password",
                    title: "Password"
                )
            )
        )
    ]

    func makeHtml(ctx: PasswordInputData) -> String {
        let html = renderFragments(PasswordInput(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("PasswordInput")

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { PasswordInput(ctx).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
