import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("Spacer")
struct SpacerTests {

    @Test("renders a div element")
    func rendersDivElement() async throws {

        let html = renderHTML(Spacer(SpacerData(space: 4)).render())
        #expect(html.contains("<div"))
    }

    @Test("renders all space values 1 through 5")
    func rendersAllSpaceValues() async throws {

        for n: UInt in 1...5 {
            let html = renderHTML(Spacer(SpacerData(space: n)).render())
            #expect(!html.isEmpty)
        }
    }

    @Test("verifies exact tailwind padding class mapping")
    func verifiesPaddingClassMapping() async throws {

        let s1 = renderHTML(Spacer(SpacerData(space: 1)).render())
        #expect(s1.contains("class=\"pb-1 md:pb-2\""))

        let s9 = renderHTML(Spacer(SpacerData(space: 9)).render())
        #expect(s9.contains("class=\"pb-9 md:pb-10\""))

        let sDefault = renderHTML(Spacer(SpacerData(space: 99)).render())
        #expect(sDefault.contains("class=\"pb-10 md:pb-11\""))
    }
}
