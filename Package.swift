// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BraintreeDropIn",
    defaultLocalization: "en",
    platforms: [.iOS(.v12)],
    products: [
//        .library(
//            name: "BraintreeDropIn",
//            targets: ["BraintreeDropIn"]
//        ),
        .library(
            name: "BraintreeUIKit",
            targets: ["BraintreeUIKit"]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        // .target(
        //     name: "BraintreeAmericanExpress",
        //     dependencies: ["BraintreeCore"],
        //     exclude: ["Info.plist"],
        //     publicHeadersPath: "Public"
        // ),
        .target(
            name: "BraintreeUIKit",
            exclude: ["Info.plist"],
            publicHeadersPath: "Public",
            cSettings: [
                .headerSearchPath("Components"),
                .headerSearchPath("Vector Art"),
                .headerSearchPath("Vector Art/Large")
            ]
        )
    ]
)
