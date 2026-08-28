// swift-tools-version: 6.3

import PackageDescription

let package = Package(
    name: "AgenticSkills",
    platforms: [
        .macOS(.v13),
    ],
    products: [
        .library(
            name: "AgenticSkills",
            targets: [
                "AgenticSkills",
            ]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/leviouwendijk/Agentic.git",
            branch: "master"
        ),
        .package(
            url: "https://github.com/leviouwendijk/AgenticIO.git",
            branch: "master"
        ),
    ],
    targets: [
        .target(
            name: "AgenticSkills",
            dependencies: [
                .product(
                    name: "Agentic",
                    package: "Agentic"
                ),
                .product(
                    name: "AgenticIO",
                    package: "AgenticIO"
                ),
            ]
        ),
    ],
    swiftLanguageModes: [
        .v6,
    ]
)
