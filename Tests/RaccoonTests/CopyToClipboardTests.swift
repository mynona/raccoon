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
                CopyToClipboardData(value: "copy-me", orientation: .horizontal)
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
                    value: "my-api-key-123",
                    orientation: .horizontal
                )
            )
            .render()
        )
        #expect(html.contains("my-api-key-123"))
    }

    @Test("renders vertical orientation variant")
    func rendersVerticalVariant() async throws {

        let html = renderHTML(
            CopyToClipboard(
                CopyToClipboardData(value: "token", orientation: .vertical)
            )
            .render()
        )
        #expect(!html.isEmpty)
    }

    @Test("renders with empty value")
    func rendersWithEmptyValue() async throws {

        let html = renderHTML(
            CopyToClipboard(
                CopyToClipboardData(value: "", orientation: .horizontal)
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
                CopyToClipboardData(value: longValue, orientation: .horizontal)
            )
            .render()
        )
        #expect(html.contains(longValue))
    }

    @Test("renders visible focus indicator for accessibility")
    func rendersVisibleFocusIndicator() async throws {
        let html = renderHTML(
            CopyToClipboard(
                CopyToClipboardData(value: "focus", orientation: .horizontal)
            )
            .render()
        )
        #expect(html.contains("focus-within:ring-2"))
    }

    @Test("renders correctly after rapid clicking simulation")
    func rendersAfterRapidClicking() async throws {
        let html = renderHTML(
            CopyToClipboard(
                CopyToClipboardData(value: "rapid", orientation: .horizontal)
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
                    value: "sk-abc123XYZ",
                    orientation: .horizontal
                )
            )
            .render()
        )
        #expect(html.contains("type=\"hidden\""))
        #expect(html.contains("value=\"sk-abc123XYZ\""))
        #expect(html.contains("x-data=\"copyToClipboard()\""))
        #expect(html.contains("@click=\"copy($el.dataset.text)\""))
        #expect(html.contains("/js/copytoclipboard.js"))
    }

    @Test("renders orientation classes and copied label")
    func rendersOrientationClassesAndCopiedLabel() async throws {

        let horizontal = renderHTML(
            CopyToClipboard(
                CopyToClipboardData(value: "token", orientation: .horizontal)
            )
            .render()
        )
        let vertical = renderHTML(
            CopyToClipboard(
                CopyToClipboardData(value: "token", orientation: .vertical)
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
        #expect(!untracked.contains("data-track-content"))
    }
}
