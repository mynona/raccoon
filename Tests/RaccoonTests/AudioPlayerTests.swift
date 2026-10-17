import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("AudioPlayer")
struct AudioPlayerTests {

    @Test("renders audio source URL")
    func rendersSourceURL() async throws {

        let html = renderHTML(
            AudioPlayer(
                AudioPlayerData(
                    linkToTheAudioFile: "https://example.com/audio.mp3"
                )
            )
            .render()
        )
        #expect(html.contains("https://example.com/audio.mp3"))
    }

    @Test("renders audio element")
    func rendersAudioElement() async throws {

        let html = renderHTML(
            AudioPlayer(
                AudioPlayerData(
                    linkToTheAudioFile: "https://example.com/episode.mp3"
                )
            )
            .render()
        )
        #expect(html.contains("<audio"))
        #expect(html.contains("<source"))
    }

    @Test("renders title when provided")
    func rendersTitleWhenProvided() async throws {

        let html = renderHTML(
            AudioPlayer(
                AudioPlayerData(
                    title: "Episode 42",
                    linkToTheAudioFile: "https://example.com/ep42.mp3"
                )
            )
            .render()
        )
        #expect(html.contains("Episode 42"))
    }

    @Test("omits title when nil")
    func omitsTitleWhenNil() async throws {

        let html = renderHTML(
            AudioPlayer(
                AudioPlayerData(
                    linkToTheAudioFile: "https://example.com/ep.mp3"
                )
            )
            .render()
        )
        #expect(!html.contains("Episode 42"))
    }

    @Test("renders disclaimer when provided")
    func rendersDisclaimerWhenProvided() async throws {

        let html = renderHTML(
            AudioPlayer(
                AudioPlayerData(
                    title: "Episode 42",
                    disclaimer: "Disclaimer information",
                    linkToTheAudioFile: "https://example.com/ep42.mp3"
                )
            )
            .render()
        )

        #expect(html.contains("Disclaimer information"))
    }

    @Test("renders audio player aria label from title")
    func rendersAudioPlayerAriaLabelFromTitle() async throws {

        let html = renderHTML(
            AudioPlayer(
                AudioPlayerData(
                    title: "Episode 42",
                    linkToTheAudioFile: "https://example.com/ep42.mp3"
                )
            )
            .render()
        )

        #expect(html.contains("aria-label=\"Audio Player for Episode 42\""))
    }

    @Test("renders default audio player aria label without title")
    func rendersDefaultAudioPlayerAriaLabelWithoutTitle() async throws {

        let html = renderHTML(
            AudioPlayer(
                AudioPlayerData(
                    linkToTheAudioFile: "https://example.com/ep.mp3"
                )
            )
            .render()
        )

        #expect(html.contains("aria-label=\"Audio Player\""))
    }

    @Test("renders progress bar and scrubber when enabled")
    func rendersProgressBarWhenEnabled() async throws {

        let html = renderHTML(
            AudioPlayer(
                AudioPlayerData(
                    linkToTheAudioFile: "https://example.com/audio.mp3",
                    hasProgressBar: true
                )
            )
            .render()
        )

        #expect(html.contains("x-ref=\"scrubber\""))
        #expect(html.contains("x-ref=\"progress\""))
        #expect(html.contains("Audio progress slider"))
    }

    @Test("renders hidden scrubber refs when progress bar is disabled")
    func rendersHiddenScrubberRefsWhenProgressBarDisabled() async throws {

        let html = renderHTML(
            AudioPlayer(
                AudioPlayerData(
                    linkToTheAudioFile: "https://example.com/audio.mp3",
                    hasProgressBar: false
                )
            )
            .render()
        )

        #expect(html.contains("x-ref=\"scrubber\""))
        #expect(html.contains("x-ref=\"progress\""))
        #expect(html.contains("class=\"hidden\""))
        #expect(!html.contains("Audio progress slider"))
    }

    @Test("renders matomo tracking attributes on play button")
    func rendersMatomoTrackingAttributes() async throws {

        let html = renderHTML(
            AudioPlayer(
                AudioPlayerData(
                    title: "Test Track",
                    linkToTheAudioFile: "https://example.com/test.mp3",
                    matomoStatus: .ACCEPTED
                )
            )
            .render()
        )

        #expect(html.contains("data-track-content"))
        #expect(html.contains("data-content-name=\"content.audioplayer\""))
        #expect(
            html.contains(
                "data-content-target=\"https://example.com/test.mp3\""
            )
        )
    }

    @Test("renders scrubber keyboard accessibility attributes")
    func rendersKeyboardAccessibilityAttributes() async throws {

        let html = renderHTML(
            AudioPlayer(
                AudioPlayerData(
                    linkToTheAudioFile: "https://example.com/test.mp3",
                    hasProgressBar: true
                )
            )
            .render()
        )

        #expect(html.contains("role=\"slider\""))
        #expect(html.contains("@keydown.arrow-left=\"skip(-5)\""))
        #expect(html.contains("@keydown.arrow-right=\"skip(5)\""))
        #expect(html.contains("Use left/right arrows to skip"))
    }
}
