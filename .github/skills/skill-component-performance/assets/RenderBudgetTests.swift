// Template: copy to Tests/AppTests/RenderBudgetTests.swift
//
// Deterministic structural budgets — no timing, no jemalloc, safe for CI on any machine.
// Element and attribute counts are the best cheap proxy for render cost: every element costs
// ~11–17 mallocs and every attribute is paid in all three render phases.
//
// Requires the DOM product in the AppTests target (Package.swift):
//     .product(name: "DOM", package: "swift-web-standards"),

import DOM
import HTML
import SGML
import Testing
import Vapor

@testable import Raccoon

struct RenderStats: Equatable, CustomStringConvertible {
    var elements = 0
    var attributes = 0
    var comments = 0
    var maxDepth = 0
    var bytes = 0

    var description: String {
        "elements=\(elements) attributes=\(attributes) comments=\(comments) maxDepth=\(maxDepth) bytes=\(bytes)"
    }

    init(_ rendered: [any SGML.Element]) {
        let nodes = rendered.map(\.node)
        nodes.forEach { visit($0, depth: 1) }
        bytes = nodes.map { $0.render(indent: 0) }.joined().utf8.count
    }

    private mutating func visit(_ node: any Node, depth: Int) {
        switch node {
        case let list as ListNode:
            list.items.forEach { visit($0, depth: depth) }
        case let element as StandardNode:
            elements += 1
            attributes += element.properties.count
            maxDepth = max(maxDepth, depth)
            element.children.forEach { visit($0, depth: depth + 1) }
        case let element as ShortNode:
            elements += 1
            attributes += element.properties.count
            maxDepth = max(maxDepth, depth)
        case is CommentNode:
            comments += 1
        default:
            break
        }
    }
}

private let tracker = MatomoContentTracker(name: "test", piece: "budget", target: "#")

@Suite("Render budgets")
struct RenderBudgetTests {

    // Budgets are ceilings. When a change lowers the numbers, lower the budget in the same PR,
    // so the gain cannot silently regress later.

    @Test("ActionButton without optional features stays within budget")
    func actionButtonBudget() async throws {
        let (app, req) = try await makeRequest()
        defer { Task { try? await app.asyncShutdown() } }

        let stats = RenderStats(
            ActionButton(
                ActionButtonData(label: "Save", buttonType: .primary, contentTracker: tracker)
            )
            .render(req)
        )

        // Baseline measured 2026-10 (elements=4 attributes=6 comments=1 bytes=932).
        #expect(stats.elements <= 4, "\(stats)")
        #expect(stats.attributes <= 6, "\(stats)")
        // Target is 0: leaf components should not emit Comment nodes. Tighten once removed.
        #expect(stats.comments <= 1, "\(stats)")
    }

    @Test("HyperLink without icon or tooltip stays within budget")
    func hyperLinkBudget() async throws {
        let (app, req) = try await makeRequest()
        defer { Task { try? await app.asyncShutdown() } }

        let html = RenderStats(
            HyperLink(
                HyperLinkData(
                    label: "Read more",
                    href: "/x",
                    icon: nil,
                    isFocusable: true,
                    isUnderlined: true,
                    contentTracker: tracker
                )
            )
            .render(req)
        )
        // Baseline measured 2026-10 (elements=3 attributes=5 comments=1 bytes=816).
        #expect(html.elements <= 3, "\(html)")
        #expect(html.attributes <= 5, "\(html)")
    }
}
