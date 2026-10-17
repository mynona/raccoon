import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct SimpleMenuView: TemplateRepresentable {

    let variants: [(String, SimpleMenuData)] = [
        (
            """
            // Action Menu with Text & Chevron Trigger
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
        (
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
        (
            """
            // Icon-Only Trigger Button (ThemeSwitcher pattern)
            """,
            SimpleMenuData(
                ariaLabel: "Color theme",
                options: [
                    SimpleMenuOption(
                        id: "theme-default",
                        title: "Raumnebenan",
                        isSelected: true,
                        clickAction: "alert('Raumnebenan theme')"
                    ),
                    SimpleMenuOption(
                        id: "theme-bw",
                        title: "Black & White",
                        isSelected: false,
                        clickAction: "alert('B&W theme')"
                    ),
                ],
                width: "w-48",
                triggerIcon: .palette2,
                hasTriggerChevron: false
            )
        ),
        (
            """
            // Right-Aligned Panel
            """,
            SimpleMenuData(
                ariaLabel: "User options",
                triggerText: "Profile",
                options: [
                    SimpleMenuOption(
                        id: "account",
                        title: "Account settings",
                        clickAction: "alert('Account')"
                    ),
                    SimpleMenuOption(
                        id: "logout",
                        title: "Log out",
                        clickAction: "alert('Logout')"
                    ),
                ],
                align: .right,
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

                for (label, ctx) in variants {
                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div {
                            SimpleMenu(ctx).render()
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
