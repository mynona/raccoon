import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct KbdView: TemplateRepresentable {

    let variants: [PreviewVariant<KeyboardKeyData>] = [
        #previewVariant(
            """
            // Shift
            """,
            KeyboardKeyData(key: .shift)
        ),
        #previewVariant(
            """
            // Command
            """,
            KeyboardKeyData(key: .command)
        ),
        #previewVariant(
            """
            // Ctrl
            """,
            KeyboardKeyData(key: .ctrl)
        ),
        #previewVariant(
            """
            // Custom text
            """,
            KeyboardKeyData(key: .text("K"))
        ),
        #previewVariant(
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

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { KeyboardKey(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
