import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct AudioPlayerView: TemplateRepresentable {

    let variants: [PreviewVariant<AudioPlayerData>] = [
        #previewVariant(
            tr(
                "Full Player with Progress Bar",
                [
                    "de": "Vollständiger Player mit Fortschrittsleiste",
                    "fr": "Lecteur complet avec barre de progression",
                    "es": "Reproductor completo con barra de progreso",
                    "it": "Player completo con barra di avanzamento",
                    "pt": "Player completo com barra de progresso",
                    "nl": "Volledige speler met voortgangsbalk",
                    "da": "Komplet afspiller med statuslinje",
                    "sv": "Fullständig spelare med förloppsindikator",
                    "nb": "Full spiller med fremdriftslinje",
                    "fi": "Täysi soitin edistymispalkilla",
                    "is": "Heill spilari með framvindustiku",
                    "el": "Πλήρες πρόγραμμα αναπαραγωγής με γραμμή προόδου",
                    "tr": "İlerleme çubuklu tam oynatıcı",
                    "hu": "Teljes lejátszó folyamatjelzővel",
                    "hr": "Potpuni player s trakom napretka",
                    "pl": "Pełny odtwarzacz z paskiem postępu",
                    "sk": "Kompletný prehrávač s indikátorom priebehu",
                    "cs": "Kompletní přehrávač s indikátorem průběhu",
                    "lb": "Komplette Player mat Fortschrëttsläischt",
                ]
            ),
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
            tr(
                "Minimal Player with Matomo",
                [
                    "de": "Minimaler Player mit Matomo",
                    "fr": "Lecteur minimal avec Matomo",
                    "es": "Reproductor mínimo con Matomo",
                    "it": "Player minimale con Matomo",
                    "pt": "Player mínimo com Matomo",
                    "nl": "Minimale speler met Matomo",
                    "da": "Minimal afspiller med Matomo",
                    "sv": "Minimal spelare med Matomo",
                    "nb": "Minimal spiller med Matomo",
                    "fi": "Minimaalinen soitin Matomolla",
                    "is": "Einfaldur spilari með Matomo",
                    "el": "Ελάχιστο πρόγραμμα αναπαραγωγής με Matomo",
                    "tr": "Matomo ile minimal oynatıcı",
                    "hu": "Minimális lejátszó Matomóval",
                    "hr": "Minimalni player s Matomom",
                    "pl": "Minimalny odtwarzacz z Matomo",
                    "sk": "Minimálny prehrávač s Matomom",
                    "cs": "Minimální přehrávač s Matomem",
                    "lb": "Minimale Player mat Matomo",
                ]
            ),
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
