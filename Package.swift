// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Networking",
    platforms: [
        .macOS(.v12), .iOS(.v15)
    ],
    products: [
        .library(
            name: "Networking",
            targets: ["Networking"]
        ),
        .library(
            name: "NetworkingInterface",
            targets: ["NetworkingInterface"]
        ),
        .library(
            name: "NetworkingInterfaceTestUtils",
            targets: ["NetworkingInterfaceTestUtils"]
        )
    ],
    targets: [
        // MARK: - Networking
        .target(
            name: "Networking",
            dependencies: ["NetworkingInterface"]
        ),
        .testTarget(
            name: "NetworkingTests",
            dependencies: ["Networking", "NetworkingInterfaceTestUtils"]
        ),
        
        // MARK: - NetworkingInterface
        .target(
            name: "NetworkingInterface",
            dependencies: []
        ),
        .target(
            name: "NetworkingInterfaceTestUtils",
            dependencies: ["NetworkingInterface"]
        ),
    ]
)
