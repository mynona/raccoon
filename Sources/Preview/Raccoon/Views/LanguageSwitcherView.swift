import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct LanguageSwitcherView: TemplateRepresentable {

    let variants: [PreviewVariant<LanguageSwitcherData>] = [
        #previewVariant(
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
        #previewVariant(
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

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { LanguageSwitcher(variant.data).render() }
                            .class("mb-28 mt-4")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
