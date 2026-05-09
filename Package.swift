// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "PowerNapToggler",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(name: "PowerNapToggler", targets: ["PowerNapToggler"])
    ],
    targets: [
        .executableTarget(
            name: "PowerNapToggler",
            path: "Sources/PowerNapToggler"
        )
    ]
)
