import HTML
import SGML
import SVG
import WebBuilders

/// A reusable UI component that renders a "copy to clipboard" button.
///
/// The component displays a copy icon by default, and when clicked,
/// copies the provided value to the user's clipboard. After a successful
/// copy action, the icon changes to a checkmark and a "Copied" label
/// is shown for a short duration.
///
/// The layout orientation (horizontal or vertical) is determined by
/// the `CopyToClipboardData` passed into the component.
public struct CopyToClipboard: TemplateRepresentable {
    let data: CopyToClipboardData
    typealias styles = CopyToClipboardStyles

    public init(_ data: CopyToClipboardData) {
        self.data = data
    }

    @Builder<Element>
    func showIcon() -> [Element] {
        Div {
            Svg.icon(.copy)
                .setAttribute(
                    name: "x-show",
                    value: "!copied"
                )

            Svg.icon(.check_circle)
                .setAttribute(
                    name: "x-show",
                    value: "copied"
                )
        }
        .class("flex-initial")
    }

    @Builder<Element>
    func showCopiedLabel() -> [Element] {
        // "Copied" label, shown only when copy succeeds.
        Span("Copied")
            .class("flex-initial leading-4")
            .addClass(styles.textSize)
            .if(data.orientation == .horizontal) {
                $0.addClass("pl-2")
            }
            .if(data.orientation == .vertical) {
                $0.addClass("pt-2")
            }
            .setAttribute(
                name: "x-show",
                value: "copied"
            )
            .setAttribute(
                name: "aria-live",
                value: "polite"
            )

        Span("Failed to copy")
            .class("flex-initial leading-4")
            .addClass(styles.textColorError)
            .addClass(styles.textSize)
            .setAttribute(
                name: "x-show",
                value: "copyFailed"
            )
            .setAttribute(
                name: "aria-live",
                value: "assertive"
            )
    }

    @Builder<Element>
    public func render() -> [Element] {

        DebugComment("Copy-to-clipboard widget")
        Script()
            .src("/js/copytoclipboard.js")
            .setAttribute(
                name: "type",
                value: "text/javascript"
            )

        Div {
            // Hidden input ensures the value is included in form submissions.
            Input()
                .type(.hidden)
                .name(data.key)
                .value(JavaScriptEscaper.htmlAttributeEscape(data.value))

            Button {
                showIcon()
                showCopiedLabel()
            }
            .type(.button)
            .class("flex cursor-pointer relative group")
            .if(data.orientation == .horizontal) {
                $0.addClass("flex-row items-center")
            }
            .if(data.orientation == .vertical) {
                $0.addClass("flex-col items-center justify-center")
            }
            .setAttribute(name: "x-data", value: "copyToClipboard()")
            .setAttribute(
                name: "data-text",
                value: JavaScriptEscaper.htmlAttributeEscape(data.value)
            )
            .setAttribute(name: "@click", value: "copy($el.dataset.text)")
            .setAttribute(name: "aria-label", value: "Copy text")
            .setAttribute(name: "title", value: "Click to copy")
            // Matomo
            .if(data.matomoStatus == .ACCEPTED || data.matomoStatus == .BANNER)
            {

                $0
                    .flagAttribute("data-track-content")
                    .setAttribute(
                        name: "data-content-name",
                        value: "copyToClipboard"
                    )
                    .setAttribute(
                        name: "data-content-piece",
                        value: "button.copy"
                    )
                    .setAttribute(name: "data-content-target", value: data.key)

            }
            .addClass(styles.iconButton)
        }
    }
}
