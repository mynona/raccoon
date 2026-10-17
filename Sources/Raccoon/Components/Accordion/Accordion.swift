import HTML
import SGML
import SVG
import WebBuilders

public struct Accordion: TemplateRepresentable {
    let data: AccordionData
    typealias styles = AccordionStyles

    public init(
        _ data: AccordionData
    ) {
        self.data = data
    }

    @Builder<Element>
    func makeContent() -> [Element] {
        switch data.content {
        case .html(let html):
            Div { InlineText(html, isRaw: true) }
                .if(data.isContentSansSerif) {
                    $0.addClass(styles.fontSans)
                }
        case .markdown(let markdown):
            Div { InlineText(renderMarkdownAsHTML(markdown), isRaw: true) }
                .if(data.isContentSansSerif) {
                    $0.addClass(styles.fontSans)
                }
        case .element(let elements):
            elements
        }
    }

    @Builder<Element>
    func showSummary(id: String) -> [Element] {
        Summary {
            Div {
                Div {

                    if let icon = data.icon {
                        Span {
                            Svg.icon(icon, width: 24, height: 24)
                                .addClass(styles.summaryLabel)

                        }
                        .class("flex-initial")
                    }

                    if let keyboardKey = data.keyboardKey?.uppercased() {
                        Span {
                            KeyboardKey(
                                KeyboardKeyData(
                                    key: .text(keyboardKey)
                                )
                            )
                            .render()
                        }
                        .class("flex-initial")
                    }

                    Span(data.label)
                        .class("flex-1 w-full")
                        .addClass(styles.summaryLabel)
                        .if(data.isLabelMonospaced) {
                            $0.addClass(styles.fontMono)
                        } else: {
                            $0.addClass(styles.fontSans)
                        }

                }
                .class("flex space-x-4 w-full items-center")

                Span { Svg.icon(.plus_lg, width: 24, height: 24) }
                    .class("flex items-center justify-center")
                    .addClass(styles.summaryOpenCloseToggleAnimation)
                    .addClass(styles.summaryLabel)
            }
            .class("flex w-full")
        }
        .id("accordion-\(id)-heading")
        .class("w-full px-4 py-2 mb-4 items-center")
        .addClass(styles.focusDefault)
        .addClass(styles.hoverDefault)
    }

    @Builder<Element>
    func showDetails(id: String) -> [Element] {
        Details {

            showSummary(id: id)

            Div { makeContent() }
                .id("accordion-\(id)-content")
                .ariaLabelledBy("accordion-\(id)-heading")
                .class("p-4")
                .addClass(styles.contentReset)
                .addClass(styles.detailsProse)
                .if(data.isContentSansSerif) {
                    $0.addClass(styles.fontSans)
                }

        }
        .class("group")
        // Matomo
        .if(data.matomoStatus == .ACCEPTED || data.matomoStatus == .BANNER) {

            $0
                .flagAttribute("data-track-content")
                .setAttribute(
                    name: "data-content-name",
                    value: "accordion"
                )
                .setAttribute(
                    name: "data-content-piece",
                    value: "button.toggle"
                )
                .setAttribute(
                    name: "data-content-target",
                    value: data.label
                )

        }
    }

    @Builder<Element>
    public func render() -> [Element] {

        DebugComment("Accordion")
        let componentId = data.id ?? StableIdentifier.unique(data.label)
        Div {
            Div { showDetails(id: componentId) }
                .class("pt-4")
        }
        .if(data.hasBorder) {
            $0.class(styles.summaryLabelBorder)
        }
    }
}
