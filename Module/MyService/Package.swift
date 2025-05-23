// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MyService",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "MyService",
            targets: ["MyService"]),
    ],
    dependencies: [
        .package(path: "../..")
    ],
    targets: [
        .target(
            name: "MyService", dependencies: ["SwiftUIRouter"]),
    ]
)
