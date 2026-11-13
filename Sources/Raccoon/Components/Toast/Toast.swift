import Foundation
import HTML
import SGML
import SVG
import WebBuilders

/// A reusable, accessible toast notification component.
///
/// Renders a fixed container with pre-mounted ARIA live region announcers (WCAG 4.1.3),
/// dynamic Alpine.js-managed stacked cards, automatic timer pause on hover and focus (WCAG 2.2.1),
/// and keyboard quick-jump accessibility (WCAG 2.1.1).
public struct Toast: TemplateRepresentable {

    /// Configuration data for the toast container and behavior.
    public let data: ToastData
    typealias styles = ToastStyles

    private static let close = LocalizedText(
        "toast.close",
        "Close notification"
    )
    private static let notifications = LocalizedText(
        "toast.notifications",
        "Notifications"
    )

    /// Creates a new `Toast` instance.
    ///
    /// - Parameter data: Configuration data model for the toast container.
    public init(_ data: ToastData = ToastData()) {
        self.data = data
    }

    @Builder<Element>
    func showIcons() -> [Element] {
        Span {
            Span {
                Svg.icon(.check_circle, width: 20, height: 20)
            }
            .setAttribute(name: "x-show", value: "item.type === 'success'")

            Span {
                Svg.icon(.info_circle, width: 20, height: 20)
            }
            .setAttribute(name: "x-show", value: "item.type === 'info' || !item.type")

            Span {
                Svg.icon(.exclamation_triangle, width: 20, height: 20)
            }
            .setAttribute(name: "x-show", value: "item.type === 'warning'")

            Span {
                Svg.icon(.exclamation_circle, width: 20, height: 20)
            }
            .setAttribute(name: "x-show", value: "item.type === 'error'")
        }
        .class("flex-shrink-0 pt-0.5")
        .setAttribute(name: "aria-hidden", value: "true")
    }

    @Builder<Element>
    func showContent() -> [Element] {
        Div {
            P("")
                .setAttribute(name: "x-show", value: "item.title")
                .setAttribute(name: "x-text", value: "item.title")
                .class(styles.titleFont)

            Div {
                Span("")
                    .setAttribute(name: "x-show", value: "item.text")
                    .setAttribute(name: "x-text", value: "item.text")
            }
            .class(styles.textFont)
            .setAttribute(name: "x-show", value: "item.text")
        }
        .class("flex-1 min-w-0")
    }

    @Builder<Element>
    func showCloseButton() -> [Element] {
        Button {
            Svg.icon(.x_lg, width: 16, height: 16)
                .setAttribute(name: "aria-hidden", value: "true")
        }
        .type(.button)
        .localized(.ariaLabel, Self.close)
        .class(styles.closeButton)
        .setAttribute(name: "@click.stop", value: "remove(item.id)")
    }

    @Builder<Element>
    func showToastTemplate() -> [Element] {
        Template {
            Div {
                // Background tint overlay on top of solid opaque base to guarantee zero transparency
                Div {}
                    .class("absolute inset-0 pointer-events-none")
                    .setAttribute(name: ":class", value: "getVariantBackground(item.type)")

                Div {
                    if data.hasIcon {
                        showIcons()
                    }
                    showContent()
                    if data.isDismissible {
                        showCloseButton()
                    }
                }
                .class("relative z-10 flex items-start gap-3 w-full")
            }
            .class(styles.cardBase)
            .setAttribute(name: ":class", value: "getVariantBorder(item.type)")
            .setAttribute(
                name: ":role",
                value: "item.type === 'error' || item.type === 'warning' ? 'alert' : 'status'"
            )
            .setAttribute(
                name: ":aria-live",
                value: "item.type === 'error' || item.type === 'warning' ? 'assertive' : 'polite'"
            )
            .setAttribute(name: "aria-atomic", value: "true")
            .setAttribute(name: "tabindex", value: "0")
            .setAttribute(name: "@mouseenter", value: "pause(item.id)")
            .setAttribute(name: "@mouseleave", value: "resume(item.id)")
            .setAttribute(name: "@focusin", value: "pause(item.id)")
            .setAttribute(name: "@focusout", value: "resume(item.id)")
            .setAttribute(name: "@keydown.escape.stop", value: "remove(item.id)")
            .setAttribute(
                name: "x-transition:enter",
                value: "transition ease-out duration-300 motion-reduce:transition-none"
            )
            .setAttribute(
                name: "x-transition:enter-start",
                value: "opacity-0 translate-y-2 scale-95"
            )
            .setAttribute(
                name: "x-transition:enter-end",
                value: "opacity-100 translate-y-0 scale-100"
            )
            .setAttribute(
                name: "x-transition:leave",
                value: "transition ease-in duration-200 motion-reduce:transition-none"
            )
            .setAttribute(
                name: "x-transition:leave-start",
                value: "opacity-100 translate-y-0 scale-100"
            )
            .setAttribute(
                name: "x-transition:leave-end",
                value: "opacity-0 translate-y-2 scale-95"
            )
        }
        .setAttribute(name: "x-for", value: "item in items")
        .setAttribute(name: ":key", value: "item.id")
    }

    private var initialToastsJson: String {
        guard !data.initialToasts.isEmpty else { return "[]" }
        let items = data.initialToasts.map { item -> String in
            let id = item.id.isEmpty ? StableIdentifier.unique("toast") : item.id
            let type = item.type.rawValue
            let title = item.title?.resolved ?? ""
            let text = item.text?.resolved ?? ""
            let duration = item.durationMs.map(String.init) ?? "null"
            let escapedTitle = JavaScriptEscaper.escapeSingleQuotedString(title)
            let escapedText = JavaScriptEscaper.escapeSingleQuotedString(text)
            return "{id:'\(id)',type:'\(type)',title:'\(escapedTitle)',text:'\(escapedText)',duration:\(duration)}"
        }
        return "[\(items.joined(separator: ","))]"
    }

    @Builder<Element>
    public func render() -> [Element] {
        DebugComment("Toast container")
        Script()
            .src("/js/toast.js")
            .setAttribute(name: "type", value: "text/javascript")

        Section {
            // Stable pre-mounted live announcers for screen readers (WCAG 4.1.3)
            Div {}
                .id("raccoon-toast-announcer-polite")
                .role("status")
                .ariaLive(.polite)
                .setAttribute(name: "aria-atomic", value: "true")
                .class(styles.announcer)

            Div {}
                .id("raccoon-toast-announcer-assertive")
                .role("alert")
                .ariaLive(.assertive)
                .setAttribute(name: "aria-atomic", value: "true")
                .class(styles.announcer)

            showToastTemplate()
        }
        .id(data.id ?? "raccoon-toast-container")
        .role("region")
        .localized(.ariaLabel, data.ariaLabel ?? Self.notifications)
        .class(styles.container(position: data.position))
        .setAttribute(
            name: "x-data",
            value: "toastManager({ durationMs: \(data.durationMs), hasPauseOnHover: \(data.hasPauseOnHover), hasPauseOnFocus: \(data.hasPauseOnFocus), shortcutKey: '\(data.shortcutKey ?? "t")', initialToasts: \(initialToastsJson) })"
        )
    }
}
