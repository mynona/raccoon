import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

/// Real `id` attributes only — skips Alpine's `:id` / `x-id` bindings, which repeat by design.
private func renderedIds(in html: String) -> [String] {
    var ids: [String] = []
    var search = html.startIndex..<html.endIndex
    while let match = html.range(of: "id=\"", range: search) {
        let precededBySpace =
            match.lowerBound == html.startIndex
            || html[html.index(before: match.lowerBound)] == " "
        if precededBySpace,
            let end = html[match.upperBound...].firstIndex(of: "\"")
        {
            ids.append(String(html[match.upperBound..<end]))
        }
        search = match.upperBound..<html.endIndex
    }
    return ids
}

@Suite("DeleteModal")
struct DeleteModalTests {

    @Test("two modals on one page render no duplicate ids")
    func twoModalsDoNotShareIds() async throws {

        let html =
            renderHTML(
                DeleteModal(
                    DeleteModalData(deletionRedirect: "/a", csrfToken: nil)
                )
                .render()
            )
            + renderHTML(
                DeleteModal(
                    DeleteModalData(deletionRedirect: "/b", csrfToken: nil)
                )
                .render()
            )

        let ids = renderedIds(in: html)

        #expect(!ids.contains("buttonDelete"))
        #expect(!ids.contains("buttonCancel"))
        #expect(!ids.contains("close-1"))
        #expect(!ids.contains("X-CSRF-Token"))
        #expect(Set(ids).count == ids.count)
    }

    @Test("renders delete heading")
    func rendersDeleteHeading() async throws {

        let html = renderHTML(
            DeleteModal(
                DeleteModalData(
                    deletionRedirect: "/items/1/delete",
                    csrfToken: "token-abc"
                )
            )
            .render()
        )
        #expect(html.contains("<h2") && html.contains(">Delete<"))
    }

    @Test("renders form with deletion redirect action")
    func rendersFormWithAction() async throws {

        let html = renderHTML(
            DeleteModal(
                DeleteModalData(
                    deletionRedirect: "/records/42/delete",
                    csrfToken: "tok"
                )
            )
            .render()
        )
        #expect(html.contains("/records/42/delete"))
    }

    @Test("renders csrf token in hidden field")
    func rendersCsrfToken() async throws {

        let html = renderHTML(
            DeleteModal(
                DeleteModalData(
                    deletionRedirect: "/delete",
                    csrfToken: "my-secret-csrf"
                )
            )
            .render()
        )
        #expect(html.contains("my-secret-csrf"))
    }

    @Test("renders cannot-be-undone warning")
    func rendersCannotBeUndoneWarning() async throws {

        let html = renderHTML(
            DeleteModal(
                DeleteModalData(deletionRedirect: "/delete", csrfToken: "tok")
            )
            .render()
        )
        #expect(html.contains("cannot"))
    }

    @Test("renders modal accessibility attributes and escape handler")
    func rendersModalAccessibilityAttributes() async throws {

        let html = renderHTML(
            DeleteModal(
                DeleteModalData(
                    deletionRedirect: "/items/99/delete",
                    csrfToken: "csrf-xyz"
                )
            )
            .render()
        )
        #expect(html.contains("role=\"dialog\""))
        #expect(html.contains("aria-modal=\"true\""))
        #expect(html.contains("x-trap.noscroll.inert=\"open\""))
        #expect(
            html.contains("x-on:keydown.escape.prevent.stop=\"open = false\"")
        )
        #expect(html.contains("X-CSRF-Token"))
        #expect(html.contains("/js/modal.js"))
    }
}
