import HTML
import SGML
import Testing

@testable import Raccoon

/// Renders a list of elements to a minified HTML string (no doctype).
private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("Toast")
struct ToastTests {

    @Test("renders container with default ID and region role")
    func rendersContainerWithDefaultId() {
        let html = renderHTML(Toast().render())
        #expect(html.contains("id=\"raccoon-toast-container\""))
        #expect(html.contains("role=\"region\""))
        #expect(html.contains("aria-label=\"Notifications\""))
    }

    @Test("renders container with custom ID and aria-label")
    func rendersContainerWithCustomIdAndLabel() {
        let customLabel = LocalizedText("custom.label", "Alerts & Messages")
        let data = ToastData(
            id: "my-custom-toast",
            ariaLabel: customLabel
        )
        let html = renderHTML(Toast(data).render())
        #expect(html.contains("id=\"my-custom-toast\""))
        #expect(html.contains("aria-label=\"Alerts &amp; Messages\""))
    }

    @Test("includes client script tag")
    func includesScriptTag() {
        let html = renderHTML(Toast().render())
        #expect(html.contains("<script src=\"/js/toast.js\" type=\"text/javascript\"></script>"))
    }

    @Test("pre-mounts stable polite and assertive live region announcers")
    func preMountsLiveRegionAnnouncers() {
        let html = renderHTML(Toast().render())

        // Polite announcer
        #expect(html.contains("id=\"raccoon-toast-announcer-polite\""))
        #expect(html.contains("role=\"status\""))
        #expect(html.contains("aria-live=\"polite\""))

        // Assertive announcer
        #expect(html.contains("id=\"raccoon-toast-announcer-assertive\""))
        #expect(html.contains("role=\"alert\""))
        #expect(html.contains("aria-live=\"assertive\""))

        // Both must have aria-atomic="true" and sr-only class
        #expect(html.contains("aria-atomic=\"true\""))
        #expect(html.contains("class=\"sr-only\""))
    }

    @Test("configures Alpine toastManager with duration and accessibility flags")
    func configuresAlpineToastManager() {
        let data = ToastData(
            shortcutKey: "m",
            durationMs: 7000,
            hasPauseOnHover: true,
            hasPauseOnFocus: true
        )
        let html = renderHTML(Toast(data).render())
        #expect(html.contains("durationMs: 7000"))
        #expect(html.contains("hasPauseOnHover: true"))
        #expect(html.contains("hasPauseOnFocus: true"))
        #expect(html.contains("shortcutKey: 'm'"))
    }

    @Test("applies correct position classes")
    func appliesPositionClasses() {
        let bottomEndHtml = renderHTML(Toast(ToastData(position: .bottomEnd)).render())
        #expect(bottomEndHtml.contains("bottom-0 right-0 sm:bottom-4 sm:right-4 items-end"))

        let topStartHtml = renderHTML(Toast(ToastData(position: .topStart)).render())
        #expect(topStartHtml.contains("top-0 left-0 sm:top-4 sm:left-4 items-start"))

        let bottomCenterHtml = renderHTML(Toast(ToastData(position: .bottomCenter)).render())
        #expect(bottomCenterHtml.contains("bottom-0 left-1/2 -translate-x-1/2 sm:bottom-4 items-center"))
    }

    @Test("serializes initial server-rendered toasts into x-data")
    func serializesInitialToasts() {
        let items = [
            ToastItemData(
                id: "init-1",
                type: .success,
                title: LocalizedText("init.title", "Saved"),
                text: LocalizedText("init.text", "Changes stored"),
                durationMs: 3000
            )
        ]
        let data = ToastData(initialToasts: items)
        let html = renderHTML(Toast(data).render())
        #expect(html.contains("id:'init-1'"))
        #expect(html.contains("type:'success'"))
        #expect(html.contains("title:'Saved'"))
        #expect(html.contains("text:'Changes stored'"))
        #expect(html.contains("duration:3000"))
    }

    @Test("renders card template with interaction and accessibility hooks")
    func rendersCardTemplateHooks() {
        let html = renderHTML(Toast().render())

        // Hover & focus pausing for WCAG 2.2.1
        #expect(html.contains("@mouseenter=\"pause(item.id)\""))
        #expect(html.contains("@mouseleave=\"resume(item.id)\""))
        #expect(html.contains("@focusin=\"pause(item.id)\""))
        #expect(html.contains("@focusout=\"resume(item.id)\""))

        // Escape key dismiss
        #expect(html.contains("@keydown.escape.stop=\"remove(item.id)\""))

        // Dynamic roles & transitions
        #expect(html.contains("motion-reduce:transition-none"))
        #expect(html.contains("aria-label=\"Close notification\""))
    }

    // MARK: Localization

    @Test("close button and region aria-label resolve language via I18n")
    func localizedAriaLabels() {
        let htmlDe = I18n.render(language: "de") {
            renderHTML(Toast().render())
        }
        #expect(htmlDe.contains("aria-label=\"Benachrichtigungen\""))
        #expect(htmlDe.contains("aria-label=\"Benachrichtigung schließen\""))

        let htmlFr = I18n.render(language: "fr") {
            renderHTML(Toast().render())
        }
        #expect(htmlFr.contains("aria-label=\"Notifications\""))
        #expect(htmlFr.contains("aria-label=\"Fermer la notification\""))
    }
}
