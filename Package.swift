// swift-tools-version:5.5

// Package.swift
// Swift Package Manager manifest for FaustUIWrapper

import PackageDescription

let package = Package(
    name: "FaustSwiftUI",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "FaustSwiftUI",
            targets: ["FaustSwiftUI"]
        )
    ],
    targets: [
        .target(
            name: "FaustSwiftUI",
            dependencies: [],
            path: "Sources/",
            resources: []
        ),
        .testTarget(
            name: "FaustUIWrapperTests",
            dependencies: ["FaustSwiftUI"],
            path: "Tests/"
        )
    ]
)
