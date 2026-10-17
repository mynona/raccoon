import DOM
import HTML
import SGML
import SVG
import Testing

@testable import Raccoon

private func renderHTML(_ element: any SGML.Element) -> String {
    Document(root: element).render(indent: 0)
}

/// The modifier-chain implementation of `Svg.icon` before the performance
/// refactor. It is the reference for byte-identical output.
private func legacyIcon(
    _ icon: SvgIcon,
    title: String?,
    width: Int,
    height: Int,
    role: AccessibiliyRoleSvg
) -> SVG {
    let paths = Svg.getPathsForIcon(icon)
    let w = width == 0 ? "100%" : "\(width)px"
    let h = height == 0 ? "100%" : "\(height)px"

    return SVG {
        for path in paths {
            Path(path)
        }
    }
    .viewBox(minX: 0, minY: 0, width: 16, height: 16)
    .if(title != nil) {
        $0.setAttribute(name: "aria-label", value: title!)
    }
    .setAttribute(name: "preserveAspectRatio", value: "xMinYMin meet")
    .fill("currentColor")
    .setAttribute(name: "width", value: w)
    .setAttribute(name: "height", value: h)
    .setAttribute(
        name: "style",
        value:
            "width:\(w);height:\(h);min-width:\(w);min-height:\(h);flex-shrink:0;"
    )
    .setAttribute(name: "xmlns", value: "http://www.w3.org/2000/svg")
    .if(role == .presentation) {
        $0
            .setAttribute(name: "role", value: "presentation")
            .setAttribute(name: "aria-hidden", value: "true")
    }
    .if(role == .img) {
        $0.setAttribute(name: "role", value: "img")
    }
    .if(role == .img && title != nil) {
        $0.setAttribute(name: "aria-label", value: title!)
    }
    .addClass("aspect-square")
    .setAttribute(name: "shape-rendering", value: "geometricPrecision")
    .setAttribute(name: "focusable", value: "false")
}

@Suite("Svg")
struct SvgTests {

    @Test("icon renders byte-identical to the legacy modifier chain")
    func iconMatchesLegacyOutput() {
        let roles: [AccessibiliyRoleSvg] = [.presentation, .img]
        let sizes = [(16, 16), (24, 24), (0, 0), (12, 20)]
        let titles: [String?] = [nil, "Notifications"]
        var mismatches: [String] = []

        for icon in SvgIcon.allCases {
            for role in roles {
                for (width, height) in sizes {
                    for title in titles {
                        let expected = renderHTML(
                            legacyIcon(
                                icon,
                                title: title,
                                width: width,
                                height: height,
                                role: role
                            )
                        )
                        let actual = renderHTML(
                            Svg.icon(
                                icon,
                                title: title,
                                width: width,
                                height: height,
                                role: role
                            )
                        )
                        if actual != expected {
                            mismatches.append(
                                "\(icon) \(role) \(width)x\(height) \(title ?? "-")"
                            )
                        }
                    }
                }
            }
        }

        #expect(mismatches.isEmpty, "\(mismatches.prefix(10))")
    }

    @Test("default icon renders the expected markup")
    func defaultIconSnapshot() {
        let html = renderHTML(Svg.icon(.check))

        #expect(
            html
                == #"<svg viewBox="0 0 16 16" preserveAspectRatio="xMinYMin meet" fill="currentColor" width="16px" height="16px" style="width:16px;height:16px;min-width:16px;min-height:16px;flex-shrink:0;" xmlns="http://www.w3.org/2000/svg" role="presentation" aria-hidden="true" class="aspect-square" shape-rendering="geometricPrecision" focusable="false"><path d="M10.97 4.97a.75.75 0 0 1 1.07 1.05l-3.99 4.99a.75.75 0 0 1-1.08.02L4.324 8.384a.75.75 0 1 1 1.06-1.06l2.094 2.093 3.473-4.425z"></path></svg>"#
        )
    }

    @Test("icon is a single element regardless of its path count")
    func iconRenderBudget() throws {
        let multiPathIcon = try #require(
            SvgIcon.allCases.first { Svg.getPathsForIcon($0).count > 1 }
        )
        let node = try #require(
            Svg.icon(multiPathIcon).node as? StandardNode
        )

        #expect(node.name == "svg")
        #expect(node.properties.count == 12)
        #expect(node.children.allSatisfy { $0 is DOM.InlineText })
    }

    @Test("returned SVG keeps attribute introspection and chaining")
    func iconSupportsModifiers() {
        let icon = Svg.icon(.check, title: "Done", width: 24, role: .img)

        #expect(icon.getAttribute(name: "width") == "24px")
        #expect(icon.getAttribute(name: "height") == "16px")
        #expect(icon.getAttribute(name: "aria-label") == "Done")
        #expect(icon.getAttribute(name: "aria-hidden") == nil)

        let html = renderHTML(
            icon
                .setAttribute(name: "width", value: "32px")
                .addClass("text-red-500")
        )

        #expect(html.contains(#" width="32px" "#))
        #expect(!html.contains(#" width="24px" "#))
        #expect(html.contains(#"class="aspect-square text-red-500""#))
    }

    @Test("prebuilt attributes are not mutated by previous calls")
    func prebuiltAttributesStayUnchanged() {
        _ = Svg.icon(.check, title: "First", width: 40, height: 40, role: .img)
        let html = renderHTML(Svg.icon(.check, title: "Second", role: .img))

        #expect(html.contains(#"aria-label="Second""#))
        #expect(!html.contains("First"))
        #expect(html.contains(#"width="16px""#))
    }
}
