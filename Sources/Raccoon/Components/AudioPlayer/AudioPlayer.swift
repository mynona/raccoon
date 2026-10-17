import DOM
import HTML
import SGML
import SVG
import WebBuilders

public struct AudioPlayer: TemplateRepresentable {
    let data: AudioPlayerData
    typealias styles = AudioPlayerStyles
    typealias buttonStyles = ActionButtonStyles

    public init(_ data: AudioPlayerData) {
        self.data = data
    }

    /// Derives the audio MIME type from the file extension, defaulting to MP3 for unknown/missing extensions.
    func audioMimeType(for path: String) -> String {
        let pathWithoutQuery =
            path.split(separator: "?", maxSplits: 1).first.map(String.init)
            ?? path
        let fileExtension =
            pathWithoutQuery.split(separator: ".").last.map(String.init)?
            .lowercased() ?? ""
        switch fileExtension {
        case "mp3": return "audio/mpeg"
        case "ogg", "oga": return "audio/ogg"
        case "wav": return "audio/wav"
        case "m4a": return "audio/mp4"
        case "aac": return "audio/aac"
        case "flac": return "audio/flac"
        case "opus": return "audio/opus"
        case "weba": return "audio/webm"
        default: return "audio/mpeg"
        }
    }

    @Builder<Element>
    func showAudioSourcefile() -> [Element] {
        Audio {

            Source()
                .src(data.linkToTheAudioFile)
                .type(audioMimeType(for: data.linkToTheAudioFile))

        }
        .preload(.metadata)
        .setAttribute(
            name: "x-ref",
            value: "player"
        )
        .setAttribute(
            name: "x-init",
            value: "$el.load()"
        )
        .setAttribute(
            name: "@timeupdate",
            value: "setTime()"
        )
        .setAttribute(
            name: "@durationchange",
            value: "setTime()"
        )
        .setAttribute(
            name: "@loadedmetadata",
            value: "metaDataLoaded = true"
        )
        .setAttribute(
            name: "@ended",
            value: "playing = false"
        )
    }

    @Builder<Element>
    func showTitleInfos() -> [Element] {
        DebugComment("Title infos")
        Div {

            // Title
            if let title = data.title {

                P(title)
                    .class(styles.titleText)
            }

            // Disclaimer
            if let disclaimer = data.disclaimer {

                P(disclaimer)
                    .class(styles.disclaimerText)
            }

            // Timecode
            P("")
                .setAttribute(
                    name: "x-text",
                    value: "currentTime"
                )
                .class(styles.timecodeText)

            // Status and track live region announcements
            Div {
                P("")
                    .setAttribute(
                        name: "x-text",
                        value: "statusAnnouncement"
                    )
            }
            .ariaLive(.polite)
            .setAttribute(name: "aria-atomic", value: "true")
            .class("sr-only")

        }
        .class("flex flex-col justify-center")
    }

    @Builder<Element>
    func showPlayButton() -> [Element] {
        Div {

            DebugComment("Play button")
            Button {

                Span {
                    Svg.icon(.play, width: 32, height: 32)
                }
                .setAttribute(
                    name: "x-show",
                    value: "!playing"
                )
                .ariaLabel("Play")

                Span {
                    Svg.icon(.pause, width: 32, height: 32)
                }
                .setAttribute(
                    name: "x-show",
                    value: "playing"
                )
                .ariaLabel("Pause")
            }
            .setAttribute(
                name: "@click",
                value: "toggle()"
            )
            .type(.button)
            .setAttribute(
                name: ":aria-label",
                value: "playing ? 'Pause' : 'Play'"
            )
            .flagAttribute("x-cloak")
            .addClass("h-8 w-8 flex items-center justify-center")
            .addClass(buttonStyles.iconButton)
            // Matomo
            .if(data.matomoStatus == .ACCEPTED || data.matomoStatus == .BANNER)
            {

                $0
                    .flagAttribute("data-track-content")
                    .setAttribute(
                        name: "data-content-name",
                        value: "content.audioplayer"
                    )
                    .setAttribute(
                        name: "data-content-piece",
                        value: "action.playpause"
                    )
                    .setAttribute(
                        name: "data-content-target",
                        value: data.linkToTheAudioFile
                    )

            }

            showTitleInfos()

        }
        .class("flex flex-row space-x-4 items-center pb-4")
    }

    @Builder<Element>
    func showScrubber() -> [Element] {
        DebugComment("Scrubber")
        Button {}
            .setAttribute(
                name: "x-ref",
                value: "scrubber"
            )
            .setAttribute(
                name: "@click",
                value: "scrub"
            )
            .ariaLabel("Audio progress slider")
            .setAttribute(
                name: "x-init",
                value: "progressBarWidth = $el.clientWidth"
            )
            .setAttribute(
                name: "x-show",
                value: "metaDataLoaded"
            )
            .tabIndex(0)
            .role("slider")
            .setAttribute(name: "aria-orientation", value: "horizontal")
            .setAttribute(
                name: ":aria-valuenow",
                value: "$refs.player?.currentTime || 0"
            )
            .setAttribute(
                name: ":aria-valuemax",
                value: "$refs.player?.duration || 0"
            )
            .setAttribute(
                name: ":aria-valuetext",
                value: "spokenTime()"
            )
            .ariaValueMin("0")
            .setAttribute(
                name: "@keydown.arrow-left",
                value: "skip(-5)"
            )
            .setAttribute(
                name: "@keydown.arrow-right",
                value: "skip(5)"
            )
            .setAttribute(
                name: "@keydown.enter.prevent",
                value: "toggle()"
            )
            .setAttribute(
                name: "@keydown.space.prevent",
                value: "toggle()"
            )
            .setAttribute(
                name: "@keydown.home.prevent",
                value: "$refs.player.currentTime = 0"
            )
            .setAttribute(
                name: "@keydown.meta.arrow-left.prevent",
                value: "$refs.player.currentTime = 0"
            )
            .setAttribute(
                name: "@keydown.fn.arrow-left.prevent",
                value: "$refs.player.currentTime = 0"
            )
            .setAttribute(
                name: "@keydown.end.prevent",
                value: "$refs.player.currentTime = $refs.player.duration"
            )
            .setAttribute(
                name: "@keydown.meta.arrow-right.prevent",
                value: "$refs.player.currentTime = $refs.player.duration"
            )
            .setAttribute(
                name: "@keydown.fn.arrow-right.prevent",
                value: "$refs.player.currentTime = $refs.player.duration"
            )
            .class(
                "absolute bottom-0 right-0 left-0 h-3 z-100 cursor-pointer"
            )
            .addClass(styles.backgroundTransparent)
            .addClass(buttonStyles.iconButton)

        P(
            "Use left/right arrows to skip, space to play or pause, and home/end to jump to the beginning or end."
        )
        .class("sr-only")
    }

    @Builder<Element>
    func showProgressBar() -> [Element] {
        DebugComment("Progress bar")
        Div {
            Div {}
                .setAttribute(
                    name: "x-ref",
                    value: "progress"
                )
                .setAttribute(
                    name: "x-show",
                    value: "metaDataLoaded"
                )
                .setAttribute(
                    name: "@resize.window",
                    value: "handleResize()"
                )
                .class(
                    "opacity-0 h-3 overflow-hidden"
                )
                .addClass(styles.progressBarActive)
        }
        .class("absolute bottom-0 right-0 left-0 h-3")
        .addClass(styles.progressBarInactive)
    }

    @Builder<Element>
    public func render() -> [Element] {
        DebugComment("Audio Player widget")

        // Intentional: the component ships its own script tag; duplicates are handled by the
        // window.__audioPlayerLoaded guard. Do not move into the page template during component audits.
        Script().src("/js/audioplayer.js")

        Div {
            Div {
                showAudioSourcefile()
                showPlayButton()
                if data.hasProgressBar {
                    showProgressBar()
                    showScrubber()
                }
                else {
                    Div {}.setAttribute(name: "x-ref", value: "scrubber")
                        .class("hidden")
                    Div {}.setAttribute(name: "x-ref", value: "progress")
                        .class("hidden")
                }
            }
            .class("p-4 relative")
            .addClass(styles.fontSans)
        }
        .setAttribute(name: "x-data", value: "playerData()")
        .if(data.title != nil) {
            if let title = data.title {
                return $0.ariaLabel("Audio Player for \(title)")
            }
            return $0
        } else: {
            $0.ariaLabel("Audio Player")
        }
        .class(styles.playerBorder)
    }
}
