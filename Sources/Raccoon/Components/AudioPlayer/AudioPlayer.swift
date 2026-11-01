import DOM
import HTML
import SGML
import SVG
import WebBuilders

public struct AudioPlayer: TemplateRepresentable {
    let data: AudioPlayerData
    typealias styles = AudioPlayerStyles

    /// Announcements that `audioplayer.js` makes. The script asks the i18n store for them, so they are
    /// recorded here to land in the page dictionary.
    private static let scriptTexts: [LocalizedText] = [
        LocalizedText(
            "audioplayer.skipped",
            "Skipped {{seconds}} seconds. Now playing."
        ),
        LocalizedText("audioplayer.paused", "Audio paused"),
        LocalizedText("audioplayer.playing", "Audio playing"),
    ]

    private static func recordScriptTexts() {
        for text in scriptTexts { text.recordUse() }
    }

    private static let play = LocalizedText("audioplayer.play", "Play")
    private static let pause = LocalizedText("audioplayer.pause", "Pause")
    private static let progress = LocalizedText(
        "audioplayer.progress",
        "Audio progress slider"
    )
    private static let player = LocalizedText(
        "audioplayer.player",
        "Audio Player"
    )
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
            value: "metaDataLoaded = true; setTime()"
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
                .localized(.ariaLabel, Self.play)

                Span {
                    Svg.icon(.pause, width: 32, height: 32)
                }
                .setAttribute(
                    name: "x-show",
                    value: "playing"
                )
                .localized(.ariaLabel, Self.pause)
            }
            .setAttribute(
                name: "@click",
                value: "toggle()"
            )
            .type(.button)
            .setAttribute(
                name: ":aria-label",
                value:
                    "playing ? \(Self.pause.alpineExpression) : \(Self.play.alpineExpression)"
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
                name: "@pointerdown",
                value: "startDrag($event)"
            )
            .setAttribute(
                name: "@pointermove",
                value: "onDrag($event)"
            )
            .setAttribute(
                name: "@pointerup",
                value: "endDrag($event)"
            )
            .setAttribute(
                name: "@pointercancel",
                value: "endDrag($event)"
            )
            .setAttribute(
                name: "@mouseenter",
                value: "isHovered = true"
            )
            .setAttribute(
                name: "@mouseleave",
                value: "if (!isDragging) isHovered = false"
            )
            .setAttribute(
                name: "@focus",
                value: "isFocused = true"
            )
            .setAttribute(
                name: "@blur",
                value: "isFocused = false"
            )
            .setAttribute(
                name: "@click",
                value: "scrub($event)"
            )
            .localized(.ariaLabel, Self.progress)
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
                value: "seek(0)"
            )
            .setAttribute(
                name: "@keydown.meta.arrow-left.prevent",
                value: "seek(0)"
            )
            .setAttribute(
                name: "@keydown.fn.arrow-left.prevent",
                value: "seek(0)"
            )
            .setAttribute(
                name: "@keydown.end.prevent",
                value: "seek($refs.player?.duration || 0)"
            )
            .setAttribute(
                name: "@keydown.meta.arrow-right.prevent",
                value: "seek($refs.player?.duration || 0)"
            )
            .setAttribute(
                name: "@keydown.fn.arrow-right.prevent",
                value: "seek($refs.player?.duration || 0)"
            )
            .class(styles.scrubberButton)

        P(
            "Use left/right arrows to skip, space to play or pause, and home/end to jump to the beginning or end."
        )
        .class("sr-only")
    }

    @Builder<Element>
    func showProgressBar() -> [Element] {
        DebugComment("Progress bar")
        Div {
            // Active progress fill
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
                    "opacity-0 h-3 overflow-hidden transition-[width] duration-75"
                )
                .addClass(styles.progressBarActive)

            // Reused Tooltip: floating timestamp seek preview
            Div {
                Div {
                    P("")
                        .setAttribute(
                            name: "x-text",
                            value: "previewTimeFormatted"
                        )
                        .class(styles.tooltipText)

                    Div {
                        Div {}
                            .class(styles.tooltipArrow)
                    }
                    .class(styles.tooltipArrowWrapper)
                }
                .class(styles.tooltipBubble)
            }
            .setAttribute(name: "x-ref", value: "progressTooltip")
            .setAttribute(name: "x-show", value: "metaDataLoaded")
            .setAttribute(
                name: ":style",
                value:
                    "`left: ${isHovered && !isDragging ? hoverPercent : progressPercent}%; transform: translateX(-50%);`"
            )
            .setAttribute(
                name: ":class",
                value:
                    "{ 'opacity-100 scale-100': isHovered || isFocused || isDragging, 'opacity-0 scale-95': !(isHovered || isFocused || isDragging) }"
            )
            .role("tooltip")
            .ariaHidden("true")
            .class(styles.tooltipContainer)

            // Enlarged persistent thumb indicator (16px at rest -> 20px on hover/focus/drag, hidden when time is 0:00)
            Div {
                Div {}
                    .class(styles.progressThumbCircle)
                    .setAttribute(
                        name: ":class",
                        value:
                            "{ 'w-5 h-5 ring-2 ring-focusring ring-offset-2': isHovered || isFocused || isDragging, 'w-4 h-4': !(isHovered || isFocused || isDragging) }"
                    )
            }
            .setAttribute(name: "x-ref", value: "progressThumb")
            .setAttribute(name: "x-show", value: "metaDataLoaded && showThumb")
            .setAttribute(
                name: ":style",
                value:
                    "`left: ${progressPercent}%; transform: translate(-50%, -50%);`"
            )
            .class(styles.progressThumbContainer)
        }
        .class("absolute bottom-0 right-0 left-0 h-3")
        .addClass(styles.progressBarInactive)
    }

    @Builder<Element>
    public func render() -> [Element] {
        DebugComment("Audio Player widget")
        let _ = Self.recordScriptTexts()

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
                return $0.localized(
                    .ariaLabel,
                    LocalizedText(
                        "audioplayer.playerFor",
                        "Audio Player for {{title}}",
                        variables: ["title": title]
                    )
                )
            }
            return $0
        } else: {
            $0.localized(.ariaLabel, Self.player)
        }
        .class(styles.playerBorder)
    }
}
