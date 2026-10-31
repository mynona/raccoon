import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct LanguageSwitcherView: TemplateRepresentable {

    let variants: [(String, LanguageSwitcherData)] = [
        (
            """
            // English and German
            """,
            LanguageSwitcherData(
                languages: [
                    LanguageOption(code: "en", name: "English"),
                    LanguageOption(code: "de", name: "Deutsch"),
                ]
            )
        ),
        (
            """
            // More languages, custom id and fallback
            """,
            LanguageSwitcherData(
                id: "language-switcher-2",
                languages: [
                    LanguageOption(code: "de", name: "Deutsch"),
                    LanguageOption(code: "fr", name: "Français"),
                    LanguageOption(code: "es", name: "Español"),
                    LanguageOption(code: "it", name: "Italiano"),
                ],
                fallbackLanguage: "de"
            )
        ),
    ]

    func makeHtml(ctx: LanguageSwitcherData) -> String {
        let html = renderFragments(LanguageSwitcher(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Language Switcher")

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { LanguageSwitcher(ctx).render() }
                            .class("mb-28 mt-4")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
