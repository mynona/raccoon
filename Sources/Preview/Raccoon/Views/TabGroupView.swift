import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct TabGroupView: TemplateRepresentable {

    let variants: [(String, TabGroupData)] = [
        (
            """
            // Underline Variant (Default) with Icons & Badges
            """,
            TabGroupData(
                id: "tabs-underline-demo",
                ariaLabel: "Social Activity Tabs",
                tabs: [
                    TabItemData(
                        id: "groups",
                        label: "Groups",
                        content: .markdown(
                            "### Groups Overview\n\nYou are a member of **4 active groups**. Explore discussions, events, and shared files."
                        ),
                        isDefaultSelected: true,
                        icon: .people,
                        badgeCount: 4
                    ),
                    TabItemData(
                        id: "likes",
                        label: "Likes",
                        content: .html(
                            "<p class='text-base leading-relaxed'>Your posts have received <strong>3,124 likes</strong> across all published articles.</p>"
                        ),
                        icon: .heart,
                        badgeCount: 3124
                    ),
                    TabItemData(
                        id: "comments",
                        label: "Comments",
                        content: .markdown(
                            "### Recent Comments\n\n- *Great article on Swift server components!*\n- *Can you share more on Alpine.js integration?*"
                        ),
                        icon: .chat_dots,
                        badgeCount: 243
                    ),
                    TabItemData(
                        id: "saved",
                        label: "Saved",
                        content: .html(
                            "<p class='text-base leading-relaxed'>You have <strong>32 bookmarks</strong> saved for later reading.</p>"
                        ),
                        icon: .bookmark,
                        badgeCount: 32
                    ),
                ],
                variant: .underline
            )
        ),
        (
            """
            // Pills Variant
            """,
            TabGroupData(
                id: "tabs-pills-demo",
                ariaLabel: "Framework View Tabs",
                tabs: [
                    TabItemData(
                        id: "swift",
                        label: "Swift",
                        content: .markdown(
                            "```swift\nlet message = \"Hello from Raccoon!\"\nprint(message)\n```"
                        ),
                        isDefaultSelected: true,
                        icon: .code_slash
                    ),
                    TabItemData(
                        id: "vapor",
                        label: "Vapor",
                        content: .markdown(
                            "```swift\napp.get(\"hello\") { req in\n    return \"Hello, world!\"\n}\n```"
                        ),
                        icon: .terminal
                    ),
                    TabItemData(
                        id: "alpine",
                        label: "Alpine.js",
                        content: .html(
                            "<pre class='p-3 bg-gray-100 dark:bg-gray-800 rounded'><code>&lt;div x-data=\"{ open: false }\"&gt;...&lt;/div&gt;</code></pre>"
                        ),
                        icon: .layers
                    ),
                    TabItemData(
                        id: "archive",
                        label: "Archived",
                        content: .html(
                            "<p>This archive is currently read-only.</p>"
                        ),
                        state: .disabled,
                        icon: .archive
                    ),
                ],
                variant: .pills
            )
        ),
        (
            """
            // Vertical Orientation (Pills Variant)
            """,
            TabGroupData(
                id: "tabs-vertical-pills-demo",
                ariaLabel: "Account Settings",
                tabs: [
                    TabItemData(
                        id: "profile",
                        label: "Profile",
                        content: .markdown(
                            "### Public Profile\nManage your display name, bio, and avatar."
                        ),
                        isDefaultSelected: true,
                        icon: .person_circle
                    ),
                    TabItemData(
                        id: "security",
                        label: "Security",
                        content: .markdown(
                            "### Security Settings\nConfigure two-factor authentication and active session keys."
                        ),
                        icon: .shield_lock
                    ),
                    TabItemData(
                        id: "notifications",
                        label: "Notifications",
                        content: .markdown(
                            "### Notification Preferences\nChoose email and webhook alert frequencies."
                        ),
                        icon: .bell,
                        badgeCount: 2
                    ),
                ],
                variant: .pills,
                orientation: .vertical
            )
        ),
        (
            """
            // Vertical Orientation (Underline Variant)
            """,
            TabGroupData(
                id: "tabs-vertical-underline-demo",
                ariaLabel: "Project Management Tabs",
                tabs: [
                    TabItemData(
                        id: "tasks",
                        label: "Tasks",
                        content: .markdown(
                            "### Active Tasks\nView pending sprint items and assignees."
                        ),
                        isDefaultSelected: true,
                        icon: .check2_square,
                        badgeCount: 7
                    ),
                    TabItemData(
                        id: "milestones",
                        label: "Milestones",
                        content: .markdown(
                            "### Milestones\nTrack target release dates and progress."
                        ),
                        icon: .flag
                    ),
                    TabItemData(
                        id: "reports",
                        label: "Reports",
                        content: .markdown(
                            "### Analytics & Velocity\nReview sprint burn-down and throughput."
                        ),
                        icon: .graph_up,
                        badgeText: "New"
                    ),
                ],
                variant: .underline,
                orientation: .vertical
            )
        ),
    ]

    func makeHtml(ctx: TabGroupData) -> String {
        let html = renderFragments(TabGroup(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {
        Basic {
            Div {
                showComponentTitle("TabGroup")

                for (label, ctx) in variants {
                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { TabGroup(ctx).render() }
                            .class("mb-4 mt-4")
                    }
                }
            }
            .class("mt-4 space-y-6")
        }
        .render()
    }
}
