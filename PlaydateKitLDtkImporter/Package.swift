// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PlaydateKitLDtkImporter",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "PlaydateKitLDtkImporter",
            targets: ["PlaydateKitLDtkImporter"])
    ],
    dependencies: [
        // Add dependencies here if needed for PlaydateKit integration
        // .package(url: "https://github.com/PlaydateKit/PlaydateKit", from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "PlaydateKitLDtkImporter",
            dependencies: [
                // Add PlaydateKit dependency when available
                // "PlaydateKit"
            ],
            path: "Sources/PlaydateKitLDtkImporter"
        ),
        .testTarget(
            name: "PlaydateKitLDtkImporterTests",
            dependencies: ["PlaydateKitLDtkImporter"],
            path: "Tests/PlaydateKitLDtkImporterTests"
        ),
    ]
)
