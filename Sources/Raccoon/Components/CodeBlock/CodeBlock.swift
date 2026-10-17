import HTML
import SGML
import SVG
import WebBuilders

public struct CodeBlock: TemplateRepresentable {
    let data: CodeBlockData
    typealias styles = CodeBlockStyles

    public init(
        _ data: CodeBlockData
    ) {
        self.data = data
    }

    @Builder<Element>
    func showCopyToClipboard() -> [Element] {
        Div {
            CopyToClipboard(
                CopyToClipboardData(
                    value: data.code,
                    orientation: .vertical
                )
            )
            .render()
        }
        .class(
            "absolute inset-y-0 right-0 flex flex-1 items-center pr-4 justify-center h-auto px-3 w-24"
        )
        .addClass(styles.copyContainer)
    }

    @Builder<Element>
    public func render() -> [Element] {

        DebugComment("CodeBlock")
        Div {

            Pre {
                // data.code.replacingOccurrences(of: "\n", with: "</br>")
                //let pattern = #"(?m)^(.*)$"#
                let pattern = #"(?m)^(?!\s*$)(.*)$"#

                let result = data.code.replacingOccurrences(
                    of: pattern,
                    with: "<span>$1</span>",
                    options: [.regularExpression]
                )

                Code(result)
                    .setAttribute(
                        name: "data-lang",
                        value: "text"
                    )
                    .tabIndex(-1)
                    .class(
                        "whitespace-pre-wrap break-words break-all max-w-full block"
                    )
                    .addClass(styles.codeText)
            }
            .class("max-h-[400px] overflow-y-auto overflow-x-hidden")
            .tabIndex(-1)

            showCopyToClipboard()

        }
        .class(
            "relative p-4 md:p-4 lg:p-6 !mt-10 mb-10"
        )
        .addClass(styles.codeContainer)

    }
}
