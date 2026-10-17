import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct KbdView: TemplateRepresentable {

    let variants: [(String, KeyboardKeyData)] = [
        (
            """
            // Shift
            """,
            KeyboardKeyData(key: .shift)
        ),
        (
            """
            // Command
            """,
            KeyboardKeyData(key: .command)
        ),
        (
            """
            // Ctrl
            """,
            KeyboardKeyData(key: .ctrl)
        ),
        (
            """
            // Custom text
            """,
            KeyboardKeyData(key: .text("K"))
        ),
        (
            """
            // Custom text
            """,
            KeyboardKeyData(key: .text("esc"))
        ),
    ]

    func makeHtml(ctx: KeyboardKeyData) -> String {
        let html = renderFragments(KeyboardKey(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Kbd")

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { KeyboardKey(ctx).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
