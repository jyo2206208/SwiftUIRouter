// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUIRouter",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SwiftUIRouter",
            targets: ["SwiftUIRouter"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SwiftUIRouter",
            path: "Source",
            exclude: ["../Example"],
            sources: ["EnvironmentValues+Router.swift", "RouteDestination.swift", "Router.swift"]),
    ]
)
