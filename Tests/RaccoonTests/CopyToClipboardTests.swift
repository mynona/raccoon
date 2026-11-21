import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("CopyToClipboard")
struct CopyToClipboardTests {

    @Test("renders copy button")
    func rendersCopyButton() async throws {

        let html = renderHTML(
            CopyToClipboard(
                CopyToClipboardData(value: "copy-me")
            )
            .render()
        )
        #expect(html.contains("<button"))
    }

    @Test("renders the value in x-data")
    func rendersValueInXData() async throws {

        let html = renderHTML(
            CopyToClipboard(
                CopyToClipboardData(
                    value: "my-api-key-123"
                )
            )
            .render()
        )
        #expect(html.contains("my-api-key-123"))
    }

    @Test("renders vertical inline layout variant")
    func rendersVerticalVariant() async throws {

        let html = renderHTML(
            CopyToClipboard(
                CopyToClipboardData(value: "token", responseType: .inlineVertical)
            )
            .render()
        )
        #expect(!html.isEmpty)
    }

    @Test("renders with empty value")
    func rendersWithEmptyValue() async throws {

        let html = renderHTML(
            CopyToClipboard(
                CopyToClipboardData(value: "")
            )
            .render()
        )
        #expect(html.contains("<button"))
    }

    @Test("renders with very long value")
    func rendersWithVeryLongValue() async throws {
        let longValue = String(repeating: "A", count: 2048)
        let html = renderHTML(
            CopyToClipboard(
                CopyToClipboardData(value: longValue)
            )
            .render()
        )
        #expect(html.contains(longValue))
    }

    @Test("renders visible focus indicator for accessibility")
    func rendersVisibleFocusIndicator() async throws {
        let html = renderHTML(
            CopyToClipboard(
                CopyToClipboardData(value: "focus")
            )
            .render()
        )
        #expect(html.contains("focus-within:ring-2"))
    }

    @Test("renders correctly after rapid clicking simulation")
    func rendersAfterRapidClicking() async throws {
        let html = renderHTML(
            CopyToClipboard(
                CopyToClipboardData(value: "rapid")
            )
            .render()
        )
        // No JS, but should still render button and value
        #expect(html.contains("<button"))
        #expect(html.contains("rapid"))
    }

    @Test("renders hidden input and copy wiring")
    func rendersHiddenInputAndCopyWiring() async throws {

        let html = renderHTML(
            CopyToClipboard(
                CopyToClipboardData(
                    value: "sk-abc123XYZ"
                )
            )
            .render()
        )
        #expect(html.contains("type=\"hidden\""))
        #expect(html.contains("value=\"sk-abc123XYZ\""))
        #expect(html.contains("x-data=\"copyToClipboard()\""))
        #expect(html.contains("@click=\"copy($el.dataset.text)\""))
        #expect(html.contains("/js/raccoon-copy-to-clipboard.js"))
    }

    @Test("renders layout classes and copied label")
    func rendersLayoutClassesAndCopiedLabel() async throws {

        let horizontal = renderHTML(
            CopyToClipboard(
                CopyToClipboardData(value: "token", responseType: .inlineHorizontal)
            )
            .render()
        )
        let vertical = renderHTML(
            CopyToClipboard(
                CopyToClipboardData(value: "token", responseType: .inlineVertical)
            )
            .render()
        )
        #expect(horizontal.contains("flex-row items-center"))
        #expect(
            vertical.contains("flex-col items-center justify-center")
        )
        #expect(horizontal.contains("Copied"))
        #expect(horizontal.contains("aria-live=\"polite\""))
        #expect(horizontal.contains("Failed to copy"))
    }

    @Test("renders matomo tracking attributes when enabled")
    func rendersMatomoTrackingAttributes() async throws {

        let tracked = renderHTML(
            CopyToClipboard(
                CopyToClipboardData(
                    key: "secret-token",
                    value: "token123",
                    matomoStatus: .ACCEPTED
                )
            )
            .render()
        )
        #expect(tracked.contains("data-track-content"))
        #expect(tracked.contains("data-content-target=\"secret-token\""))

        let untracked = renderHTML(
            CopyToClipboard(
                CopyToClipboardData(value: "token123", matomoStatus: .DECLINED)
            )
            .render()
        )
        #expect(untracked.contains("data-track-content"))
    }

    // MARK: localization

    private func render(language: String = "en") -> String {
        I18n.render(language: language) {
            renderHTML(
                CopyToClipboard(CopyToClipboardData(value: "x")).render()
            )
        }
    }

    @Test("renders the English texts with markers for live switching")
    func englishWithMarkers() {
        let html = render()
        #expect(html.contains("aria-label=\"Copy text\""))
        #expect(html.contains("data-i18n-aria-label=\"copytoclipboard.copy\""))
        #expect(html.contains("title=\"Click to copy\""))
        #expect(html.contains("data-i18n-title=\"copytoclipboard.hint\""))
        #expect(html.contains("data-i18n=\"copytoclipboard.copied\""))
        #expect(html.contains(">Copied</span>"))
        #expect(html.contains("data-i18n=\"copytoclipboard.failed\""))
        #expect(html.contains(">Failed to copy</span>"))
    }

    @Test("renders all four texts in the page language")
    func germanTexts() {
        let html = render(language: "de")
        #expect(html.contains("aria-label=\"Text kopieren\""))
        #expect(html.contains("title=\"Zum Kopieren klicken\""))
        #expect(html.contains(">Kopiert</span>"))
        #expect(html.contains(">Kopieren fehlgeschlagen</span>"))
        #expect(!html.contains(">Copied<"))
    }

    @Test("renders toast configuration and suppresses inline label in toast mode")
    func rendersToastConfiguration() async throws {
        let html = renderHTML(
            CopyToClipboard(
                CopyToClipboardData(
                    value: "https://example.com/share",
                    responseType: .toast
                )
            )
            .render()
        )
        #expect(html.contains("x-data=\"copyToClipboard({ hasToast: true })\""))
        #expect(html.contains("data-has-toast=\"true\""))
        #expect(html.contains("data-toast-title=\"Copied\""))
        #expect(
            html.contains("data-toast-text=\"Copied to clipboard for copy-paste\"")
        )
        #expect(html.contains("data-i18n-toast-title=\"copytoclipboard.copied\""))
        #expect(html.contains("data-i18n-toast-text=\"copytoclipboard.toast\""))
        #expect(!html.contains(">Copied</span>"))
        #expect(!html.contains(">Failed to copy</span>"))
    }

    @Test("renders custom icons for initial and copied states")
    func rendersCustomIcons() async throws {
        let html = renderHTML(
            CopyToClipboard(
                CopyToClipboardData(
                    value: "https://example.com/share",
                    icon: .share,
                    copiedIcon: .check_lg,
                    responseType: .toast
                )
            )
            .render()
        )
        let sharePath = Svg.getPathsForIcon(.share).first!
        let checkPath = Svg.getPathsForIcon(.check_lg).first!
        #expect(html.contains(sharePath))
        #expect(html.contains(checkPath))
    }

    @Test("renders custom aria-label and tooltip")
    func rendersCustomLabelsAndTooltips() async throws {
        let html = renderHTML(
            CopyToClipboard(
                CopyToClipboardData(
                    ariaLabel: "Share article",
                    tooltip: "Click to share link",
                    value: "https://example.com",
                    icon: .share,
                    responseType: .toast
                )
            )
            .render()
        )
        #expect(html.contains("aria-label=\"Share article\""))
        #expect(html.contains("title=\"Click to share link\""))
    }

    @Test("renders custom feedback label for inline and toast modes")
    func rendersCustomFeedbackLabel() async throws {
        let inlineHtml = renderHTML(
            CopyToClipboard(
                CopyToClipboardData(
                    label: "Saved to buffer!",
                    value: "https://example.com",
                    responseType: .inlineHorizontal
                )
            )
            .render()
        )
        #expect(inlineHtml.contains(">Saved to buffer!</span>"))

        let toastHtml = renderHTML(
            CopyToClipboard(
                CopyToClipboardData(
                    label: "Article link copied to clipboard",
                    value: "https://example.com",
                    responseType: .toast
                )
            )
            .render()
        )
        #expect(toastHtml.contains("data-toast-title=\"Copied\""))
        #expect(
            toastHtml.contains("data-toast-text=\"Article link copied to clipboard\"")
        )
    }

    @Test("renders toast texts localized in page language")
    func rendersToastTextsInGerman() {
        let html = I18n.render(language: "de") {
            renderHTML(
                CopyToClipboard(
                    CopyToClipboardData(
                        value: "https://example.com",
                        responseType: .toast
                    )
                )
                .render()
            )
        }
        #expect(html.contains("data-toast-title=\"Kopiert\""))
        #expect(
            html.contains(
                "data-toast-text=\"Für Copy-Paste in die Zwischenablage kopiert\""
            )
        )
    }

    @Test("renders inlineHorizontal and inlineVertical responseTypes")
    func rendersInlineResponseTypes() async throws {
        let horizontal = renderHTML(
            CopyToClipboard(
                CopyToClipboardData(
                    value: "token",
                    responseType: .inlineHorizontal
                )
            )
            .render()
        )
        let vertical = renderHTML(
            CopyToClipboard(
                CopyToClipboardData(
                    value: "token",
                    responseType: .inlineVertical
                )
            )
            .render()
        )
        #expect(horizontal.contains("flex-row items-center"))
        #expect(horizontal.contains("pl-2"))
        #expect(vertical.contains("flex-col items-center justify-center"))
        #expect(vertical.contains("pt-2"))
    }
}
