import Testing

@testable import Raccoon

@Suite("TemplateRepresentable")
struct TemplateRepresentableTests {

    @Test("renderString returns a complete html document")
    func rendersDocumentString() {
        let html = SkipLink().renderString(minify: true)
        #expect(html?.hasPrefix("<!doctype html>") == true)
    }

}
