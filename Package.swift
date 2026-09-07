// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-scale",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(name: "Scale", targets: ["Scale"]),
        .library(name: "Scale Standard Library Integration", targets: ["Scale Standard Library Integration"]),
        .library(name: "Scale Foundation Library Integration", targets: ["Scale Foundation Library Integration"]),
        .library(name: "Scale Test Support", targets: ["Scale Test Support"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Scale",
            dependencies: [
            ],
            path: "Sources/Scale"
        ),
        .target(
            name: "Scale Standard Library Integration",
            dependencies: [
                .target(name: "Scale"),
            ],
            path: "Sources/Scale Standard Library Integration"
        ),
        .target(
            name: "Scale Foundation Library Integration",
            dependencies: [
                .target(name: "Scale"),
                .target(name: "Scale Standard Library Integration"),
            ],
            path: "Sources/Scale Foundation Library Integration"
        ),
        .target(
            name: "Scale Test Support",
            dependencies: [
                .target(name: "Scale"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Scale Tests",
            dependencies: [
                .target(name: "Scale"),
                .target(name: "Scale Test Support"),
                .target(name: "Scale Standard Library Integration"),
                .target(name: "Scale Foundation Library Integration"),
            ],
            path: "Tests/Scale Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets {
    target.swiftSettings = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]
}
