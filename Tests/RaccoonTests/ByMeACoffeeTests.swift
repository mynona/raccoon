import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("ByMeACoffee")
struct ByMeACoffeeTests {
    @Test("renders buy me a coffee link")
    func rendersLink() async throws {
        let data = ByMeACoffeeData(
            dataSlug: "testuser",
            imageSrc: "https://example.com/image.png",
            imageHeight: 60,
            imageWidth: 210
        )
        let html = renderHTML(ByMeACoffee(data).render()).lowercased()
        #expect(html.contains("buy me a coffee"))
        #expect(html.contains("https://buymeacoffee.com/testuser"))
        #expect(html.contains("img"))
    }

    @Test("handles empty slug")
    func handlesEmptySlug() async throws {
        let data = ByMeACoffeeData(
            dataSlug: "",
            imageSrc: "https://example.com/image.png",
            imageHeight: 60,
            imageWidth: 210
        )
        let html = renderHTML(ByMeACoffee(data).render()).lowercased()
        #expect(html.contains("https://buymeacoffee.com/"))
    }

    @Test("handles missing image src")
    func handlesMissingImageSrc() async throws {
        let data = ByMeACoffeeData(
            dataSlug: "testuser",
            imageSrc: "",
            imageHeight: 60,
            imageWidth: 210
        )
        let html = renderHTML(ByMeACoffee(data).render()).lowercased()
        #expect(html.contains("img"))
    }

    @Test("handles zero image size")
    func handlesZeroImageSize() async throws {
        let data = ByMeACoffeeData(
            dataSlug: "testuser",
            imageSrc: "https://example.com/image.png",
            imageHeight: 0,
            imageWidth: 0
        )
        let html = renderHTML(ByMeACoffee(data).render()).lowercased()
        #expect(html.contains("img"))
    }

    @Test("renders matomo tracking and target attributes")
    func rendersTrackingAttributes() async throws {

        let data = ByMeACoffeeData(
            dataSlug: "creator",
            imageSrc: "/images/bmc-yellow.png",
            imageHeight: 60,
            imageWidth: 210,
            matomoStatus: .ACCEPTED
        )
        let html = renderHTML(ByMeACoffee(data).render())
        #expect(html.contains("data-track-content"))
        #expect(html.contains("data-content-name=\"feedback\""))
        #expect(html.contains("data-content-piece=\"buymeacoffee\""))
        #expect(
            html.contains(
                "data-content-target=\"https://buymeacoffee.com/creator\""
            )
        )
        #expect(html.contains("rel=\"noopener noreferrer\""))
        #expect(html.contains("flex-initial"))
    }

    @Test("omits matomo tracking when declined")
    func omitsTrackingWhenDeclined() async throws {

        let data = ByMeACoffeeData(
            dataSlug: "creator",
            imageSrc: "/images/bmc-yellow.png",
            imageHeight: 60,
            imageWidth: 210,
            matomoStatus: .DECLINED
        )
        let html = renderHTML(ByMeACoffee(data).render())
        #expect(!html.contains("data-track-content"))
        #expect(!html.contains("data-content-name"))
        #expect(!html.contains("data-content-piece"))
        #expect(!html.contains("data-content-target"))
        #expect(html.contains("rel=\"noopener noreferrer\""))
        #expect(html.contains("flex-initial"))
    }
}
