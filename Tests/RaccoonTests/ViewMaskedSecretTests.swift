import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("ViewMaskedSecret")
struct ViewMaskedSecretTests {

    @Test("renders toggle visibility button")
    func rendersVisibilityToggleButton() async throws {

        let html = renderHTML(
            ViewMaskedSecret(ViewMaskedSecretData(secret: "super-secret-12345"))
                .render()
        )
        #expect(
            html.contains(
                ":aria-label=\"visible ? 'Hide secret' : 'Show secret'\""
            )
        )
        #expect(html.contains(":aria-pressed=\"visible\""))
    }

    @Test("renders copy button when copyEnabled is true")
    func rendersCopyButtonWhenEnabled() async throws {

        let html = renderHTML(
            ViewMaskedSecret(
                ViewMaskedSecretData(secret: "token", hasCopyToClipboard: true)
            )
            .render()
        )
        #expect(html.contains("copy") || html.contains("Copy"))
    }

    @Test("omits copy component when copyEnabled is false")
    func omitsCopyWhenDisabled() async throws {

        let withCopy = renderHTML(
            ViewMaskedSecret(
                ViewMaskedSecretData(secret: "tok", hasCopyToClipboard: true)
            )
            .render()
        )
        let withoutCopy = renderHTML(
            ViewMaskedSecret(
                ViewMaskedSecretData(secret: "tok", hasCopyToClipboard: false)
            )
            .render()
        )
        // Component with copy should be longer (has extra copy button)
        #expect(withCopy.count > withoutCopy.count)
    }

    @Test("renders alpine x-data container")
    func rendersAlpineContainer() async throws {

        let html = renderHTML(
            ViewMaskedSecret(ViewMaskedSecretData(secret: "my-key"))
                .render()
        )
        #expect(html.contains("x-data"))
    }

    @Test("renders Alpine payload with reveal settings")
    func rendersAlpinePayloadWithRevealSettings() async throws {

        let html = renderHTML(
            ViewMaskedSecret(
                ViewMaskedSecretData(
                    secret: "super-secret-token-12345",
                    revealCount: 4,
                    revealDuration: 3000,
                    hasCopyToClipboard: false
                )
            )
            .render()
        )
        #expect(
            html.contains(
                "maskedSecret('c3VwZXItc2VjcmV0LXRva2VuLTEyMzQ1', 4, 3000)"
            )
        )
        #expect(html.contains("x-text=\"visible ? secret : maskedSecret\""))
        #expect(html.contains("/js/view-masked.js"))
    }

    @Test("renders copy integration when enabled")
    func rendersCopyIntegrationWhenEnabled() async throws {

        let html = renderHTML(
            ViewMaskedSecret(
                ViewMaskedSecretData(
                    secret: "token",
                    hasCopyToClipboard: true
                )
            )
            .render()
        )
        #expect(html.contains("/js/copytoclipboard.js"))
        #expect(html.contains("aria-label=\"Copy text\""))
        #expect(html.contains("data-text=\"token\""))
    }

    @Test("renders escaped secret when secret contains HTML special characters")
    func rendersEscapedSecretForCopy() async throws {

        let html = renderHTML(
            ViewMaskedSecret(
                ViewMaskedSecretData(
                    secret: "key<123>&'\"",
                    hasCopyToClipboard: true
                )
            )
            .render()
        )
        #expect(html.contains("&lt;123&gt;&amp;&#39;&quot;"))
    }
}
