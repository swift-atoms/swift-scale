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

        .library(name: "Scale Foundation Integration", targets: ["Scale Foundation Integration"]),
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
            name: "Scale Foundation Integration",
            dependencies: [
                .target(name: "Scale"),
            ],
            path: "Sources/Scale Foundation Integration"
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
            ],
            path: "Tests/Scale Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    target.swiftSettings = (target.swiftSettings ?? []) + [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableExperimentalFeature("Lifetimes"),
        .treatAllWarnings(as: .error),
    ]
}
