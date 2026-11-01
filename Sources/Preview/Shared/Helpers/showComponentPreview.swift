import Foundation
import HTML
import Raccoon
import SGML
import Vapor
import WebBuilders

private func stripLeadingComments(_ data: String) -> String {
    var lines = data.components(separatedBy: .newlines)
    while let first = lines.first,
        first.trimmingCharacters(in: .whitespaces).hasPrefix("//")
            || first.trimmingCharacters(in: .whitespaces).isEmpty
    {
        lines.removeFirst()
    }
    return lines.joined(separator: "\n")
}

/// Renders a component preview with three tabs: Preview, Data, and HTML.
@Builder<Element>
func showComponentPreview(
    id: String = UUID().uuidString.prefix(8).lowercased(),
    data: String,
    html: String,
    @Builder<Element> preview: () -> [Element]
) -> [Element] {
    let tabGroupId = "tg-\(id)"
    let cleanData = stripLeadingComments(data)

    Div {
        TabGroup(
            TabGroupData(
                id: tabGroupId,
                ariaLabel: "Preview, API, and HTML code",
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
                        label: "API",
                        content: .element {
                            Div {
                                showCopyableData(cleanData)
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
