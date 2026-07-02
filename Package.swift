// swift-tools-version: 6.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LicenseKit",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .tvOS(.v16),
        .watchOS(.v9),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "LicenseKit",
            targets: ["LicenseKit"]
        ),
        .plugin(
            name: "LicenseSettingsBundleCommand",
            targets: [
                "GenerateLicenseSettingsBundle"
            ]
        ),
        .plugin(
            name: "LicenseSwiftSource",
            targets: [
                "LicenseSwiftSourcePlugin"
            ]
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "LicenseKit",
            swiftSettings: [
                .enableUpcomingFeature("ApproachableConcurrency"),
            ],
        ),
        .target(
            name: "LicenseKitCore",
            swiftSettings: [
                .enableUpcomingFeature("ApproachableConcurrency"),
            ],
        ),
        .plugin(
            name: "GenerateLicenseSettingsBundle",
            capability: .command(
                intent: .custom(
                    verb: "generate-license-settings-bundle",
                    description: "Generate license plist files in Settings.bundle from Swift package dependencies."
                ),
                permissions: [
                    .writeToPackageDirectory(reason: "Requires permission to write generated plist files into the project's Settings.bundle directory.")
                ]
            ),
            dependencies: [
                .target(name: "LicenseSettingsBundleTool")
            ]
        ),
        .plugin(
            name: "LicenseSwiftSourcePlugin",
            capability: .buildTool(),
            dependencies: [
                .target(name: "LicenseSwiftSourceGenerator")
            ]
        ),
        .executableTarget(name: "LicenseSwiftSourceGenerator"),
        .executableTarget(
            name: "LicenseSettingsBundleTool",
            dependencies: [
                .target(name: "LicenseKitCore")
            ]
        ),
        .testTarget(
            name: "LicenseKitTests",
            dependencies: ["LicenseKit"],
            swiftSettings: [
                .enableUpcomingFeature("ApproachableConcurrency"),
            ],
        ),
        .testTarget(
            name: "LicenseKitCoreTests",
            dependencies: ["LicenseKitCore"],
            swiftSettings: [
                .enableUpcomingFeature("ApproachableConcurrency"),
            ],
        ),
    ],
    swiftLanguageModes: [.v6]
)
