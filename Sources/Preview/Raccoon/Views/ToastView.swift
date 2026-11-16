import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct ToastView: TemplateRepresentable {

    let variants: [PreviewVariant<ToastData>] = [
        #previewVariant(
            tr(
                "Standard Toast Container (Bottom End)",
                [
                    "de": "Standard-Toast-Container (Unten Rechts)",
                    "fr": "Conteneur de toast standard (Bas droite)",
                    "es": "Contenedor de toast estándar (Abajo derecha)",
                    "it": "Contenitore toast standard (In basso a destra)",
                ]
            ),
            ToastData(
                id: "preview-toast-container",
                durationMs: 5000,
                position: .bottomEnd
            )
        ),
    ]

    func makeHtml(ctx: ToastData) -> String {
        let html = renderFragments(Toast(ctx).render())
        let formattedHtml = prettyHTML(html)
        return escapeHTML(formattedHtml)
    }

    @Builder<Element>
    func showInteractiveSandbox() -> [Element] {
        Div {
            H3("Interactive Live Demo")
                .class("text-lg font-semibold text-on-surface")

            P("Click the buttons below to dispatch live toasts. Trigger multiple in quick succession to test vertical stacking, hover/focus pausing, and keyboard shortcuts (Alt+T to focus, Escape to dismiss).")
                .class("text-sm text-on-surface-variant mb-4")

            Div {
                ActionButton(
                    ActionButtonData(
                        clickAction: "success()",
                        label: LocalizedText(verbatim: "Success Toast"),
                        htmlType: .button,
                        buttonType: .secondary,
                        icon: .check_circle,
                        contentTracker: MatomoContentTracker(
                            name: "preview-toast",
                            piece: "button.success",
                            target: ""
                        )
                    )
                )
                .render()

                ActionButton(
                    ActionButtonData(
                        clickAction: "info()",
                        label: LocalizedText(verbatim: "Info Toast"),
                        htmlType: .button,
                        buttonType: .secondary,
                        icon: .info_circle,
                        contentTracker: MatomoContentTracker(
                            name: "preview-toast",
                            piece: "button.info",
                            target: ""
                        )
                    )
                )
                .render()

                ActionButton(
                    ActionButtonData(
                        clickAction: "warning()",
                        label: LocalizedText(verbatim: "Warning Toast"),
                        htmlType: .button,
                        buttonType: .secondary,
                        icon: .exclamation_triangle,
                        contentTracker: MatomoContentTracker(
                            name: "preview-toast",
                            piece: "button.warning",
                            target: ""
                        )
                    )
                )
                .render()

                ActionButton(
                    ActionButtonData(
                        clickAction: "error()",
                        label: LocalizedText(verbatim: "Error (Sticky)"),
                        htmlType: .button,
                        buttonType: .secondary,
                        icon: .exclamation_circle,
                        contentTracker: MatomoContentTracker(
                            name: "preview-toast",
                            piece: "button.error",
                            target: ""
                        )
                    )
                )
                .render()

                ActionButton(
                    ActionButtonData(
                        clickAction: "stack()",
                        label: LocalizedText(verbatim: "Stack 3 Toasts"),
                        htmlType: .button,
                        buttonType: .secondary,
                        icon: .layers,
                        contentTracker: MatomoContentTracker(
                            name: "preview-toast",
                            piece: "button.stack",
                            target: ""
                        )
                    )
                )
                .render()

                ActionButton(
                    ActionButtonData(
                        clickAction: "clearAll()",
                        label: LocalizedText(verbatim: "Clear All"),
                        htmlType: .button,
                        buttonType: .secondary,
                        icon: .x_lg,
                        contentTracker: MatomoContentTracker(
                            name: "preview-toast",
                            piece: "button.clear",
                            target: ""
                        )
                    )
                )
                .render()
            }
            .class("flex flex-wrap gap-3")
        }
        .setAttribute(name: "x-data", value: "toastSandbox")
        .class("p-4 border border-on-surface rounded-lg bg-surface mb-6")
    }

    @Builder<Element>
    func render() -> [Element] {
        Basic {
            Div {
                showComponentTitle("Toast")

                showInteractiveSandbox()

                for variant in variants {
                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div {
                            P("Toast container is mounted in the document. Use the sandbox controls above to trigger visual toasts.")
                                .class("text-sm text-on-surface-variant italic py-4")
                        }
                    }
                }
            }
            .class("mt-4 space-y-6")
        }
        .render()
    }
}
