import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct AudioPlayerView: TemplateRepresentable {

    let variants: [PreviewVariant<AudioPlayerData>] = [
        #previewVariant(
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
        #previewVariant(
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

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { AudioPlayer(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
