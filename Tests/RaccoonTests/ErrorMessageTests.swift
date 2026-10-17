import HTML
import Raccoon
import SGML
import Testing

@testable import Raccoon

@Suite("ErrorMessage")
struct ErrorMessageTests {
    private func renderHTML(_ elements: [any SGML.Element]) -> String {
        elements.map { Document(root: $0).render(indent: 0) }.joined()
    }

    @Test("renders error messages")
    func testErrorMessagesRender() {
        let ctx = ErrorMessageData(
            id: "err",
            errorMessages: ["Error 1", "Error 2"],
            hasIcon: true
        )
        let html = renderHTML(ErrorMessage(ctx).render())
        #expect(html.contains("Error 1") && html.contains("Error 2"))
    }

    @Test("renders with icon toggle and no icon")
    func testIconToggleAndNoIcon() {
        let ctxIcon = ErrorMessageData(
            id: "icon",
            errorMessages: ["Icon error"],
            hasIcon: true
        )
        let ctxNoIcon = ErrorMessageData(
            id: "noicon",
            errorMessages: ["No icon error"],
            hasIcon: false
        )
        let htmlIcon = renderHTML(ErrorMessage(ctxIcon).render())
        let htmlNoIcon = renderHTML(ErrorMessage(ctxNoIcon).render())
        #expect(htmlIcon.contains("icon") || htmlIcon.contains("svg"))
        #expect(htmlNoIcon.contains("No icon error"))
    }

    @Test("renders with empty and long messages")
    func testEmptyAndLongMessages() {
        let ctxEmpty = ErrorMessageData(
            id: "empty",
            errorMessages: [""]
        )
        let longMsg = String(repeating: "E", count: 256)
        let ctxLong = ErrorMessageData(
            id: "long",
            errorMessages: [longMsg]
        )
        let htmlEmpty = renderHTML(ErrorMessage(ctxEmpty).render())
        let htmlLong = renderHTML(ErrorMessage(ctxLong).render())
        #expect(htmlEmpty.contains("<div"))
        #expect(htmlLong.contains(longMsg))
    }

    @Test("accessibility: ARIA live region")
    func testAriaLiveRegion() {
        let ctx = ErrorMessageData(
            id: "aria",
            errorMessages: ["Live error"]
        )
        let html = renderHTML(ErrorMessage(ctx).render())
        #expect(
            html.contains("aria-live") || html.contains("role=\"alert\"")
        )
    }

    @Test("renders generated ids for each error message")
    func testGeneratedIdsForEachErrorMessage() {
        let ctx = ErrorMessageData(
            id: "err2",
            errorMessages: ["Error 1", "Error 2"],
            hasIcon: true
        )
        let html = renderHTML(ErrorMessage(ctx).render())
        #expect(html.contains("id=\"err2-error-0\""))
        #expect(html.contains("id=\"err2-error-1\""))
        #expect(html.contains("role=\"alert\""))
    }

    @Test("omits icon markup when icon flag is false")
    func testOmitsIconMarkupWhenIconFlagIsFalse() {
        let ctx = ErrorMessageData(
            id: "err3",
            errorMessages: ["Error 3"],
            hasIcon: false
        )
        let html = renderHTML(ErrorMessage(ctx).render())
        #expect(html.contains("Error 3"))
        #expect(!html.contains("aria-hidden=\"true\""))
    }

    @Test("renders empty list when errorMessages is nil or empty")
    func testNilOrEmptyErrorMessages() {
        let ctxNil = ErrorMessageData(
            id: "nil-err",
            errorMessages: nil
        )
        let ctxEmpty = ErrorMessageData(
            id: "empty-err",
            errorMessages: []
        )
        let htmlNil = renderHTML(ErrorMessage(ctxNil).render())
        let htmlEmpty = renderHTML(ErrorMessage(ctxEmpty).render())
        #expect(htmlNil.contains("<!-- Error Message -->"))
        #expect(!htmlNil.contains("role=\"alert\""))
        #expect(!htmlEmpty.contains("role=\"alert\""))
    }
}
