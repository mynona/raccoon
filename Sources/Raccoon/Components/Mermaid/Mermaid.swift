import HTML
import SGML
import WebBuilders

public struct Mermaid: TemplateRepresentable {
    let data: MermaidData

    public init(
        _ data: MermaidData,
    ) {
        self.data = data
    }

    func width() -> UInt8 {
        // min(a,b) returns the smaller value
        min(data.widthInPercent, 100)
    }

    @Builder<Element>
    public func render() -> [Element] {

        DebugComment("Mermaid diagram")

        // https://www.npmjs.com/package/agentic-mermaid
        // https://github.com/adewale/agentic-mermaid/blob/main/docs/browser.md
        // Lazy-loaded ESM bundle (fetches only the diagram families used on the page instead of the 2.9MB classic bundle).
        Script()
            .setAttribute(
                name: "src",
                value: "/js/agentic-mermaid-component-lazy.js"
            )

        Div {
            Div {
                Pre(data.diagram)
                    .class("mermaid-source hidden")

                Div {}
                    .class("mermaid-target")
                    .if(data.isCentered) {
                        $0.addClass("w-full flex justify-center mx-auto")
                    }
                    .style("width: \(width())%;")
            }
            .setAttribute(
                name: "x-data",
                value: "beautifulMermaidComponent($el)"
            )
            .if(data.isCentered) {
                $0.class("w-full")
            }
        }
        .class("mt-8 mb-8")

    }

}
