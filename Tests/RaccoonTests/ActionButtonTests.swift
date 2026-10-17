import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

private let tracker = MatomoContentTracker(
    name: "test",
    piece: "button",
    target: "#"
)

@Suite("ActionButton")
struct ActionButtonTests {

    @Test("omits the id attribute entirely when no id is given")
    func omitsEmptyId() async throws {

        let html = renderHTML(
            ActionButton(
                ActionButtonData(
                    label: "Submit",
                    buttonType: .primary,
                    contentTracker: tracker
                )
            )
            .render()
        )
        #expect(!html.contains("id=\"\""))
    }

    @Test("renders an explicit id verbatim")
    func rendersExplicitId() async throws {

        let html = renderHTML(
            ActionButton(
                ActionButtonData(
                    id: "save",
                    label: "Submit",
                    buttonType: .primary,
                    contentTracker: tracker
                )
            )
            .render()
        )
        #expect(html.contains("id=\"save\""))
    }

    @Test("renders button label")
    func rendersLabel() async throws {

        let html = renderHTML(
            ActionButton(
                ActionButtonData(
                    label: "Submit",
                    buttonType: .primary,
                    contentTracker: tracker
                )
            )
            .render()
        )
        #expect(html.contains("Submit"))
    }

    @Test("renders button element")
    func rendersButtonElement() async throws {

        let html = renderHTML(
            ActionButton(
                ActionButtonData(
                    label: "Cancel",
                    buttonType: .secondary,
                    contentTracker: tracker
                )
            )
            .render()
        )
        #expect(html.contains("<button"))
    }

    @Test("renders full-width button")
    func rendersFullWidthButton() async throws {

        let html = renderHTML(
            ActionButton(
                ActionButtonData(
                    label: "Go",
                    buttonType: .primary,
                    hasFullWidth: true,
                    contentTracker: tracker
                )
            )
            .render()
        )
        #expect(html.contains("w-full"))
    }

    @Test("renders without label when nil")
    func rendersWithoutLabel() async throws {

        let html = renderHTML(
            ActionButton(
                ActionButtonData(
                    buttonType: .primary,
                    icon: .plus_lg,
                    contentTracker: tracker
                )
            )
            .render()
        )
        #expect(html.contains("<button"))
    }

    @Test("handles empty label")
    func handlesEmptyLabel() async throws {
        let html = renderHTML(
            ActionButton(
                ActionButtonData(
                    label: "",
                    buttonType: .primary,
                    contentTracker: tracker
                )
            )
            .render()
        )
        #expect(html.contains("<button"))
    }

    @Test("handles nil icon and label")
    func handlesNilIconAndLabel() async throws {
        let html = renderHTML(
            ActionButton(
                ActionButtonData(
                    buttonType: .primary,
                    contentTracker: tracker
                )
            )
            .render()
        )
        #expect(html.contains("<button"))
    }

    @Test("handles very long label")
    func handlesVeryLongLabel() async throws {
        let longLabel = String(repeating: "A", count: 1000)
        let html = renderHTML(
            ActionButton(
                ActionButtonData(
                    label: longLabel,
                    buttonType: .primary,
                    contentTracker: tracker
                )
            )
            .render()
        )
        #expect(html.contains(longLabel))
    }

    @Test("renders aria label and tooltip event wiring")
    func rendersAriaLabelAndTooltipWiring() async throws {

        let html = renderHTML(
            ActionButton(
                ActionButtonData(
                    label: "Submit",
                    ariaLabel: "Submit form",
                    tooltip: "Helpful text",
                    buttonType: .primary,
                    contentTracker: tracker
                )
            )
            .render()
        )

        #expect(html.contains("aria-label=\"Submit form\""))
        #expect(html.contains("x-on:mouseenter="))
        #expect(html.contains("x-on:mouseleave="))
        // Regression: tooltip x-data must use single-quoted JS literals, since the HTML
        // renderer does not escape double quotes inside double-quoted attribute values.
        #expect(html.contains("tooltipPosition: 'top'"))
        #expect(html.contains("tooltipText: 'Helpful text'"))
    }

    @Test("renders dynamic bindId and bindTooltipId attributes")
    func rendersDynamicBindIdAndBindTooltipId() async throws {

        let html = renderHTML(
            ActionButton(
                ActionButtonData(
                    id: "btn-static",
                    bindId: "'btn-' + index",
                    ariaLabel: "Dynamic action",
                    bindTooltipId: "'tip-' + index",
                    tooltip: "Dynamic tip",
                    buttonType: .icon,
                    icon: .trash3,
                    contentTracker: tracker
                )
            )
            .render()
        )

        #expect(html.contains(":id=\"'btn-' + index\""))
        #expect(html.contains(":x-ref=\"'tip-' + index\""))
        #expect(html.contains(":aria-describedby=\"'tip-' + index\""))
        #expect(
            html.contains(
                "x-on:mouseenter=\"window.dispatchEvent(new CustomEvent('show-tooltip', { detail: { id: 'tip-' + index } }))\""
            )
        )
        #expect(html.contains(":id=\"'tip-' + index\""))
    }

    @Test("renders form action attributes")
    func rendersFormActionAttributes() async throws {

        let html = renderHTML(
            ActionButton(
                ActionButtonData(
                    id: "submit-button",
                    action: "/preview-save",
                    method: .post,
                    label: "Submit",
                    buttonType: .secondary,
                    contentTracker: tracker
                )
            )
            .render()
        )

        #expect(html.contains("formaction=\"/preview-save\""))
        #expect(html.contains("formmethod=\"post\""))
    }

    @Test("renders bound form action attribute")
    func rendersBoundFormActionAttribute() async throws {

        let html = renderHTML(
            ActionButton(
                ActionButtonData(
                    bindAction: "dynamicUrl",
                    method: .post,
                    label: "Submit",
                    buttonType: .tertiary,
                    contentTracker: tracker
                )
            )
            .render()
        )

        #expect(html.contains("x-bind:formaction=\"dynamicUrl\""))
        #expect(html.contains("formmethod=\"post\""))
    }

    @Test("renders warning button styling and focus/hover states")
    func rendersWarningButton() async throws {

        let html = renderHTML(
            ActionButton(
                ActionButtonData(
                    label: "Delete",
                    buttonType: .warning,
                    contentTracker: tracker
                )
            )
            .render()
        )
        #expect(
            html.contains("bg-error") || html.contains("border-error")
        )
    }

    @Test("renders different sizes sm and xl")
    func rendersSizes() async throws {

        let smHtml = renderHTML(
            ActionButton(
                ActionButtonData(
                    label: "Small",
                    buttonType: .primary,
                    size: .sm,
                    contentTracker: tracker
                )
            )
            .render()
        )
        let xlHtml = renderHTML(
            ActionButton(
                ActionButtonData(
                    label: "Extra Large",
                    buttonType: .primary,
                    size: .xl,
                    contentTracker: tracker
                )
            )
            .render()
        )
        #expect(smHtml.contains("text-sm"))
        #expect(xlHtml.contains("text-lg"))
    }

    @Test("renders clickAction attribute")
    func rendersClickAction() async throws {

        let html = renderHTML(
            ActionButton(
                ActionButtonData(
                    clickAction: "handleClick()",
                    label: "Click",
                    buttonType: .primary,
                    contentTracker: tracker
                )
            )
            .render()
        )
        #expect(html.contains("x-on:click=\"handleClick()\""))
    }

    @Test(
        "renders the disabled attribute and disabled styling for state .disabled"
    )
    func rendersDisabledState() async throws {

        let html = renderHTML(
            ActionButton(
                ActionButtonData(
                    id: "btn-disabled",
                    label: "Save",
                    buttonType: .primary,
                    state: .disabled,
                    contentTracker: tracker
                )
            )
            .render()
        )
        #expect(html.contains("disabled"))
        #expect(html.contains(ActionButtonStyles.textColorDisabled))
        #expect(html.contains(ActionButtonStyles.backgroundColorDisabled))
        #expect(html.contains(ActionButtonStyles.borderDisabled))
    }

    @Test(
        "omits the disabled attribute and disabled styling for state .enabled"
    )
    func omitsDisabledStateWhenEnabled() async throws {

        let html = renderHTML(
            ActionButton(
                ActionButtonData(
                    id: "btn-enabled",
                    label: "Save",
                    buttonType: .primary,
                    state: .enabled,
                    contentTracker: tracker
                )
            )
            .render()
        )
        #expect(!html.contains("disabled"))
    }

    @Test("renders bound aria-expanded when bindAriaExpanded is set")
    func rendersBoundAriaExpanded() async throws {

        let html = renderHTML(
            ActionButton(
                ActionButtonData(
                    bindAriaExpanded: "showDatepicker",
                    ariaLabel: "Open calendar view",
                    buttonType: .icon,
                    icon: .calendar,
                    contentTracker: tracker
                )
            )
            .render()
        )
        #expect(html.contains(":aria-expanded=\"showDatepicker\""))
    }

    @Test("omits aria-expanded when bindAriaExpanded is nil")
    func omitsAriaExpandedByDefault() async throws {

        let html = renderHTML(
            ActionButton(
                ActionButtonData(
                    label: "Save",
                    buttonType: .primary,
                    contentTracker: tracker
                )
            )
            .render()
        )
        #expect(!html.contains("aria-expanded"))
    }

    @Test(
        "renders with multiline-ready wrapping classes and no whitespace-nowrap"
    )
    func rendersMultilineClasses() async throws {

        let html = renderHTML(
            ActionButton(
                ActionButtonData(
                    label:
                        "This is a very long button label that should wrap gracefully",
                    buttonType: .primary,
                    icon: .airplane,
                    contentTracker: tracker
                )
            )
            .render()
        )
        #expect(!html.contains("whitespace-nowrap"))
        #expect(html.contains("w-fit max-w-full"))
        #expect(html.contains("break-words"))
        #expect(html.contains("flex-none shrink-0"))
        #expect(html.contains("aria-hidden=\"true\""))
    }
}
