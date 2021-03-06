// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.
// https://github.com/apple/swift-package-manager/blob/master/Documentation/PackageDescriptionV4.md
// https://github.com/apple/swift-package-manager/blob/master/Sources/PackageDescription4/Target.swift#L83
// https://medium.com/@johnsundell/building-a-command-line-tool-using-the-swift-package-manager-3dd96ce360b1


import PackageDescription

let package = Package(
    name: "CommandLineTool",
    products: [
        .executable(name: "CommandLineTool", targets: ["CommandLineTool"]),
        .library(name: "CommandLineToolCore", targets: ["CommandLineToolCore"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-package-manager.git",
            .branch("master")
            // from: "swift-3.1-DEVELOPMENT-SNAPSHOT-2017-06-12-a"
        ),
    ],
    targets: [
        .target(name: "CommandLineToolCore", dependencies: []),
        .target(name: "CommandLineTool", dependencies: [
            .target(name: "CommandLineToolCore"),
        ]),
        .testTarget(
            name: "CommandLineToolCoreTests",
            dependencies: [
                .target(name: "CommandLineToolCore"),
                // Utilities in SwiftPM.Basic for TemporaryFile
                "SwiftPM",
            ]
        ),
    ],
    swiftLanguageVersions: [4]
)
