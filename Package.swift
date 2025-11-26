// swift-tools-version: 5.9
// @author Dambert Muñoz

import PackageDescription

let package = Package(
    name: "PropertyWrapperKit",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "PropertyWrapperKit",
            targets: ["PropertyWrapperKit"]
        )
    ],
    targets: [
        .target(
            name: "PropertyWrapperKit",
            dependencies: [],
            path: "Sources/PropertyWrapperKit"
        ),
        .testTarget(
            name: "PropertyWrapperKitTests",
            dependencies: ["PropertyWrapperKit"],
            path: "Tests/PropertyWrapperKitTests"
        )
    ]
)
