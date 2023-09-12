// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "swift-xml",
    products: [
        .library(
            name: "XML",
            targets: ["XML"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing.git", from: "1.12.0")
    ],
    targets: [
        .target(name: "XML"),
        .testTarget(name: "XMLTests", dependencies: [
            "XML",
            .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
        ]),
    ]
)
