import HTML
import SGML
import Testing

@testable import Raccoon

/// Renders a list of elements to a minified HTML string (no doctype).
private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("Notification")
struct NotificationTests {
    @Test("applies warning border class for .warning type")
    func appliesWarningClass() async throws {
        let html = renderHTML(
            Notification(
                NotificationData(title: "Warn", text: nil, type: .warning)
            )
            .render()
        )
        #expect(html.contains(NotificationStyles.borderWarning))
    }

    @Test("applies info border class for .info type")
    func appliesInfoClass() async throws {
        let html = renderHTML(
            Notification(
                NotificationData(title: "Info", text: nil, type: .info)
            )
            .render()
        )
        #expect(html.contains(NotificationStyles.borderInfo))
    }

    @Test("renders markdown in text")
    func rendersMarkdownInText() async throws {
        let html = renderHTML(
            Notification(
                NotificationData(
                    title: "Title",
                    text: "Some **detail** here.",
                    type: .info
                )
            )
            .render()
        )
        #expect(html.contains("<strong>detail</strong>"))
    }

    @Test("renders icon with role img for accessibility")
    func rendersIconWithRoleImg() async throws {
        let html = renderHTML(
            Notification(
                NotificationData(title: "Title", text: nil, type: .info)
            )
            .render()
        )
        #expect(html.contains("role=\"presentation\""))
    }

    @Test("renders title")
    func rendersTitleInParagraph() async throws {

        let html = renderHTML(
            Notification(
                NotificationData(title: "Hello", text: nil, type: .info)
            )
            .render()
        )
        #expect(
            html.contains("<p class=\"\(NotificationStyles.titleFont)\">Hello</p>")
        )
    }

    @Test("renders optional text when provided")
    func rendersOptionalText() async throws {

        let html = renderHTML(
            Notification(
                NotificationData(
                    title: "Title",
                    text: "Some detail",
                    type: .info
                )
            )
            .render()
        )
        #expect(html.contains("Some detail"))
    }

    @Test("omits text paragraph when text is nil")
    func omitsTextParagraphWhenNil() async throws {

        let html = renderHTML(
            Notification(
                NotificationData(title: "Title", text: nil, type: .info)
            )
            .render()
        )
        // Only the title <p class="font-semibold">, no second <p> for body text
        #expect(html.contains(NotificationStyles.titleFont))
        #expect(!html.contains("pt-2"))
    }

    @Test("applies error border class for .error type")
    func appliesErrorClass() async throws {

        let html = renderHTML(
            Notification(
                NotificationData(title: "Oops", text: nil, type: .error)
            )
            .render()
        )
        #expect(html.contains(NotificationStyles.borderError))
    }

    @Test("applies success border class for .success type")
    func appliesSuccessClass() async throws {

        let html = renderHTML(
            Notification(
                NotificationData(title: "Done", text: nil, type: .success)
            )
            .render()
        )
        #expect(html.contains(NotificationStyles.borderSuccess))
    }
}
