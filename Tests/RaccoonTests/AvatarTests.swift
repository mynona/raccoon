import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("Avatar")
struct AvatarTests {

    @Test("renders initials from first and last name")
    func rendersInitialsFromBothNames() async throws {

        let html = renderHTML(
            Avatar(AvatarData(firstName: "Alice", lastName: "Brown"))
                .render()
        )
        #expect(html.contains("AB"))
    }

    @Test("renders initial from first name only")
    func rendersInitialFromFirstNameOnly() async throws {

        let html = renderHTML(
            Avatar(AvatarData(firstName: "Alice"))
                .render()
        )
        #expect(html.contains("A"))
    }

    @Test("renders picture img when URL is provided")
    func rendersPictureWhenURLProvided() async throws {

        let html = renderHTML(
            Avatar(AvatarData(picture: "https://example.com/avatar.jpg"))
                .render()
        )
        #expect(html.contains("<img"))
        #expect(html.contains("https://example.com/avatar.jpg"))
    }

    @Test("renders fallback when no name or picture")
    func rendersFallbackForAnonymous() async throws {

        let html = renderHTML(
            Avatar(AvatarData())
                .render()
        )
        #expect(!html.isEmpty)
    }

    @Test("renders accessible label for initials avatar")
    func rendersAccessibleLabelForInitialsAvatar() async throws {

        let html = renderHTML(
            Avatar(AvatarData(firstName: "Alice", lastName: "Brown"))
                .render()
        )
        #expect(html.contains("aria-label=\"Alice Brown\""))
        #expect(html.contains("role=\"img\""))
    }

    @Test("renders accessible alt for picture avatar")
    func rendersAccessibleLabelForPictureAvatar() async throws {

        let html = renderHTML(
            Avatar(
                AvatarData(
                    firstName: "Alice",
                    lastName: "Brown",
                    picture: "https://example.com/avatar.jpg"
                )
            )
            .render()
        )
        #expect(html.contains("alt=\"Alice Brown\""))
    }

    @Test("renders fallback alt for picture avatar without name")
    func rendersFallbackAltForPictureAvatarWithoutName() async throws {

        let html = renderHTML(
            Avatar(
                AvatarData(
                    picture: "https://example.com/avatar.jpg"
                )
            )
            .render()
        )
        #expect(html.contains("alt=\"Avatar\""))
    }

    @Test("renders generic avatar accessibility label and role")
    func rendersGenericAvatarAccessibilityLabel() async throws {

        let html = renderHTML(Avatar(AvatarData()).render())
        #expect(html.contains("Generic avatar image"))
        #expect(html.contains("role=\"img\""))
    }

    @Test("renders different component sizes")
    func rendersDifferentComponentSizes() async throws {

        let small = renderHTML(
            Avatar(AvatarData(firstName: "A", size: .sm)).render()
        )
        #expect(small.contains("size-8"))
        #expect(small.contains(AvatarStyles.textSizeSmall))

        let large = renderHTML(
            Avatar(AvatarData(firstName: "A", size: .xl)).render()
        )
        #expect(large.contains("size-12"))
        #expect(large.contains(AvatarStyles.textSizeLarge))
    }

    @Test("renders single initial when only lastName is given")
    func rendersInitialFromLastNameOnly() async throws {

        let html = renderHTML(
            Avatar(AvatarData(lastName: "Soller"))
                .render()
        )
        #expect(html.contains("S"))
        #expect(html.contains("aria-label=\"Soller\""))
    }

    @Test("handles lowercase names and trims correctly")
    func handlesLowercaseNames() async throws {

        let html = renderHTML(
            Avatar(AvatarData(firstName: "andreas", lastName: "soller"))
                .render()
        )
        #expect(html.contains("AS"))
        #expect(html.contains("aria-label=\"Andreas Soller\""))
    }
}
