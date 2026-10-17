import HTML
import Raccoon
import SGML
import Testing

@testable import Raccoon

@Suite("MultipleFileUpload")
struct MultipleFileUploadTests {
    private func renderHTML(_ elements: [any SGML.Element]) -> String {
        elements.map { Document(root: $0).render(indent: 0) }.joined()
    }

    @Test("renders multiple file upload component with multiple attribute")
    func testMultipleFileUploadRenders() {
        let ctx = MultipleFileUploadData(id: "multi-upload")
        let html = renderHTML(MultipleFileUpload(ctx).render())
        #expect(html.contains("type=\"file\""))
        #expect(html.contains("multiple"))
        #expect(html.contains("name=\"multi-upload[]\""))
        #expect(html.contains("x-data=\"multipleFileDnD('multi-upload')\""))
        #expect(html.contains("remove(index)"))
        #expect(html.contains(":id=\"'btnRemove-multi-upload-' + index\""))
        #expect(html.contains(":id=\"'tooltip-multi-upload-' + index\""))
    }

    @Test("renders with error messages")
    func testErrorMessages() {
        let ctx = MultipleFileUploadData(
            id: "multi-err",
            errorMessages: ErrorMessageData(
                errorMessages: ["Files too large"]
            )
        )
        let html = renderHTML(MultipleFileUpload(ctx).render())
        #expect(html.contains("Files too large"))
        #expect(html.contains("hasServerError: true"))
    }

    @Test("renders label when provided")
    func testLabelRenders() {
        let ctx = MultipleFileUploadData(
            id: "multi-doc",
            label: LabelData(id: "multi-doc", title: "Attach Documents")
        )
        let html = renderHTML(MultipleFileUpload(ctx).render())
        #expect(html.contains("Attach Documents"))
    }
}
