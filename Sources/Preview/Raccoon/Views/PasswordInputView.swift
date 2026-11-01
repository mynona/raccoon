import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct PasswordInputView: TemplateRepresentable {

    let variants: [PreviewVariant<PasswordInputData>] = [
        #previewVariant(
            "Password Input with Toggle Visibility",
            PasswordInputData(
                passwordId: "password",
                passwordLabel: LabelData(
                    id: "password",
                    title: tr(
                        "Password",
                        de: "Passwort",
                        fr: "Mot de passe",
                        es: "Contraseña",
                        it: "Password"
                    )
                )
            )
        )
    ]

    func makeHtml(ctx: PasswordInputData) -> String {
        let html = renderFragments(PasswordInput(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("PasswordInput")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { PasswordInput(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
