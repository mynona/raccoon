import HTML
import SGML
import SVG
import WebBuilders

/// A reusable UI component that renders a "copy to clipboard" button.
///
/// The component displays a copy icon by default, and when clicked,
/// copies the provided value to the user's clipboard. After a successful
/// copy action, the icon changes to a checkmark and feedback is communicated
/// either inline or via a toast notification.
///
/// The layout orientation, icons, and response message behavior are determined by
/// the `CopyToClipboardData` passed into the component.
public struct CopyToClipboard: TemplateRepresentable {
    let data: CopyToClipboardData
    typealias styles = CopyToClipboardStyles

    public init(_ data: CopyToClipboardData) {
        self.data = data
    }

    private static let copy = LocalizedText(
        "copytoclipboard.copy",
        "Copy text"
    )
    private static let hint = LocalizedText(
        "copytoclipboard.hint",
        "Click to copy"
    )
    private static let copied = LocalizedText(
        "copytoclipboard.copied",
        "Copied"
    )
    private static let failed = LocalizedText(
        "copytoclipboard.failed",
        "Failed to copy"
    )
    private static let toast = LocalizedText(
        "copytoclipboard.toast",
        "Copied to clipboard for copy-paste"
    )

    @Builder<Element>
    func showIcon() -> [Element] {
        Div {
            Svg.icon(data.icon)
                .setAttribute(
                    name: "x-show",
                    value: "!copied"
                )

            Svg.icon(data.copiedIcon)
                .setAttribute(
                    name: "x-show",
                    value: "copied"
                )
        }
        .class("flex-initial")
    }

    @Builder<Element>
    func showCopiedLabel() -> [Element] {
        if !data.hasToast {
            let label = data.label ?? Self.copied
            // "Copied" label, shown only when copy succeeds.
            Span(label.resolved)
                .localized(label)
                .class("flex-initial leading-4")
                .addClass(styles.textSize)
                .if(!data.isVertical) {
                    $0.addClass("pl-2")
                }
                .if(data.isVertical) {
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

            Span(Self.failed.resolved)
                .localized(Self.failed)
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
    }

    private func recordToastTexts(toastText: LocalizedText) {
        if data.hasToast {
            Self.copied.recordUse()
            toastText.recordUse()
            Self.failed.recordUse()
        }
    }

    @Builder<Element>
    public func render() -> [Element] {

        DebugComment("Copy-to-clipboard widget")
        Script()
            .src("/js/raccoon-copy-to-clipboard.js")
            .setAttribute(
                name: "type",
                value: "text/javascript"
            )

        let ariaLabel = data.ariaLabel ?? Self.copy
        let tooltip = data.tooltip ?? Self.hint

        let toastText = data.label ?? Self.toast

        let _ = recordToastTexts(toastText: toastText)

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
            .if(!data.isVertical) {
                $0.addClass("flex-row items-center")
            }
            .if(data.isVertical) {
                $0.addClass("flex-col items-center justify-center")
            }
            .setAttribute(
                name: "x-data",
                value: data.hasToast ? "copyToClipboard({ hasToast: true })" : "copyToClipboard()"
            )
            .setAttribute(
                name: "data-text",
                value: JavaScriptEscaper.htmlAttributeEscape(data.value)
            )
            .if(data.hasToast) {
                $0.setAttribute(name: "data-has-toast", value: "true")
                    .setAttribute(
                        name: "data-toast-title",
                        value: JavaScriptEscaper.htmlAttributeEscape(Self.copied.resolved)
                    )
                    .setAttribute(
                        name: "data-toast-text",
                        value: JavaScriptEscaper.htmlAttributeEscape(toastText.resolved)
                    )
                    .setAttribute(name: "data-i18n-toast-title", value: Self.copied.key)
                    .if(!toastText.key.isEmpty) {
                        $0.setAttribute(name: "data-i18n-toast-text", value: toastText.key)
                    }
            }
            .setAttribute(name: "@click", value: "copy($el.dataset.text)")
            .localized(.ariaLabel, ariaLabel)
            .localized(.title, tooltip)
            // Matomo
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
            .addClass(styles.iconButton)
        }
    }
}
