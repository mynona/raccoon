import Benchmark
import Foundation
import HTML
import Raccoon
import SGML
import Vapor
import WebBuilders

// Components only need a Request to satisfy `TemplateRepresentable.render(_:)`.
nonisolated(unsafe) private var app: Application!
nonisolated(unsafe) private var request: Request!

private let tracker = MatomoContentTracker(name: "bench", piece: "button", target: "#")

/// Full pipeline, identical to `TemplateRenderer.renderHtml`: build → DOM node → String.
/// Always measure through this helper; measuring `render(request)` alone hides ~40 % of the cost.
@inline(__always)
func html(_ elements: [SGML.Element]) -> String {
    elements.map { Document(type: .unspecified, root: $0).render(indent: 0) }.joined()
}

let benchmarks: @Sendable () -> Void = {
    // Malloc counts and instructions are deterministic → use them for regression checks.
    // Wall clock is noisy and is inflated by jemalloc → use it only for relative comparisons.
    Benchmark.defaultConfiguration = .init(
        metrics: [
            .wallClock,
            .cpuTotal,
            .instructions,
            .mallocCountTotal,
            .peakMemoryResident,
        ],
        maxDuration: .seconds(2),
        maxIterations: 10_000
    )

    Benchmark.setup = {
        app = try await Application.make(.testing)
        request = Request(application: app, on: app.eventLoopGroup.next())
    }
    Benchmark.teardown = {
        try await app.asyncShutdown()
    }

    registerReferencePatternBenchmarks()

    // MARK: - leaf components (rendered 30–150× per page → highest leverage)
    //
    // Add one benchmark per variant that changes the DOM shape (plain, with icon, with tooltip…).
    // Name: "<Component>/<variant>" so `--filter "ActionButton/.*"` works.

    Benchmark("ActionButton/label+icon") { benchmark in
        for _ in benchmark.scaledIterations {
            blackHole(
                html(
                    ActionButton(
                        ActionButtonData(
                            clickAction: "save()",
                            label: "Save",
                            buttonType: .primary,
                            icon: .check,
                            contentTracker: tracker
                        )
                    )
                    .render(request)
                )
            )
        }
    }

    Benchmark("ActionButton/label+icon+tooltip") { benchmark in
        for _ in benchmark.scaledIterations {
            blackHole(
                html(
                    ActionButton(
                        ActionButtonData(
                            clickAction: "save()",
                            label: "Save",
                            tooltip: "Saves the draft",
                            buttonType: .primary,
                            icon: .check,
                            contentTracker: tracker
                        )
                    )
                    .render(request)
                )
            )
        }
    }

    Benchmark("HyperLink/label") { benchmark in
        for _ in benchmark.scaledIterations {
            blackHole(
                html(
                    HyperLink(
                        HyperLinkData(
                            label: "Read more",
                            href: "/blog/x",
                            icon: nil,
                            isFocusable: true,
                            isUnderlined: true,
                            contentTracker: tracker
                        )
                    )
                    .render(request)
                )
            )
        }
    }

    // MARK: - composite (models nested rendering of a realistic page)

    Benchmark(
        "Page/100×ActionButton",
        configuration: .init(maxDuration: .seconds(3), maxIterations: 500)
    ) { benchmark in
        for _ in benchmark.scaledIterations {
            blackHole(
                html([
                    Div {
                        for i in 0..<100 {
                            ActionButton(
                                ActionButtonData(
                                    label: "Item \(i)",
                                    buttonType: .secondary,
                                    contentTracker: tracker
                                )
                            )
                            .render(request)
                        }
                    }
                ])
            )
        }
    }

    // MARK: - SVG icons (embedded in most buttons/links → multiply by instances per page)

    Benchmark("Svg/icon check 16") { benchmark in
        for _ in benchmark.scaledIterations {
            blackHole(html([Svg.icon(.check, width: 16, height: 16)]))
        }
    }

    // MARK: - templates

    Benchmark("MasterHead/cmsHead") { benchmark in
        for _ in benchmark.scaledIterations {
            blackHole(html([MasterHead.cmsHead]))
        }
    }
}
