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
            """
            // Floating rating widget on scroll
            // Revealed once the user has scrolled through 80% of the page.
            // If closed without comment, it docks into the fixed place on the page.
            """,
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
                            .class("text-gray-500 dark:text-gray-400")
                        Span {
                            Text("")
                        }
                        .setAttribute(
                            name: "x-text",
                            value: "scrollPercent + '%'"
                        )
                        .class("font-bold text-gray-900 dark:text-gray-100")
                    }
                    .class("flex items-center gap-1.5")

                    Div {
                        Span(PreviewTexts.threshold.resolved)
                            .localized(PreviewTexts.threshold)
                            .class("text-gray-500 dark:text-gray-400")
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
                                "scrollPercent >= 80 ? 'text-green-600 dark:text-green-400 font-semibold' : 'text-amber-600 dark:text-amber-400'"
                        )
                    }
                    .class("flex items-center gap-1.5")
                }
                .class(
                    "sticky top-0 z-40 flex flex-wrap items-center justify-between gap-4 p-3 bg-white/95 dark:bg-gray-900/95 backdrop-blur border border-gray-200 dark:border-gray-700 rounded-lg shadow-sm text-xs font-mono mb-6"
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
                            "text-xl font-bold text-black dark:text-white mb-2"
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
                    .class("text-sm text-gray-600 dark:text-gray-300 mb-6")

                    // Long scrollable content container
                    Div {
                        // 0% marker
                        Div {
                            Span(PreviewTexts.pageTop.resolved)
                                .localized(PreviewTexts.pageTop)
                                .class(
                                    "text-xs font-semibold uppercase tracking-wider text-blue-600 dark:text-blue-400"
                                )
                        }
                        .class(
                            "border-b-2 border-blue-400 dark:border-blue-500 pb-2 mb-6"
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
                                        "text-xs font-semibold px-2 py-0.5 rounded bg-gray-100 dark:bg-gray-800 text-gray-600 dark:text-gray-300 border border-gray-200 dark:border-gray-700"
                                    )
                                }
                                .class("mb-2")

                                P(
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
                                )
                                .class(
                                    "text-sm text-gray-500 dark:text-gray-400 leading-relaxed"
                                )

                                P(
                                    "Curabitur pretium tincidunt lacus. Nulla gravida orci a odio. Nullam varius, turpis et commodo pharetra, est eros bibendum elit, nec luctus magna felis sollicitudin mauris. Integer in mauris eu nibh euismod gravida. Duis ac tellus et risus vulputate vehicula. Donec lobortis risus a elit."
                                )
                                .class(
                                    "text-sm text-gray-500 dark:text-gray-400 leading-relaxed mt-2"
                                )
                            }
                            .class(
                                "py-8 border-b border-gray-200 dark:border-gray-800"
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
                                        "text-xs font-semibold px-2 py-0.5 rounded bg-gray-100 dark:bg-gray-800 text-gray-600 dark:text-gray-300 border border-gray-200 dark:border-gray-700"
                                    )
                                }
                                .class("mb-2")

                                P(
                                    "Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim."
                                )
                                .class(
                                    "text-sm text-gray-500 dark:text-gray-400 leading-relaxed"
                                )
                            }
                            .class(
                                "py-6 border-b border-gray-200 dark:border-gray-800"
                            )
                        }

                        // In-page dedicated spot where the widget docks on close
                        Div {
                            Div {
                                Span(PreviewTexts.articleEnd.resolved)
                                    .localized(PreviewTexts.articleEnd)
                                    .class(
                                        "text-xs font-bold uppercase tracking-wider text-green-700 dark:text-green-300"
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
                                    "text-xs text-gray-500 dark:text-gray-400 mt-1"
                                )
                            }
                            .class(
                                "p-3 bg-green-50 dark:bg-green-950/30 border border-green-200 dark:border-green-800 rounded-lg mb-4"
                            )

                            Div {
                                Rating(scrollDemoData).render()
                            }
                            .class("relative flex justify-center py-4")
                        }
                        .class(
                            "my-10 p-6 border-2 border-green-300 dark:border-green-700 rounded-xl bg-white dark:bg-gray-900 shadow-sm"
                        )

                        // Page bottom indicator
                        Div {
                            Span(PreviewTexts.pageBottom.resolved)
                                .localized(PreviewTexts.pageBottom)
                                .class(
                                    "text-xs font-semibold uppercase tracking-wider text-gray-400 dark:text-gray-500"
                                )
                        }
                        .class(
                            "border-t border-gray-200 dark:border-gray-800 pt-4 text-center pb-24"
                        )
                    }
                }
                .class(
                    "mt-12 pt-8 border-t-2 border-gray-200 dark:border-gray-800"
                )

            }
            .class("mt-4 space-y-6 relative")

        }
        .render()
    }
}
