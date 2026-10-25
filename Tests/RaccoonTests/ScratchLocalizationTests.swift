import HTML
import SGML
import Testing

@testable import Raccoon

@Suite("ScratchLocalization")
struct ScratchLocalizationTests {
    @Test("scratch")
    func scratch() {
        let t = LocalizedText("pagination.page", "Page {{number}}", variables: ["number": "3"])
        let span = Span(t.english).localized(t)
        let btn = Button { Span("x") }
            .localized(.ariaLabel, LocalizedText("a.b", "Say \"hi\""))
            .localized(.title, LocalizedText("a.c", "Click"))
        let script = LocalizedStrings(["de": ["x": "<b>\"q\"</b></script>"]]).scriptElement(namespace: "acc")
        for e in [span as any Element, btn, script] {
            print("SCRATCH:", Document(root: e).render(indent: 0))
        }
    }
}
