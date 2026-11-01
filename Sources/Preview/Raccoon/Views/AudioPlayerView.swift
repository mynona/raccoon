import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct AudioPlayerView: TemplateRepresentable {

    let variants: [PreviewVariant<AudioPlayerData>] = [
        #previewVariant(
            "Full Player with Progress Bar",
            AudioPlayerData(
                title: tr(
                    "Episode 2",
                    de: "Folge 2",
                    fr: "Épisode 2",
                    es: "Episodio 2",
                    it: "Episodio 2"
                ),
                disclaimer: tr(
                    "Disclaimer information",
                    de: "Hinweise zum Haftungsausschluss",
                    fr: "Informations de décharge de responsabilité",
                    es: "Información de exención de responsabilidad",
                    it: "Informazioni sulla dichiarazione di non responsabilità"
                ),
                linkToTheAudioFile:
                    "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
                hasProgressBar: true
            )
        ),
        #previewVariant(
            "Minimal Player with Matomo",
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
