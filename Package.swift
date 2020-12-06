// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ActionSheetPicker-3.0",
    products: [
        .library(
            name: "ActionSheetPicker-3.0",
            targets: ["CoreActionSheetPicker"]),
    ],
    targets: [
        .target(
            name: "CoreActionSheetPicker",
            dependencies: [],
            path: "CoreActionSheetPicker/CoreActionSheetPicker",
            publicHeadersPath: "Pickers"
        )
    ],

    swiftLanguageVersions: [.v5]
)
