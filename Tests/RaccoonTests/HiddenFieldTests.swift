import HTML
import Raccoon
import SGML
import Testing

@testable import Raccoon

@Suite("HiddenField")
struct HiddenFieldTests {
    @Test("renders hidden input")
    func testHiddenFieldRenders() {
        let ctx = HiddenFieldData(
            id: "hidden-key",
            value: "hidden-value",
            state: .enabled
        )
        let html = renderHTML(HiddenField(ctx).render())
        #expect(
            html.contains("type=\"hidden\"") && html.contains("hidden-key")
                && html.contains("hidden-value")
        )
    }

    @Test("renders disabled state")
    func testDisabledState() {
        let ctx = HiddenFieldData(
            id: "disabled-key",
            value: "disabled-value",
            state: .disabled
        )
        let html = renderHTML(HiddenField(ctx).render())
        // For disabled the class "hidden" is added
        #expect(html.contains("hidden") || html.contains("aria-disabled"))
    }

    @Test("renders with missing value")
    func testMissingValue() {
        let ctx = HiddenFieldData(
            id: "missing-value-key",
            value: nil,
            state: .enabled
        )
        let html = renderHTML(HiddenField(ctx).render())
        #expect(
            html.contains("type=\"hidden\"")
                && html.contains("missing-value-key")
        )
    }

    @Test("does not render hidden input for non enabled states")
    func testNonEnabledStatesDoNotRenderHiddenInput() {

        for state in [ComponentState.disabled, .hidden, .info] {
            let ctx = HiddenFieldData(
                id: "state-key",
                value: "state-value",
                state: state
            )
            let html = renderHTML(HiddenField(ctx).render())
            #expect(html.contains("class=\"hidden\""))
            #expect(!html.contains("type=\"hidden\""))
        }
    }

    @Test("default state in HiddenFieldData init is enabled")
    func testDefaultStateIsEnabled() {
        let data = HiddenFieldData(id: "token")
        #expect(data.state == .enabled)
    }

    private func renderHTML(_ elements: [any SGML.Element]) -> String {
        elements.map { Document(root: $0).render(indent: 0) }.joined()
    }
}
