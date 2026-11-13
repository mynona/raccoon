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

    @Test(
        "validates that form data is sent with post method, deletion redirect action, and csrf token"
    )
    func validatesFormDataSubmission() async throws {
        let data = DeleteModalData(
            deletionRedirect: "/items/123/delete",
            csrfToken: "csrf-token-abc"
        )
        let html = renderHTML(DeleteModal(data).render())

        // 1. Form tag configuration: method, action, novalidate
        #expect(html.contains("<form"))
        #expect(html.contains("method=\"post\""))
        #expect(html.contains("action=\"/items/123/delete\""))
        #expect(html.contains("novalidate"))

        // 2. Hidden field for CSRF token
        #expect(html.contains("type=\"hidden\""))
        #expect(html.contains("name=\"X-CSRF-Token\""))
        #expect(html.contains("value=\"csrf-token-abc\""))

        // 3. Submit button inside form
        #expect(html.contains("type=\"submit\""))
        #expect(html.contains("deletemodal.yes"))

        // 4. Cancel button does not submit form data
        #expect(html.contains("type=\"button\""))
        #expect(html.contains("deletemodal.cancel"))
        #expect(html.contains("open = false"))
    }

    @Test("validates form data when csrf token is omitted")
    func validatesFormDataWithoutCsrf() async throws {
        let data = DeleteModalData(
            deletionRedirect: "/items/456/delete",
            csrfToken: nil
        )
        let html = renderHTML(DeleteModal(data).render())

        #expect(html.contains("<form"))
        #expect(html.contains("method=\"post\""))
        #expect(html.contains("action=\"/items/456/delete\""))
        #expect(html.contains("novalidate"))
        #expect(!html.contains("name=\"X-CSRF-Token\""))
        #expect(html.contains("type=\"submit\""))
        #expect(html.contains("deletemodal.yes"))
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

    @Test("renders modal centered horizontally and vertically on screen")
    func rendersModalCentered() async throws {
        let html = renderHTML(
            DeleteModal(
                DeleteModalData(
                    deletionRedirect: "/items/1/delete",
                    csrfToken: nil
                )
            )
            .render()
        )
        #expect(html.contains("fixed inset-0 z-50 overflow-y-auto"))
        #expect(html.contains("fixed inset-0 z-10 flex min-h-screen items-center justify-center p-4 overflow-y-auto"))
    }

    // MARK: localization

    @Test("all texts are built in and translated; the warning is one sentence")
    func localizedTexts() {
        let data = DeleteModalData(deletionRedirect: "/a", csrfToken: nil)
        let english = renderHTML(DeleteModal(data).render())
        for key in ["close", "title", "confirm", "warning", "yes", "cancel"] {
            #expect(english.contains("deletemodal.\(key)"), "\(key)")
        }
        #expect(
            english.contains(
                ">This action cannot be undone and all data will be irrevocably deleted.</p>"
            )
        )

        let german = I18n.render(language: "de") {
            renderHTML(DeleteModal(data).render())
        }
        #expect(
            german.contains(
                ">Soll dieser Eintrag wirklich gelöscht werden?</p>"
            )
        )
        #expect(german.contains("Ja, löschen"))
        #expect(german.contains("Abbrechen"))
        #expect(german.contains("aria-label=\"Löschdialog schließen\""))
    }
}
