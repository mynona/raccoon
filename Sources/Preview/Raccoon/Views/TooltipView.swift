import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct TooltipView: TemplateRepresentable {

    let variants: [(String, TooltipData)] = [
        (
            """
            // Top
            """,
            TooltipData(
                id: "tooltip-1",
                text: "This appears on top",
                position: .top,
                hasArrow: true
            )
        ),
        (
            """
            // Bottom
            """,
            TooltipData(
                id: "tooltip-2",
                text: "This appears on bottom",
                position: .bottom,
                hasArrow: true
            )
        ),
    ]

    func makeHtml(ctx: TooltipData) -> String {
        let html = renderFragments(Tooltip(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Tooltip")

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

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

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div {

                            Button(ctx.text)
                                .setAttribute(
                                    name: "x-ref",
                                    value: ctx.id
                                )
                                .setAttribute(
                                    name: "x-on:mouseenter",
                                    value:
                                        "window.dispatchEvent(new CustomEvent('show-tooltip', { detail: { id: '\(ctx.id)' } }))"
                                )
                                .setAttribute(
                                    name: "x-on:mouseleave",
                                    value:
                                        "window.dispatchEvent(new CustomEvent('hide-tooltip', { detail: { id: '\(ctx.id)' } }))"
                                )
                                .class("inline-block")

                            Tooltip(ctx).render()

                        }
                        .class("relative inline-block mb-4 mt-12")
                        .setAttribute(name: "x-data", value: "{}")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
