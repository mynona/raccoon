import HTML
import Raccoon
import SGML
import Testing

@testable import Raccoon

@Suite("FileList")
struct FileListTests {
    private func renderHTML(_ elements: [any SGML.Element]) -> String {
        elements.map { Document(root: $0).render(indent: 0) }.joined()
    }

    @Test("renders file list template markup")
    func testFileListRenders() {
        let ctx = FileListData(
            uploadId: "test-upload",
            hasRemoveAction: true
        )
        let html = renderHTML(FileList(ctx).render())
        #expect(html.contains("x-if=\"files.length > 0\""))
        #expect(
            html.contains("x-for=\"(file, index) in Array.from(files)\"")
        )
        #expect(html.contains("remove(index)"))
        #expect(html.contains(":id=\"'btnRemove-test-upload-' + index\""))
        #expect(html.contains(":id=\"'tooltip-test-upload-' + index\""))
        #expect(html.contains(":x-ref=\"'tooltip-test-upload-' + index\""))
        #expect(html.contains("svg"))
    }

    @Test("does not render remove action button when removeAction is false")
    func testFileListWithoutRemoveAction() {
        let ctx = FileListData(
            uploadId: "test-upload",
            hasRemoveAction: false
        )
        let html = renderHTML(FileList(ctx).render())
        #expect(!html.contains("remove(index)"))
        #expect(!html.contains("btnRemove"))
    }
}
