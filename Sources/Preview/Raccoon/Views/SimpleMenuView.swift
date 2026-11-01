import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct SimpleMenuView: TemplateRepresentable {

    let variants: [PreviewVariant<SimpleMenuData>] = [
        #previewVariant(
            """
            // Action Menu with text
            """,
            SimpleMenuData(
                ariaLabel: tr(
                    "Actions",
                    de: "Aktionen",
                    fr: "Actions",
                    es: "Acciones",
                    it: "Azioni"
                ),
                triggerText: tr(
                    "Actions",
                    de: "Aktionen",
                    fr: "Actions",
                    es: "Acciones",
                    it: "Azioni"
                ),
                options: [
                    SimpleMenuOption(
                        id: "edit",
                        title: tr(
                            "Edit item",
                            de: "Element bearbeiten",
                            fr: "Modifier l'élément",
                            es: "Editar elemento",
                            it: "Modifica elemento"
                        ),
                        clickAction: "alert('Edit clicked')"
                    ),
                    SimpleMenuOption(
                        id: "duplicate",
                        title: tr(
                            "Duplicate",
                            de: "Duplizieren",
                            fr: "Dupliquer",
                            es: "Duplicar",
                            it: "Duplica"
                        ),
                        clickAction: "alert('Duplicate clicked')"
                    ),
                    SimpleMenuOption(
                        id: "archive",
                        title: tr(
                            "Archive",
                            de: "Archivieren",
                            fr: "Archiver",
                            es: "Archivar",
                            it: "Archivia"
                        ),
                        clickAction: "alert('Archive clicked')"
                    ),
                ],
                width: "w-48"
            )
        ),
        #previewVariant(
            """
            // SSR Link Mode with Pre-rendered Checkmark
            """,
            SimpleMenuData(
                ariaLabel: tr(
                    "Page size",
                    de: "Seitengröße",
                    fr: "Taille de page",
                    es: "Tamaño de página",
                    it: "Dimensione pagina"
                ),
                triggerText: tr(
                    "25 items",
                    de: "25 Einträge",
                    fr: "25 éléments",
                    es: "25 elementos",
                    it: "25 elementi"
                ),
                options: [
                    SimpleMenuOption(
                        id: "10",
                        title: tr(
                            "10 items",
                            de: "10 Einträge",
                            fr: "10 éléments",
                            es: "10 elementos",
                            it: "10 elementi"
                        ),
                        isSelected: false,
                        href: "/preview/simple-menu?per=10"
                    ),
                    SimpleMenuOption(
                        id: "25",
                        title: tr(
                            "25 items",
                            de: "25 Einträge",
                            fr: "25 éléments",
                            es: "25 elementos",
                            it: "25 elementi"
                        ),
                        isSelected: true,
                        href: "/preview/simple-menu?per=25"
                    ),
                    SimpleMenuOption(
                        id: "50",
                        title: tr(
                            "50 items",
                            de: "50 Einträge",
                            fr: "50 éléments",
                            es: "50 elementos",
                            it: "50 elementi"
                        ),
                        isSelected: false,
                        href: "/preview/simple-menu?per=50"
                    ),
                ],
                width: "w-36"
            )
        ),
        #previewVariant(
            """
            // Icon-Only Trigger Button
            """,
            SimpleMenuData(
                ariaLabel: tr(
                    "Color theme",
                    de: "Farbschema",
                    fr: "Thème de couleurs",
                    es: "Tema de color",
                    it: "Tema colore"
                ),
                options: [
                    SimpleMenuOption(
                        id: "theme-default",
                        title: "emerald-mine",
                        isSelected: true,
                        clickAction: "alert('emerald-mine theme')"
                    ),
                    SimpleMenuOption(
                        id: "theme-bw",
                        title: "Black & White",
                        isSelected: false,
                        clickAction: "alert('black-and-white theme')"
                    ),
                ],
                width: "w-48",
                triggerIcon: .palette2,
                hasTriggerChevron: false
            )
        ),
        #previewVariant(
            """
            // Right-Aligned Panel with Option Icons
            """,
            SimpleMenuData(
                ariaLabel: tr(
                    "User options",
                    de: "Benutzeroptionen",
                    fr: "Options utilisateur",
                    es: "Opciones de usuario",
                    it: "Opzioni utente"
                ),
                triggerText: tr(
                    "Profile",
                    de: "Profil",
                    fr: "Profil",
                    es: "Perfil",
                    it: "Profilo"
                ),
                options: [
                    SimpleMenuOption(
                        id: "account",
                        title: tr(
                            "Account settings",
                            de: "Kontoeinstellungen",
                            fr: "Paramètres du compte",
                            es: "Ajustes de la cuenta",
                            it: "Impostazioni account"
                        ),
                        clickAction: "alert('Account')",
                        icon: .person_fill
                    ),
                    SimpleMenuOption(
                        id: "cms",
                        title: "CMS",
                        clickAction: "alert('CMS')",
                        icon: .card_heading
                    ),
                    SimpleMenuOption(
                        id: "logout",
                        title: tr(
                            "Sign out",
                            de: "Abmelden",
                            fr: "Se déconnecter",
                            es: "Cerrar sesión",
                            it: "Esci"
                        ),
                        clickAction: "alert('Sign out')",
                        icon: .box_arrow_left
                    ),
                ],
                align: .left,
                width: "w-48"
            )
        ),
    ]

    func makeHtml(ctx: SimpleMenuData) -> String {
        let html = renderFragments(SimpleMenu(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {
        Basic(title: "Simple Menu") {
            Div {
                showComponentTitle("Simple Menu")

                for variant in variants {
                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div {
                            SimpleMenu(variant.data).render()
                        }
                        .class("mb-32 mt-4")
                    }
                }
            }
            .class("mt-4 space-y-6")
        }
        .render()
    }
}
