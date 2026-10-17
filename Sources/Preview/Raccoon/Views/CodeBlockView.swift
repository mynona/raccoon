import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct CodeBlockView: TemplateRepresentable {

    let variants: [(String, CodeBlockData)] = [
        (
            "// Swift function",
            CodeBlockData(
                code:
                    """
                    line 1
                    line 2
                    line 3
                    line 4
                    line 5
                    """
            )
        ),
        (
            "// Python function",
            CodeBlockData(
                code:
                    """
                    line 1 Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. 
                    line 2
                    line 3
                    line 4
                    line 5
                    line 6
                    line 7
                    line 8
                    line 10
                    line 11
                    line 12
                    line 13
                    line 14
                    line 15
                    line 16
                    line 17
                    line 18
                    line 19
                    line 20
                    line 21
                    line 22
                    line 23
                    line 24
                    line 25
                    line 26
                    line 27
                    line 28
                    line 29
                    line 30
                    """
            )
        ),
    ]

    func makeHtml(ctx: CodeBlockData) -> String {
        let html = renderFragments(CodeBlock(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("CodeBlock")

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { CodeBlock(ctx).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
