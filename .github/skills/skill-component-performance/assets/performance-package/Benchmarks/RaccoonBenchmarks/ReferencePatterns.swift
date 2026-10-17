import Benchmark
import Foundation
import HTML
import Raccoon
import SGML
import Synchronization
import WebBuilders

// Reference micro-benchmarks behind the cost table in
// references/rendering-pipeline.md §6. Re-run after upgrading swift-web-standards:
//   swift package --disable-sandbox benchmark --filter "Pattern/.*"
// If the numbers move significantly, update the skill.

private let preRenderedHead = html([MasterHead.cmsHead])
private let iconCache = Mutex<[String: String]>([:])

private func cachedIcon(_ icon: SvgIcon, size: Int) -> String {
    let key = "\(icon.rawValue)|\(size)"
    if let hit = iconCache.withLock({ $0[key] }) { return hit }
    let rendered = html([Svg.icon(icon, width: size, height: size)])
    iconCache.withLock { $0[key] = rendered }
    return rendered
}

func registerReferencePatternBenchmarks() {
    let configuration = Benchmark.Configuration(
        metrics: [.mallocCountTotal, .instructions],
        maxDuration: .seconds(1)
    )

    Benchmark("Pattern/element Span", configuration: configuration) { b in
        for _ in b.scaledIterations { blackHole(html([Span("x")])) }
    }
    Benchmark("Pattern/element Span + wrapper Div", configuration: configuration) { b in
        for _ in b.scaledIterations { blackHole(html([Div { Span("x") }])) }
    }
    Benchmark("Pattern/element + Comment", configuration: configuration) { b in
        for _ in b.scaledIterations { blackHole(html([Div { Comment("Button"); Span("x") }])) }
    }
    Benchmark("Pattern/class variadic ×6", configuration: configuration) { b in
        for _ in b.scaledIterations {
            blackHole(html([Div {}.class("flex", "items-center", "justify-center", "w-full", "rounded-md", "px-4")]))
        }
    }
    Benchmark("Pattern/class single string", configuration: configuration) { b in
        for _ in b.scaledIterations {
            blackHole(html([Div {}.class("flex items-center justify-center w-full rounded-md px-4")]))
        }
    }
    Benchmark("Pattern/10 chained setAttribute", configuration: configuration) { b in
        for _ in b.scaledIterations {
            var div = Div {}
            for j in 0..<10 { div = div.setAttribute(name: "data-a\(j)", value: "v") }
            blackHole(html([div]))
        }
    }
    Benchmark("Pattern/static let Head", configuration: configuration) { b in
        for _ in b.scaledIterations { blackHole(html([MasterHead.cmsHead])) }
    }
    Benchmark("Pattern/pre-rendered String", configuration: configuration) { b in
        for _ in b.scaledIterations { blackHole(html([Div { InlineText(preRenderedHead, isRaw: true) }])) }
    }
    Benchmark("Pattern/Svg.icon fresh", configuration: configuration) { b in
        for _ in b.scaledIterations { blackHole(html([Div { Svg.icon(.check) }])) }
    }
    Benchmark("Pattern/Svg.icon cached String", configuration: configuration) { b in
        for _ in b.scaledIterations {
            blackHole(html([Div { InlineText(cachedIcon(.check, size: 16), isRaw: true) }]))
        }
    }
    Benchmark("Pattern/UUID fallback id", configuration: configuration) { b in
        for _ in b.scaledIterations { blackHole("tooltip-\(UUID().uuidString.prefix(8).lowercased())") }
    }
    Benchmark("Pattern/renderMarkdownAsHTML sentence", configuration: configuration) { b in
        for _ in b.scaledIterations {
            blackHole(renderMarkdownAsHTML("Some **bold** text with a [link](https://example.com)."))
        }
    }
}
