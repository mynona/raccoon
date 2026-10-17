import HTML
import SGML
import WebBuilders

/// A rounded pill badge displaying a counter or text label.
public struct Pill: TemplateRepresentable {
    let data: PillData
    typealias styles = PillStyles

    /// Initializes a `Pill` with the specified configuration data.
    ///
    /// - Parameter data: Configuration data defining the content, styling, and options.
    public init(_ data: PillData) {
        self.data = data
    }

    /// Computes the displayed label string.
    private var displayedText: String {
        if let count = data.count {
            return String(count)
        }
        return data.text ?? ""
    }

    @Builder<Element>
    public func render() -> [Element] {
        if !displayedText.isEmpty {
            Span(displayedText)
                .if(data.id != nil) {
                    $0.id(data.id!)
                }
                .if(data.bindId != nil) {
                    $0.setAttribute(name: "x-bind:id", value: data.bindId!)
                }
                .if(data.ariaLabel != nil) {
                    $0.setAttribute(name: "aria-label", value: data.ariaLabel!)
                }
                .if(data.bindClass != nil) {
                    $0.setAttribute(
                        name: "x-bind:class",
                        value: data.bindClass!
                    )
                }
                .class(styles.style(variant: data.variant, size: data.size))
                // Matomo tracking
                .if(
                    data.matomoStatus == .ACCEPTED
                        || data.matomoStatus == .BANNER
                ) {
                    $0
                        .flagAttribute("data-track-content")
                        .setAttribute(name: "data-content-name", value: "pill")
                        .setAttribute(
                            name: "data-content-piece",
                            value: "pill.badge"
                        )
                        .setAttribute(
                            name: "data-content-target",
                            value: displayedText
                        )
                }
        }
    }
}
