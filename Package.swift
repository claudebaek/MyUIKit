// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MyUIKit",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "MyUIKit",
            type: .static,
            targets: ["MyUIKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/malcommac/SwiftRichString", .upToNextMajor(from: "3.0.0")),
        .package(url: "https://github.com/SnapKit/SnapKit", .upToNextMajor(from: "5.0.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "MyUIKit",
            dependencies: [
                "SwiftRichString",
                "SnapKit"
                          ]),
        .testTarget(
            name: "MyUIKitTests",
            dependencies: ["MyUIKit"]),
    ]
)
