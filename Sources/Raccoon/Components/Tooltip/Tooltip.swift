import HTML
import SGML
import WebBuilders

/// ## Tooltip Usage
///
/// The `Tooltip` component renders an Alpine‑powered tooltip that attaches
/// to any element via a shared `id`. To use a tooltip correctly, three things
/// must be present:
///
/// 1. **A wrapper with `x-data` and `position: relative`**
///    This creates the Alpine scope and ensures the tooltip can position
///    itself relative to the trigger element.
///    ```html
///    <div x-data class="relative inline-block">
///    ```
///
/// 2. **A trigger element with a matching `x-ref`**
///    The trigger must define an `x-ref` whose value matches the tooltip’s
///    `context.id`.
///    ```html
///    <button x-ref="tooltip-1">Hover me</button>
///    ```
///
/// 3. **Show/Hide events using the same ID**
///    The trigger must dispatch `show-tooltip` and `hide-tooltip` events
///    with the same ID used in `x-ref` and `TooltipData(id:)`.
///    ```html
///    x-on:mouseenter="window.dispatchEvent(new CustomEvent('show-tooltip', { detail: { id: 'tooltip-1' } }))"
///    x-on:mouseleave="window.dispatchEvent(new CustomEvent('hide-tooltip', { detail: { id: 'tooltip-1' } }))"
///    ```
///
/// 4. **Render the tooltip with the same ID**
///    ```swift
///    Tooltip(
///        TooltipData(
///            id: "tooltip-1",
///            text: "Tooltip text",
///            arrow: true,
///            position: .top
///        )
///    )
///    ```
///
/// ### Minimal Working Example
///
/// ```html
/// <div x-data class="relative inline-block">
///     <button
///         x-ref="tooltip-1"
///         x-on:mouseenter="window.dispatchEvent(new CustomEvent('show-tooltip', { detail: { id: 'tooltip-1' } }))"
///         x-on:mouseleave="window.dispatchEvent(new CustomEvent('hide-tooltip', { detail: { id: 'tooltip-1' } }))"
///         class="inline-block"
///     >
///
public struct Tooltip: TemplateRepresentable {
    let context: TooltipData
    typealias styles = TooltipStyles

    public init(_ context: TooltipData) {
        self.context = context
    }

    @Builder<Element>
    public func render() -> [Element] {
        DebugComment("Tooltip")
        Div {

            Div {

                Div {

                    P {}
                        .setAttribute(
                            name: "x-text",
                            value: "tooltipText"
                        )
                        .class("shrink-0 block")
                        .addClass(styles.text)

                    Div {

                        Div {

                        }
                        .setAttribute(
                            name: ":class",
                            value:
                                "{ 'origin-top-left -rotate-45' : tooltipPosition == 'top', 'origin-top-left rotate-45' : tooltipPosition == 'left', 'origin-bottom-left rotate-45' : tooltipPosition == 'bottom', 'origin-top-right -rotate-45' : tooltipPosition == 'right' }"
                        )
                        .class("w-1.5 h-1.5 transform")
                        .addClass(styles.backgroundColor)

                    }
                    .setAttribute(
                        name: "x-ref",
                        value: "tooltipArrow"
                    )
                    .setAttribute(
                        name: "x-show",
                        value: "tooltipArrow"
                    )
                    .setAttribute(
                        name: ":class",
                        value:
                            "{ 'bottom-0 -translate-x-1/2 left-1/2 w-2.5 translate-y-full' : tooltipPosition == 'top', 'right-0 -translate-y-1/2 top-1/2 h-2.5 -mt-px translate-x-full' : tooltipPosition == 'left', 'top-0 -translate-x-1/2 left-1/2 w-2.5 -translate-y-full' : tooltipPosition == 'bottom', 'left-0 -translate-y-1/2 top-1/2 h-2.5 -mt-px -translate-x-full' : tooltipPosition == 'right' }"
                    )
                    .class(
                        "absolute inline-flex items-center justify-center overflow-visible"
                    )

                }
                .setAttribute(
                    name: "x-show",
                    value: "tooltipVisible"
                )
                .flagAttribute("x-transition")
                .class(
                    "relative px-2 py-1"
                )
                .addClass(styles.cornerRadius)
                .addClass(styles.backgroundColor)
                .addClass(styles.text)

            }
            .if(context.bindId != nil) {
                if let bindId = context.bindId {
                    return $0.setAttribute(name: ":id", value: bindId)
                }
                return $0
            } else: {
                $0.id(context.id)
            }
            .role("tooltip")
            .setAttribute(
                name: "x-ref",
                value: "tooltip"
            )
            .setAttribute(
                name: "x-show",
                value: "tooltipVisible"
            )
            .setAttribute(
                name: ":class",
                value:
                    "{ 'top-0 left-1/2 -translate-x-1/2 -mt-0.5 -translate-y-full' : tooltipPosition == 'top', 'top-1/2 -translate-y-1/2 -ml-0.5 left-0 -translate-x-full' : tooltipPosition == 'left', 'bottom-0 left-1/2 -translate-x-1/2 -mb-0.5 translate-y-full' : tooltipPosition == 'bottom', 'top-1/2 -translate-y-1/2 -mr-0.5 right-0 translate-x-full' : tooltipPosition == 'right' }"
            )
            .class("absolute w-auto")
            .flagAttribute("x-cloak")

        }
        .setAttribute(
            name: "x-data",
            value: """
                {
                 tooltipVisible: false,
                 tooltipText: \(JavaScriptEscaper.alpineStringLiteral(context.text)),
                 tooltipArrow: \(context.hasArrow),
                 tooltipPosition: \(JavaScriptEscaper.alpineStringLiteral(context.position.rawValue)),
                }
                """
        )
        .if(context.bindId != nil) {
            if let bindId = context.bindId {
                return
                    $0
                    .setAttribute(
                        name: "x-on:show-tooltip.window",
                        value:
                            "if ($event.detail.id === (\(bindId))) { const anchor = document.querySelector(`[x-ref='${$event.detail.id}']`); if (anchor) { tooltipVisible = true } }"
                    )
                    .setAttribute(
                        name: "x-on:hide-tooltip.window",
                        value:
                            "if ($event.detail.id === (\(bindId))) tooltipVisible = false"
                    )
            }
            return $0
        } else: {
            $0
                .setAttribute(
                    name: "x-on:show-tooltip.window",
                    value:
                        "if ($event.detail.id === \(JavaScriptEscaper.alpineStringLiteral(context.id))) { const anchor = document.querySelector(`[x-ref='${$event.detail.id}']`); if (anchor) { tooltipVisible = true } }"
                )
                .setAttribute(
                    name: "x-on:hide-tooltip.window",
                    value:
                        "if ($event.detail.id === \(JavaScriptEscaper.alpineStringLiteral(context.id))) tooltipVisible = false"
                )
        }
        .class("z-50")

    }
}
