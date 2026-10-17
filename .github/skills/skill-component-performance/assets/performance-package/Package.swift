// swift-tools-version:6.0
import PackageDescription

// Standalone benchmark package for Raccoon render performance.
//
// Lives in <repo>/Performance and depends on the library by path, so the library's own
// Package.swift never pulls in package-benchmark or jemalloc for downstream consumers.
//
// Requirements: `brew install jemalloc` (macOS) / `apt-get install libjemalloc-dev` (Linux).
// Run:          cd Performance && swift package --disable-sandbox benchmark
//
// NOTE: the identity of a path dependency is the *directory name* of the checkout.
// If the repository is cloned into a folder not named `raccoon`, change `package: "raccoon"`
// below to that folder name (e.g. `swift-web-components`).
let package = Package(
    name: "raccoon-performance",
    platforms: [.macOS(.v15)],
    dependencies: [
        .package(path: ".."),
        .package(url: "https://github.com/ordo-one/package-benchmark.git", from: "1.36.0"),
        .package(url: "https://github.com/BinaryBirds/swift-web-standards.git", exact: "1.0.0-beta.4"),
        .package(url: "https://github.com/vapor/vapor.git", from: "4.122.2"),
    ],
    targets: [
        .executableTarget(
            name: "RaccoonBenchmarks",
            dependencies: [
                .product(name: "Raccoon", package: "raccoon"),
                .product(name: "Benchmark", package: "package-benchmark"),
                .product(name: "HTML", package: "swift-web-standards"),
                .product(name: "SGML", package: "swift-web-standards"),
                .product(name: "WebBuilders", package: "swift-web-standards"),
                .product(name: "Vapor", package: "vapor"),
            ],
            path: "Benchmarks/RaccoonBenchmarks",
            plugins: [
                .plugin(name: "BenchmarkPlugin", package: "package-benchmark")
            ]
        )
    ]
)
