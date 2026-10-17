// swift-tools-version:6.3
import PackageDescription

let package = Package(
    name: "raccoon",
    platforms: [
        .macOS(.v15)
    ],
    products: [
        .library(
            name: "Raccoon",
            targets: ["Raccoon"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/vapor/vapor.git",
            from: "4.122.2"
        ),
        .package(
            url: "https://github.com/BinaryBirds/swift-web-standards.git",
            exact: "1.0.0-beta.4"
        ),
        .package(
            url: "https://github.com/swiftlang/swift-markdown.git",
            from: "0.9.0"
        ),
        .package(
            url: "https://github.com/scinfu/SwiftSoup.git",
            from: "2.6.0"
        ),
        // swift-collections 1.7.0 needs the Swift 6.4 runtime symbol
        // `swift_initBorrow`, which macOS 26 does not ship.
        .package(
            url: "https://github.com/apple/swift-collections.git",
            "1.1.0"..<"1.7.0"
        ),
    ],
    targets: [
        .target(
            name: "Raccoon",
            dependencies: [
                .product(
                    name: "HTML",
                    package: "swift-web-standards"
                ),
                .product(
                    name: "SVG",
                    package: "swift-web-standards"
                ),
                .product(
                    name: "WebBuilders",
                    package: "swift-web-standards"
                ),
                .product(
                    name: "Markdown",
                    package: "swift-markdown"
                ),
            ]
        ),
        .testTarget(
            name: "RaccoonTests",
            dependencies: [
                .target(
                    name: "Raccoon"
                ),
                .product(
                    name: "HTML",
                    package: "swift-web-standards"
                ),
                .product(
                    name: "SGML",
                    package: "swift-web-standards"
                ),
                .product(
                    name: "WebBuilders",
                    package: "swift-web-standards"
                ),
            ],
            path: "Tests/RaccoonTests"
        ),
        .executableTarget(
            name: "Preview",
            dependencies: [
                .target(
                    name: "Raccoon"
                ),
                .product(
                    name: "SwiftSoup",
                    package: "SwiftSoup"
                ),
                .product(
                    name: "Vapor",
                    package: "vapor"
                ),
                .product(
                    name: "HTML",
                    package: "swift-web-standards"
                ),
                .product(
                    name: "SGML",
                    package: "swift-web-standards"
                ),
                .product(
                    name: "WebBuilders",
                    package: "swift-web-standards"
                ),
            ],
            path: "Sources/Preview"
        ),
    ]
)
