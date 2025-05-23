// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TripModule",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "TripModule",
            targets: ["TripModule"]),
    ],
    dependencies: [
        .package(path: "../MyService")
    ],
    targets: [
        .target(
        name: "TripModule", dependencies: ["MyService"]),

    ]
)
