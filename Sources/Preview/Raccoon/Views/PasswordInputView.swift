import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct PasswordInputView: TemplateRepresentable {

    let variants: [PreviewVariant<PasswordInputData>] = [
        #previewVariant(
            tr(
                "Password Input with Toggle Visibility",
                [
                    "de": "Passworteingabe mit Sichtbarkeits-Umschalter",
                    "fr": "Saisie de mot de passe avec bascule de visibilité",
                    "es": "Campo de contraseña con cambio de visibilidad",
                    "it": "Input password con attivazione visibilità",
                    "pt": "Campo de senha com alternância de visibilidade",
                    "nl": "Wachtwoordinvoer met zichtbaarheidsschakelaar",
                    "da": "Adgangskodefelt med synlighedsskift",
                    "sv": "Lösenordsinmatning med synlighetsväxlare",
                    "nb": "Passordinntasting med synlighetsbryter",
                    "fi": "Salasanakenttä näkyvyyden vaihtamisella",
                    "is": "Lykilorðareitur með sýnileikaskiptingu",
                    "el": "Πεδίο κωδικού πρόσβασης με εναλλαγή ορατότητας",
                    "tr": "Görünürlük geçişli şifre girişi",
                    "hu": "Jelszóbeviteli mező láthatósági kapcsolóval",
                    "hr": "Unos lozinke s prebacivanjem vidljivosti",
                    "pl": "Pole hasła z przełączaniem widoczności",
                    "sk": "Zadanie hesla s prepínaním viditeľnosti",
                    "cs": "Zadání hesla s přepínáním viditelnosti",
                    "lb": "Passwuert-Agab mat Siichtbarkeets-Ëmschalter",
                ]
            ),
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
