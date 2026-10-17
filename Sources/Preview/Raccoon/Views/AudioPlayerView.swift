import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct AudioPlayerView: TemplateRepresentable {

    let variants: [(String, AudioPlayerData)] = [
        (
            """
            //
            """,
            AudioPlayerData(
                title: "Episode 2",
                disclaimer: "Disclaimer information",
                linkToTheAudioFile:
                    "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
                hasProgressBar: true
            )
        ),
        (
            """
            // with Matomo
            """,
            AudioPlayerData(
                linkToTheAudioFile:
                    "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
                hasProgressBar: false,
                matomoStatus: .ACCEPTED
            )
        ),
    ]

    func makeHtml(ctx: AudioPlayerData) -> String {
        let html = renderFragments(AudioPlayer(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("AudioPlayer")

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { AudioPlayer(ctx).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
