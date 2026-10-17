import Foundation
import HTML
import Raccoon
import SGML
import Vapor
import WebBuilders

/// Renders a component preview with three tabs: Preview, Data, and HTML.
@Builder<Element>
func showComponentPreview(
    id: String = UUID().uuidString.prefix(8).lowercased(),
    data: String,
    html: String,
    @Builder<Element> preview: () -> [Element]
) -> [Element] {
    let tabGroupId = "tg-\(id)"

    Div {
        TabGroup(
            TabGroupData(
                id: tabGroupId,
                ariaLabel: "Preview, Data, and HTML code",
                tabs: [
                    TabItemData(
                        id: "\(tabGroupId)-preview",
                        label: "Preview",
                        content: .element {
                            Div {
                                preview()
                            }
                            .class("py-4")
                        },
                        isDefaultSelected: true
                    ),
                    TabItemData(
                        id: "\(tabGroupId)-data",
                        label: "Data",
                        content: .element {
                            Div {
                                showCopyableData(data)
                            }
                        }
                    ),
                    TabItemData(
                        id: "\(tabGroupId)-html",
                        label: "HTML",
                        content: .element {
                            Div {
                                showCopyableCode(html)
                            }
                        }
                    ),
                ],
                variant: .pills
            )
        )
        .render()
    }
    .class("mb-12 mt-4")
}
