// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "KituraTIL",
    dependencies: [
        .package(url: "https://github.com/IBM-Swift/Kitura.git",
                 .upToNextMinor(from: "2.4.1")),
        .package(url: "https://github.com/IBM-Swift/HeliumLogger.git",
                 .upToNextMinor(from: "1.7.1")),
        .package(url: "https://github.com/IBM-Swift/Kitura-CouchDB.git",
                 .upToNextMinor(from: "2.1.0")),
        ],
    targets: [
        .target(name: "KituraTIL",
                dependencies: ["Kitura" , "HeliumLogger", "CouchDB"],
                path: "Sources")
    ]
)
