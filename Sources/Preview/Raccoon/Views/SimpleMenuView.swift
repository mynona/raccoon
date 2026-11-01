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
                ariaLabel: "Actions",
                triggerText: "Actions",
                options: [
                    SimpleMenuOption(
                        id: "edit",
                        title: "Edit item",
                        clickAction: "alert('Edit clicked')"
                    ),
                    SimpleMenuOption(
                        id: "duplicate",
                        title: "Duplicate",
                        clickAction: "alert('Duplicate clicked')"
                    ),
                    SimpleMenuOption(
                        id: "archive",
                        title: "Archive",
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
                ariaLabel: "Page size",
                triggerText: "25 items",
                options: [
                    SimpleMenuOption(
                        id: "10",
                        title: "10 items",
                        isSelected: false,
                        href: "/preview/simple-menu?per=10"
                    ),
                    SimpleMenuOption(
                        id: "25",
                        title: "25 items",
                        isSelected: true,
                        href: "/preview/simple-menu?per=25"
                    ),
                    SimpleMenuOption(
                        id: "50",
                        title: "50 items",
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
                ariaLabel: "Color theme",
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
                ariaLabel: "User options",
                triggerText: "Profile",
                options: [
                    SimpleMenuOption(
                        id: "account",
                        title: "Account settings",
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
                        title: "Sign out",
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
