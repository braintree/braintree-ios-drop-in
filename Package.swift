// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BraintreeDropIn",
    defaultLocalization: "en",
    platforms: [.iOS(.v12)],
    products: [
        .library(
            name: "BraintreeDropIn",
            targets: ["BraintreeDropIn", "BraintreeThreeDSecure"]
        ),
        .library(
            name: "BraintreeUIKit",
            targets: ["BraintreeUIKit"]
        )
    ],
    dependencies: [
        .package(name: "Braintree", url: "https://github.com/braintree/braintree_ios.git", from: "5.0.0-beta1")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "BraintreeDropIn",
            dependencies: [
                .product(name: "BraintreeCard", package: "Braintree"),
                .product(name: "BraintreeCore", package: "Braintree"),
                .product(name: "BraintreeUnionPay", package: "Braintree"),
                .product(name: "BraintreePaymentFlow", package: "Braintree"),
                .product(name: "BraintreePayPal", package: "Braintree"),
                .product(name: "PayPalDataCollector", package: "Braintree"),
                .target(name: "BraintreeUIKit")
            ],
            exclude: ["Info.plist"],
            publicHeadersPath: "Public",
            cSettings: [
                .headerSearchPath("Custom Views")
            ]
        ),
        .target(
            name: "BraintreeUIKit",
            exclude: ["Info.plist"],
            publicHeadersPath: "Public",
            cSettings: [
                .headerSearchPath("Components"),
                .headerSearchPath("Vector Art"),
                .headerSearchPath("Vector Art/Large")
            ]
        ),
        .binaryTarget(
            // https://developer.apple.com/documentation/swift_packages/distributing_binary_frameworks_as_swift_packages
            name: "BraintreeThreeDSecure",
            url: "https://github.com/braintree/braintree_ios/releases/download/5.0.0-beta1/Braintree-xcframeworks.zip",
            checksum: "8a2a49ae1dd3c8119787ce9dfbbeabe2216740be1dfb3a1d3156682d349d5a4f"
            // TODO - add rake task to BT iOS that takes a version tag and generates checksum
        )
    ]
)
