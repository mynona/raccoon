import Foundation
import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("Pill Component")
struct PillTests {

    @Test("Renders numeric counter with default neutral styling")
    func rendersNumericCounter() {
        let html = renderHTML(Pill(PillData(42)).render())
        #expect(html.contains("42"))
        #expect(html.contains(PillStyles.neutral))
        #expect(html.contains(CommonStyles.cornerRadiusFull))
    }

    @Test("Renders text label with theme variant and custom size")
    func rendersTextAndThemeVariant() {
        let html = renderHTML(
            Pill(
                PillData(
                    text: "New",
                    variant: .theme,
                    size: .sm
                )
            )
            .render()
        )
        #expect(html.contains("New"))
        #expect(html.contains(PillStyles.theme))
        #expect(html.contains(PillStyles.sizeSm))
    }

    @Test("Renders success and error variants")
    func rendersStatusVariants() {
        let successHtml = renderHTML(
            Pill(PillData(count: 5, variant: .success)).render()
        )
        #expect(successHtml.contains(PillStyles.success))

        let errorHtml = renderHTML(
            Pill(PillData(count: 1, variant: .error)).render()
        )
        #expect(errorHtml.contains(PillStyles.error))
    }

    @Test("Supports dynamic Alpine bindings and accessibility attributes")
    func rendersAlpineAndAccessibility() {
        let html = renderHTML(
            Pill(
                PillData(
                    id: "unread-pill",
                    bindId: "pillId",
                    bindClass: "isActive ? 'active' : 'inactive'",
                    text: "Unread",
                    ariaLabel: "3 unread messages"
                )
            )
            .render()
        )
        #expect(html.contains("id=\"unread-pill\""))
        #expect(html.contains("x-bind:id=\"pillId\""))
        #expect(
            html.contains("x-bind:class=\"isActive ? 'active' : 'inactive'\"")
        )
        #expect(html.contains("aria-label=\"3 unread messages\""))
        #expect(html.contains("Unread"))
    }

    @Test("Includes Matomo tracking attributes when enabled")
    func rendersMatomoTracking() {
        let html = renderHTML(
            Pill(
                PillData(
                    count: 99,
                    matomoStatus: .ACCEPTED
                )
            )
            .render()
        )
        #expect(html.contains("data-track-content"))
        #expect(html.contains("data-content-name=\"pill\""))
        #expect(html.contains("data-content-piece=\"pill.badge\""))
        #expect(html.contains("data-content-target=\"99\""))
    }

    @Test("Renders nothing when both count and text are nil or empty")
    func rendersNothingWhenEmpty() {
        let htmlNil = renderHTML(Pill(PillData()).render())
        #expect(htmlNil.isEmpty)

        let htmlEmpty = renderHTML(Pill(PillData(text: "")).render())
        #expect(htmlEmpty.isEmpty)
    }
}
