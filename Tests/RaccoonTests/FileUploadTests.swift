import HTML
import Raccoon
import SGML
import Testing

@testable import Raccoon

@Suite("FileUpload")
struct FileUploadTests {
    private func renderHTML(_ elements: [any SGML.Element]) -> String {
        elements.map { Document(root: $0).render(indent: 0) }.joined()
    }

    @Test("renders file upload input")
    func testFileUploadRenders() {
        let ctx = SingleFileUploadData(id: "file-upload")
        let html = renderHTML(SingleFileUpload(ctx).render())
        #expect(html.contains("type=\"file\""))
        #expect(html.contains("/js/file-upload.js"))
        #expect(html.contains("x-data=\"singleFileDnD('file-upload')\""))
    }

    // The current FileUploadData does not support multiple, error, or showRemove directly.
    // Test error state via errorMessages, and basic rendering for multiple/removal is not supported in context.
    @Test("renders error state via errorMessages")
    func testErrorState() {
        let ctx = SingleFileUploadData(
            id: "err",
            errorMessages: ErrorMessageData(
                errorMessages: ["Upload failed"]
            )
        )
        let html = renderHTML(SingleFileUpload(ctx).render())
        #expect(html.contains("Upload failed"))
    }

    @Test("accessibility: keyboard navigation")
    func testKeyboardNavigation() {
        let ctx = SingleFileUploadData(id: "kbd")
        let html = renderHTML(SingleFileUpload(ctx).render())
        #expect(html.contains("tabindex") || html.contains("aria-"))
    }

    @Test("renders label and browse message")
    func rendersLabelAndBrowseMessage() {
        let ctx = SingleFileUploadData(
            id: "upload",
            label: LabelData(id: "upload", title: "Upload file")
        )
        let html = renderHTML(SingleFileUpload(ctx).render())

        #expect(html.contains("Upload file"))
        #expect(html.contains("Browse or drag and drop here."))
        #expect(html.contains("upload"))
    }

    @Test("renders server error state in Alpine config")
    func rendersServerErrorStateInAlpineConfig() {
        let ctx = SingleFileUploadData(
            id: "err",
            errorMessages: ErrorMessageData(
                errorMessages: ["Upload failed"]
            )
        )
        let html = renderHTML(SingleFileUpload(ctx).render())

        #expect(html.contains("hasServerError: true"))
        #expect(html.contains("Upload failed"))
    }

    @Test("renders remove action markup for selected files")
    func rendersRemoveActionMarkup() {
        let ctx = SingleFileUploadData(id: "upload")
        let html = renderHTML(SingleFileUpload(ctx).render())

        #expect(html.contains("remove(index)"))
        #expect(html.contains("Remove file"))
        #expect(html.contains("x-if=\"files.length > 0\""))
    }

    @Test("renders dragover and drop handlers on file input")
    func rendersDragAndDropAttributes() {
        let ctx = SingleFileUploadData(id: "custom-file-id")
        let html = renderHTML(SingleFileUpload(ctx).render())

        #expect(html.contains("@dragover=\"isDragging = true\""))
        #expect(html.contains("@dragleave=\"isDragging = false\""))
        #expect(html.contains("@drop=\"isDragging = false\""))
        #expect(
            html.contains(
                ":class=\"{ 'border-blue-400 border-4 border-inset': isDragging, 'ring-2 ring-focusring': isFocused }\""
            )
        )
        #expect(html.contains("id=\"custom-file-id\""))
        #expect(html.contains("name=\"custom-file-id\""))
    }
}
