import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct ButtonView: TemplateRepresentable {

    let variants: [(String, ActionButtonData)] = [
        (
            """
            Primary Button
            """,
            ActionButtonData(
                id: "btn-1",
                clickAction: "alert('ClickAction fired');",
                label: "Label",
                ariaLabel: "Aria-Label",
                tooltip: "Tooltip",
                tooltipPosition: .bottom,
                htmlType: .submit,
                buttonType: .primary,
                state: .enabled,
                size: .base,
                hasFullWidth: true,
                icon: .airplane,
                iconPosition: .left,
                matomoStatus: .DEACTIVATED,
                contentTracker: tracker
            )
        ),
        (
            """
            // with Matomo
            """,
            ActionButtonData(
                id: "btn-2",
                label: "Label",
                ariaLabel: "Aria-Label",
                tooltip: "Tooltip",
                tooltipPosition: .right,
                htmlType: .submit,
                buttonType: .primary,
                state: .enabled,
                size: .base,
                hasFullWidth: false,
                icon: nil,
                iconPosition: .left,
                matomoStatus: .ACCEPTED,
                contentTracker: tracker
            )
        ),
        (
            """
            //
            """,
            ActionButtonData(
                id: "btn-3",
                label: "Label",
                ariaLabel: "Aria-Label",
                tooltip: "Tooltip",
                tooltipPosition: .right,
                htmlType: .submit,
                buttonType: .secondary,
                state: .enabled,
                size: .base,
                hasFullWidth: false,
                icon: nil,
                iconPosition: .left,
                matomoStatus: .DEACTIVATED,
                contentTracker: tracker
            )
        ),
        (
            """
            //
            """,
            ActionButtonData(
                id: "btn-8",
                label: "Label",
                ariaLabel: "Aria-Label",
                tooltip: "Tooltip",
                tooltipPosition: .right,
                htmlType: .submit,
                buttonType: .tertiary,
                state: .enabled,
                size: .base,
                hasFullWidth: false,
                icon: nil,
                iconPosition: .left,
                matomoStatus: .DEACTIVATED,
                contentTracker: tracker
            )
        ),
        (
            """
            //
            """,
            ActionButtonData(
                id: "btn-12",
                label: "Label",
                ariaLabel: "Aria-Label",
                tooltip: "Tooltip",
                tooltipPosition: .right,
                htmlType: .submit,
                buttonType: .warning,
                state: .enabled,
                size: .base,
                hasFullWidth: false,
                icon: nil,
                iconPosition: .left,
                matomoStatus: .DEACTIVATED,
                contentTracker: tracker
            )
        ),
        (
            """
            // .icon
            """,
            ActionButtonData(
                id: "btn-22",
                label: nil,
                ariaLabel: "Aria-Label",
                tooltip: "Tooltip",
                tooltipPosition: .bottom,
                htmlType: .submit,
                buttonType: .icon,
                state: .enabled,
                size: .base,
                hasFullWidth: false,
                icon: .cake,
                iconPosition: .left,
                matomoStatus: .DEACTIVATED,
                contentTracker: tracker
            )
        ),
        (
            """
            /// action + method:
            /// Sets the button's formaction and formmethod (native form submission).
            /// Clicking this button will submit the form to the server endpoint /preview-save using POST.
            """,
            ActionButtonData(
                id: "btn-action",
                action: "/preview-save",  // -> becomes formaction="/preview-save"
                method: .post,  // -> becomes formmethod="post"
                label: "Submit to /preview-save",
                ariaLabel: "SubmitAction",
                tooltip: "Submits form to server",
                tooltipPosition: .top,
                htmlType: .submit,
                buttonType: .secondary,
                state: .enabled,
                size: .base,
                hasFullWidth: false,
                icon: nil,
                iconPosition: .left,
                matomoStatus: .DEACTIVATED,
                contentTracker: tracker
            )
        ),
        (
            """
            /// bindAction:
            /// Sets x-bind:formaction to a JS expression so the button's target can change at runtime.
            /// Requires a parent Alpine scope that defines the bound variable (e.g., dynamicUrl).
            """,
            ActionButtonData(
                id: "btn-bindAction",
                bindAction: "dynamicUrl",  // -> becomes x-bind:formaction="dynamicUrl"
                method: .post,
                label: "Submit to dynamic URL",
                ariaLabel: "BindAction",
                tooltip: "Reactive formaction via x-bind:formaction",
                tooltipPosition: .right,
                htmlType: .submit,
                buttonType: .tertiary,
                state: .enabled,
                size: .base,
                hasFullWidth: false,
                icon: nil,
                iconPosition: .left,
                matomoStatus: .DEACTIVATED,
                contentTracker: tracker
            )
        ),
        (
            """
            // state: .disabled — primary
            """,
            ActionButtonData(
                id: "btn-disabled-primary",
                clickAction: "alert('This must never fire');",
                label: "Label",
                ariaLabel: "Disabled primary button",
                tooltip: "Tooltip",
                tooltipPosition: .right,
                htmlType: .submit,
                buttonType: .primary,
                state: .disabled,
                size: .base,
                hasFullWidth: false,
                icon: .airplane,
                iconPosition: .left,
                matomoStatus: .DEACTIVATED,
                contentTracker: tracker
            )
        ),
        (
            """
            // state: .disabled — secondary
            """,
            ActionButtonData(
                id: "btn-disabled-secondary",
                label: "Label",
                ariaLabel: "Disabled secondary button",
                buttonType: .secondary,
                state: .disabled,
                contentTracker: tracker
            )
        ),
        (
            """
            // state: .disabled — tertiary
            """,
            ActionButtonData(
                id: "btn-disabled-tertiary",
                label: "Label",
                ariaLabel: "Disabled tertiary button",
                buttonType: .tertiary,
                state: .disabled,
                contentTracker: tracker
            )
        ),
        (
            """
            // state: .disabled — warning
            """,
            ActionButtonData(
                id: "btn-disabled-warning",
                label: "Label",
                ariaLabel: "Disabled warning button",
                buttonType: .warning,
                state: .disabled,
                contentTracker: tracker
            )
        ),
        (
            """
            // state: .disabled — icon only
            """,
            ActionButtonData(
                id: "btn-disabled-icon",
                ariaLabel: "Disabled icon button",
                tooltip: "Tooltip",
                tooltipPosition: .bottom,
                buttonType: .icon,
                state: .disabled,
                icon: .cake,
                contentTracker: tracker
            )
        ),
        (
            """
            // No explicit id and no tooltipId — identical to the two below.
            // Hovering one icon button must show exactly one tooltip.
            """,
            ActionButtonData(
                ariaLabel: "Icon button without id, first",
                tooltip: "Same tooltip text on all three",
                tooltipPosition: .top,
                buttonType: .tertiary,
                icon: .airplane,
                contentTracker: tracker
            )
        ),
        (
            """
            // No explicit id, second of three
            """,
            ActionButtonData(
                ariaLabel: "Icon button without id, second",
                tooltip: "Same tooltip text on all three",
                tooltipPosition: .top,
                buttonType: .tertiary,
                icon: .airplane,
                contentTracker: tracker
            )
        ),
        (
            """
            // Multiline wrapping with icon
            """,
            ActionButtonData(
                id: "btn-multiline",
                label:
                    "This is a very long button label that exceeds typical button widths and wraps across several lines with vertical centering",
                buttonType: .primary,
                size: .base,
                hasFullWidth: false,
                icon: .airplane,
                iconPosition: .left,
                contentTracker: tracker
            )
        ),
    ]

    func makeHtml(ctx: ActionButtonData) -> String {
        let html = renderFragments(ActionButton(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Button")

                for (index, (label, ctx)) in variants.enumerated() {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        id: "btn-\(index)",
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Form {
                            Div { ActionButton(ctx).render() }
                                .class("flex")
                        }
                        .setAttribute(
                            name: "x-data",
                            value: "{ dynamicUrl: 'something' }"
                        )
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
