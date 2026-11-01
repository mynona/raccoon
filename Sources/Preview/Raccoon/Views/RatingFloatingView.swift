import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct RatingFloatingView: TemplateRepresentable {

    let scrollDemoData = RatingData(
        id: "floating-scroll-demo",
        url: "/success",
        ratingType: .thumbsUpDown,
        isFloating: true,
        isShownOnScroll: true
    )

    let variants: [PreviewVariant<RatingData>] = [
        #previewVariant(
            tr(
                "Scroll-Triggered Floating Feedback Widget",
                [
                    "de": "Durch Scrollen ausgelöstes schwebendes Feedback-Widget",
                    "fr": "Widget de retour flottant déclenché par défilement",
                    "es": "Widget de valoración flotante activado por desplazamiento",
                    "it": "Widget di feedback fluttuante attivato dallo scorrimento",
                    "pt": "Widget de feedback flutuante ativado por rolagem",
                    "nl": "Door scrollen geactiveerde zwevende feedback-widget",
                    "da": "Rulningsudløst svævende feedback-widget",
                    "sv": "Rullningsutlöst svävande feedback-widget",
                    "nb": "Rulleutløst flytende tilbakemeldings-widget",
                    "fi": "Vierityksen käynnistämä kelluva palaute-widget",
                    "is": "Fljótandi endurgjafargræja sem virkjast við skrun",
                    "el": "Αιωρούμενο γραφικό στοιχείο σχολίων ενεργοποιούμενο από κύλιση",
                    "tr": "Kaydırma tetiklemeli kayan geri bildirim aracı",
                    "hu": "Görgetéssel aktivált lebegő visszajelzési modul",
                    "hr": "Plutajući widget za povratne informacije pokrenut pomicanjem",
                    "pl": "Pływający widżet opinii uruchamiany przewijaniem",
                    "sk": "Plávajúci widget spätnej väzby spúšťaný posúvaním",
                    "cs": "Plovoucí widget zpětné vazby spouštěný posouváním",
                    "lb": "Duerch Scrollen ausgeléiste schwiewende Feedback-Widget",
                ]
            ),
            RatingData(
                id: "floating-scroll-124",
                url: "/success",
                ratingType: .thumbsUpDown,
                isFloating: true,
                isShownOnScroll: true
            )
        )
    ]

    func makeHtml(ctx: RatingData) -> String {
        let html = renderFragments(
            Rating(ctx.withFloating(true)).render()
        )
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Rating Floating")

                // Set Matomo cookie so the widget is permitted to show
                Script(
                    """
                    document.cookie = "raumnebenan-matomo=declined; path=/";
                    """
                )

                // Sticky real-time scroll position HUD
                Div {
                    Div {
                        Span(PreviewTexts.scrollDepth.resolved)
                            .localized(PreviewTexts.scrollDepth)
                            .class(CommonStyles.textColorDefault)
                        Span {
                            Text("")
                        }
                        .setAttribute(
                            name: "x-text",
                            value: "scrollPercent + '%'"
                        )
                        .class(["font-bold", CommonStyles.textColorEmphasized].joined(separator: " "))
                    }
                    .class("flex items-center gap-1.5")

                    Div {
                        Span(PreviewTexts.threshold.resolved)
                            .localized(PreviewTexts.threshold)
                            .class(CommonStyles.textColorDefault)
                        Span {
                            Text("")
                        }
                        .setAttribute(
                            name: "x-text",
                            value:
                                "scrollPercent >= 80 ? '\(tr("REACHED (widget visible)", de: "ERREICHT (Widget sichtbar)", fr: "ATTEINT (widget visible)", es: "ALCANZADO (widget visible)", it: "RAGGIUNTO (widget visibile)").resolved)' : '\(tr("Scroll down to trigger", de: "Zum Auslösen nach unten scrollen", fr: "Faites défiler pour déclencher", es: "Desplázate hacia abajo para activarlo", it: "Scorri verso il basso per attivare").resolved)'"
                        )
                        .setAttribute(
                            name: ":class",
                            value:
                                "scrollPercent >= 80 ? '\(CommonStyles.textColorSuccess) font-semibold' : '\(CommonStyles.textColorError)'"
                        )
                    }
                    .class("flex items-center gap-1.5")
                }
                .class(
                    [
                        "sticky top-0 z-40 flex flex-wrap items-center justify-between gap-4 p-3 backdrop-blur border rounded-lg shadow-sm text-xs font-mono mb-6",
                        CommonStyles.backgroundLight,
                        CommonStyles.borderColorDefault,
                    ]
                    .joined(separator: " ")
                )
                .setAttribute(
                    name: "x-data",
                    value: """
                        {
                            scrollPercent: 0,
                            init() {
                                const update = () => {
                                    const scrollEl = document.querySelector('main');
                                    const isMainScrollable = scrollEl && scrollEl.scrollHeight > scrollEl.clientHeight;
                                    const currentScroll = isMainScrollable ? scrollEl.scrollTop : window.scrollY;
                                    const totalHeight = isMainScrollable ? scrollEl.scrollHeight : Math.max(document.documentElement.scrollHeight, document.body.scrollHeight);
                                    const viewHeight = isMainScrollable ? scrollEl.clientHeight : window.innerHeight;
                                    this.scrollPercent = Math.min(100, Math.round(((currentScroll + viewHeight) / totalHeight) * 100));
                                };
                                window.addEventListener('scroll', update);
                                const scrollEl = document.querySelector('main');
                                if (scrollEl) scrollEl.addEventListener('scroll', update);
                                update();
                            }
                        }
                        """
                )

                // Section 1: Component preview (tab)
                // In the preview tab, rendered with isFloating: false, isShownOnScroll: false so it is immediately visible in the tab
                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div {
                            Rating(
                                RatingData(
                                    id: "\(variant.data.id)-tab-preview",
                                    url: variant.data.url,
                                    ratingType: variant.data.ratingType,
                                    question: variant.data.question,
                                    positiveFollowUpQuestion: variant.data
                                        .positiveFollowUpQuestion,
                                    negativeFollowUpQuestion: variant.data
                                        .negativeFollowUpQuestion,
                                    ErrorMessageInvalidFeedback: variant.data
                                        .ErrorMessageInvalidFeedback,
                                    cookieName: variant.data.cookieName,
                                    isFloating: false,
                                    isShownOnScroll: false
                                )
                            )
                            .render()
                        }
                        .class("mb-4 mt-12 relative flex justify-center")
                    }
                }

                // Section 2: Interactive Long Page Test (80% scroll test bed)
                Div {
                    H2(PreviewTexts.testBed.resolved)
                        .localized(PreviewTexts.testBed)
                        .class(
                            ["mb-2 text-xl font-bold", CommonStyles.textColorEmphasized].joined(separator: " ")
                        )

                    P(
                        tr(
                            "This tall page section allows testing the 80% scroll threshold and the close/docking behavior. As you scroll down past the 80% indicator marker line, the widget appears floating at the bottom of the viewport. If you click the close button, it docks into its dedicated in-page spot below.",
                            de:
                                "Dieser hohe Seitenabschnitt erlaubt es, den Scroll-Schwellenwert von 80 % und das Schließen bzw. Andocken zu testen. Sobald du über die 80-%-Markierungslinie hinausscrollst, erscheint das Widget schwebend am unteren Rand des Anzeigebereichs. Wenn du auf die Schließen-Schaltfläche klickst, dockt es an seiner vorgesehenen Stelle weiter unten an.",
                            fr:
                                "Cette longue section de page permet de tester le seuil de défilement de 80 % et le comportement de fermeture et d'ancrage. Lorsque vous dépassez la ligne repère des 80 %, le widget apparaît flottant en bas de la fenêtre. Si vous cliquez sur le bouton de fermeture, il s'ancre à son emplacement dédié plus bas dans la page.",
                            es:
                                "Esta larga sección de la página permite probar el umbral de desplazamiento del 80 % y el comportamiento de cierre y acoplamiento. Al superar la línea marcadora del 80 %, el widget aparece flotando en la parte inferior de la ventana. Si haces clic en el botón de cierre, se acopla en su lugar dedicado más abajo en la página.",
                            it:
                                "Questa lunga sezione della pagina permette di testare la soglia di scorrimento dell'80% e il comportamento di chiusura e ancoraggio. Quando superi la linea di riferimento dell'80%, il widget appare fluttuante in fondo all'area visibile. Se fai clic sul pulsante di chiusura, si aggancia nella sua posizione dedicata più in basso nella pagina."
                        )
                        .resolved
                    )
                    .class(["mb-6 text-sm", CommonStyles.textColorDefault].joined(separator: " "))

                    // Long scrollable content container
                    Div {
                        // 0% marker
                        Div {
                            Span(PreviewTexts.pageTop.resolved)
                                .localized(PreviewTexts.pageTop)
                                .class(
                                    ["text-xs font-semibold uppercase tracking-wider", CommonStyles.textColorEmphasized].joined(separator: " ")
                                )
                        }
                        .class(
                            ["pb-2 mb-6 border-b-2", CommonStyles.borderColorTheme].joined(separator: " ")
                        )

                        // Filler paragraph blocks 10% - 70%
                        for percent in stride(from: 10, through: 70, by: 10) {
                            Div {
                                Div {
                                    Span(
                                        PreviewTexts.milestone
                                            .with(variables: [
                                                "percent": "\(percent)"
                                            ])
                                            .resolved
                                    )
                                    .localized(
                                        PreviewTexts.milestone.with(variables: [
                                            "percent": "\(percent)"
                                        ])
                                    )
                                    .class(
                                        [
                                            "text-xs font-semibold px-2 py-0.5 rounded border bg-tertiary dark:bg-surface-dark",
                                            CommonStyles.textColorDefault,
                                            CommonStyles.borderColorDefault,
                                        ]
                                        .joined(separator: " ")
                                    )
                                }
                                .class("mb-2")

                                P(
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
                                )
                                .class(
                                    ["text-sm leading-relaxed", CommonStyles.textColorDefault].joined(separator: " ")
                                )

                                P(
                                    "Curabitur pretium tincidunt lacus. Nulla gravida orci a odio. Nullam varius, turpis et commodo pharetra, est eros bibendum elit, nec luctus magna felis sollicitudin mauris. Integer in mauris eu nibh euismod gravida. Duis ac tellus et risus vulputate vehicula. Donec lobortis risus a elit."
                                )
                                .class(
                                    ["text-sm leading-relaxed mt-2", CommonStyles.textColorDefault].joined(separator: " ")
                                )
                            }
                            .class(
                                ["py-8 border-b", CommonStyles.borderColorDefault].joined(separator: " ")
                            )
                        }

                        // 80% visual marker
                        Div {
                            Div {
                                Div {
                                    Svg.icon(.arrow_down, width: 20, height: 20)
                                    Span(PreviewTexts.reached.resolved)
                                        .localized(PreviewTexts.reached)
                                        .class(
                                            "font-bold tracking-wider text-sm"
                                        )
                                    Svg.icon(.arrow_down, width: 20, height: 20)
                                }
                                .class(
                                    "flex items-center justify-center gap-2 text-white bg-amber-600 dark:bg-amber-500 py-2 px-4 rounded-md shadow-md animate-pulse"
                                )

                                P(
                                    tr(
                                        "At or below this line, currentScroll + viewHeight >= 80% totalHeight. The rating widget triggers and floats over the viewport bottom.",
                                        de:
                                            "Auf oder unterhalb dieser Linie gilt currentScroll + viewHeight >= 80 % totalHeight. Das Bewertungs-Widget wird ausgelöst und schwebt über dem unteren Rand des Anzeigebereichs.",
                                        fr:
                                            "Sur cette ligne ou en dessous, currentScroll + viewHeight >= 80 % totalHeight. Le widget de notation se déclenche et flotte au bas de la fenêtre.",
                                        es:
                                            "En esta línea o por debajo, currentScroll + viewHeight >= 80 % totalHeight. El widget de valoración se activa y flota sobre la parte inferior de la ventana.",
                                        it:
                                            "Su questa linea o sotto, currentScroll + viewHeight >= 80% totalHeight. Il widget di valutazione si attiva e fluttua sul fondo dell'area visibile."
                                    )
                                    .resolved
                                )
                                .class(
                                    "text-xs text-center text-amber-700 dark:text-amber-300 mt-2 font-medium"
                                )
                            }
                            .class(
                                "border-4 border-dashed border-amber-500 dark:border-amber-400 rounded-xl p-4 bg-amber-50 dark:bg-amber-950/30 my-8"
                            )
                        }

                        // Further filler content (80% - 100%)
                        for percent in stride(from: 85, through: 95, by: 10) {
                            Div {
                                Div {
                                    Span(
                                        PreviewTexts.milestone
                                            .with(variables: [
                                                "percent": "\(percent)"
                                            ])
                                            .resolved
                                    )
                                    .localized(
                                        PreviewTexts.milestone.with(variables: [
                                            "percent": "\(percent)"
                                        ])
                                    )
                                    .class(
                                        [
                                            "text-xs font-semibold px-2 py-0.5 rounded border bg-tertiary dark:bg-surface-dark",
                                            CommonStyles.textColorDefault,
                                            CommonStyles.borderColorDefault,
                                        ]
                                        .joined(separator: " ")
                                    )
                                }
                                .class("mb-2")

                                P(
                                    "Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim."
                                )
                                .class(
                                    ["text-sm leading-relaxed", CommonStyles.textColorDefault].joined(separator: " ")
                                )
                            }
                            .class(
                                ["py-6 border-b", CommonStyles.borderColorDefault].joined(separator: " ")
                            )
                        }

                        // In-page dedicated spot where the widget docks on close
                        Div {
                            Div {
                                Span(PreviewTexts.articleEnd.resolved)
                                    .localized(PreviewTexts.articleEnd)
                                    .class(
                                        ["text-xs font-bold uppercase tracking-wider", CommonStyles.textColorSuccess].joined(separator: " ")
                                    )
                                P(
                                    tr(
                                        "When the floating rating widget is closed, it docks here into the normal document flow.",
                                        de:
                                            "Wenn das schwebende Bewertungs-Widget geschlossen wird, dockt es hier im normalen Dokumentfluss an.",
                                        fr:
                                            "Lorsque le widget de notation flottant est fermé, il s'ancre ici dans le flux normal du document.",
                                        es:
                                            "Cuando se cierra el widget de valoración flotante, se acopla aquí en el flujo normal del documento.",
                                        it:
                                            "Quando il widget di valutazione fluttuante viene chiuso, si aggancia qui nel normale flusso del documento."
                                    )
                                    .resolved
                                )
                                .class(
                                    ["text-xs mt-1", CommonStyles.textColorDefault].joined(separator: " ")
                                )
                            }
                            .class(
                                [
                                    "p-3 rounded-lg mb-4 border",
                                    CommonStyles.borderColorSuccess,
                                    "bg-tertiary dark:bg-surface-dark",
                                ]
                                .joined(separator: " ")
                            )

                            Div {
                                Rating(scrollDemoData).render()
                            }
                            .class("relative flex justify-center py-4")
                        }
                        .class(
                            [
                                "my-10 p-6 border-2 rounded-xl shadow-sm",
                                CommonStyles.borderColorSuccess,
                                CommonStyles.backgroundLight,
                            ]
                            .joined(separator: " ")
                        )

                        // Page bottom indicator
                        Div {
                            Span(PreviewTexts.pageBottom.resolved)
                                .localized(PreviewTexts.pageBottom)
                                .class(
                                    ["text-xs font-semibold uppercase tracking-wider", CommonStyles.textColorDisabled].joined(separator: " ")
                                )
                        }
                        .class(
                            ["border-t pt-4 text-center pb-24", CommonStyles.borderColorDefault].joined(separator: " ")
                        )
                    }
                }
                .class(
                    ["mt-12 pt-8 border-t-2", CommonStyles.borderColorDefault].joined(separator: " ")
                )

            }
            .class("mt-4 space-y-6 relative")

        }
        .render()
    }
}
