// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BraintreeDropIn",
    defaultLocalization: "en",
    platforms: [.iOS(.v12)],
    products: [
        .library(
            name: "BraintreeDropIn",
            targets: ["BraintreeDropIn"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/braintree/braintree_ios", from: "5.26.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "BraintreeDropIn",
            dependencies: [
                .product(name: "BraintreeApplePay", package: "braintree_ios"),
                .product(name: "BraintreeCard", package: "braintree_ios"),
                .product(name: "BraintreeCore", package: "braintree_ios"),
                .product(name: "BraintreePaymentFlow", package: "braintree_ios"),
                .product(name: "BraintreePayPal", package: "braintree_ios"),
                .product(name: "BraintreeThreeDSecure", package: "braintree_ios"),
                .product(name: "BraintreeUnionPay", package: "braintree_ios"),
                .product(name: "BraintreeVenmo", package: "braintree_ios"),
                .product(name: "PayPalDataCollector", package: "braintree_ios")
            ],
            exclude: ["Info.plist"],
            resources: [.copy("PrivacyInfo.xcprivacy")],
            publicHeadersPath: "Public",
            cSettings: [
                .headerSearchPath("Custom Views"),
                .headerSearchPath("."),
                .headerSearchPath("Components"),
                .headerSearchPath("Vector Art"),
                .headerSearchPath("Vector Art/Large"),
                .headerSearchPath("Helpers"),
                .headerSearchPath("Models"),
                .headerSearchPath("Localization")
            ]
        )
    ]
)
