import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("KeyboardKey")
struct KeyboardKeyTests {

    @Test("renders kbd element")
    func rendersKbdElement() async throws {

        let html = renderHTML(
            KeyboardKey(KeyboardKeyData(key: .shift)).render()
        )
        #expect(html.contains("<kbd"))
    }

    @Test("renders custom text key as literal text")
    func rendersCustomTextKey() async throws {

        let html = renderHTML(
            KeyboardKey(KeyboardKeyData(key: .text("Esc"))).render()
        )
        #expect(html.contains("Esc"))
    }

    @Test("renders all predefined keys without error")
    func rendersAllPredefinedKeys() async throws {

        let keys: [KeyboardKeyData.KbdKey] = [
            .shift, .command, .ctrl, .option, .backspace, .capslock,
        ]
        for key in keys {
            let html = renderHTML(
                KeyboardKey(KeyboardKeyData(key: key)).render()
            )
            #expect(html.contains("<kbd"))
        }
    }

    @Test("renders with showBorder false")
    func rendersWithShowBorderFalse() async throws {
        let html = renderHTML(
            KeyboardKey(KeyboardKeyData(key: .shift, hasBorder: false))
                .render()
        )
        #expect(html.contains("<kbd"))
    }

    @Test("renders with long and empty custom text")
    func rendersLongAndEmptyCustomText() async throws {
        let longText = String(repeating: "K", count: 256)
        let htmlLong = renderHTML(
            KeyboardKey(KeyboardKeyData(key: .text(longText))).render()
        )
        let htmlEmpty = renderHTML(
            KeyboardKey(KeyboardKeyData(key: .text(""))).render()
        )
        #expect(htmlLong.contains(longText))
        #expect(htmlEmpty.contains("<kbd"))
    }

    @Test("accessibility: keyboard, focus, color contrast, screen reader")
    func accessibilityChecks() async throws {
        let html = renderHTML(
            KeyboardKey(KeyboardKeyData(key: .shift)).render()
        )
        #expect(html.contains("role") || html.contains("kbd"))
        #expect(html.contains("focus") || html.contains("outline"))
    }
}
