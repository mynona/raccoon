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

    @Test("renders progress thumb and tooltip when progress bar is enabled")
    func rendersProgressThumbAndTooltipWhenEnabled() async throws {

        let html = renderHTML(
            AudioPlayer(
                AudioPlayerData(
                    linkToTheAudioFile: "https://example.com/test.mp3",
                    hasProgressBar: true
                )
            )
            .render()
        )

        #expect(html.contains("x-ref=\"progressThumb\""))
        #expect(html.contains("x-ref=\"progressTooltip\""))
        #expect(html.contains("role=\"tooltip\""))
        #expect(html.contains("aria-hidden=\"true\""))
        #expect(html.contains("x-text=\"previewTimeFormatted\""))
        #expect(html.contains("x-show=\"metaDataLoaded && showThumb\""))
        #expect(html.contains("transform: translate(-50%, -50%)"))
    }

    @Test("renders pointer drag scrubbing attributes on scrubber button")
    func rendersPointerDragScrubbingAttributes() async throws {

        let html = renderHTML(
            AudioPlayer(
                AudioPlayerData(
                    linkToTheAudioFile: "https://example.com/test.mp3",
                    hasProgressBar: true
                )
            )
            .render()
        )

        #expect(html.contains("@pointerdown=\"startDrag($event)\""))
        #expect(html.contains("@pointermove=\"onDrag($event)\""))
        #expect(html.contains("@pointerup=\"endDrag($event)\""))
        #expect(html.contains("@pointercancel=\"endDrag($event)\""))
    }

    @Test("omits progress thumb and tooltip when progress bar is disabled")
    func omitsProgressThumbAndTooltipWhenDisabled() async throws {

        let html = renderHTML(
            AudioPlayer(
                AudioPlayerData(
                    linkToTheAudioFile: "https://example.com/test.mp3",
                    hasProgressBar: false
                )
            )
            .render()
        )

        #expect(!html.contains("x-ref=\"progressThumb\""))
        #expect(!html.contains("x-ref=\"progressTooltip\""))
    }

    // MARK: localization

    @Test(
        "labels follow the language; Alpine picks the play/pause label in the browser"
    )
    func localizedLabels() {
        let data = AudioPlayerData(
            linkToTheAudioFile: "https://example.com/a.mp3"
        )
        let german = I18n.render(language: "de") {
            renderHTML(AudioPlayer(data).render())
        }
        #expect(german.contains("aria-label=\"Audioplayer\""))
        #expect(
            german.contains(
                "aria-label=\"Fortschrittsregler der Audiowiedergabe\""
            )
        )
        #expect(german.contains("aria-label=\"Wiedergabe\""))
        #expect(
            german.contains(
                ":aria-label=\"playing ? (window.RaccoonI18n?RaccoonI18n.t('audioplayer.pause',null,'Pause'):'Pause') : "
            )
        )

        let titled = AudioPlayerData(
            title: "Episode 1",
            linkToTheAudioFile: "https://example.com/a.mp3"
        )
        let html = I18n.render(language: "fr") {
            renderHTML(AudioPlayer(titled).render())
        }
        #expect(html.contains("aria-label=\"Lecteur audio pour Episode 1\""))
    }

    @Test("the announcements of audioplayer.js land in the page dictionary")
    func scriptTextsAreRegistered() {
        let data = AudioPlayerData(
            linkToTheAudioFile: "https://example.com/a.mp3"
        )
        let html = I18n.render(language: "de", collectsUsedKeys: true) {
            _ = renderHTML(AudioPlayer(data).render())
            return renderHTML(I18n.scripts())
        }
        #expect(html.contains("\"paused\":\"Audio pausiert\""))
        #expect(
            html.contains(
                "\"skipped\":\"{{seconds}} Sekunden übersprungen. Wiedergabe läuft.\""
            )
        )
    }
}
