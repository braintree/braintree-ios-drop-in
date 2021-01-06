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
            targets: ["BraintreeDropIn"] //,"BraintreeThreeDSecure"]
        ),
        .library(
            name: "BraintreeUIKit",
            targets: ["BraintreeUIKit"]
        )
    ],
    dependencies: [
        .package(name: "Braintree", url: "https://github.com/braintree/braintree_ios.git", .branch("master"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "BraintreeDropIn",
            dependencies: [
                .product(name: "BraintreeApplePay", package: "Braintree"),
                .product(name: "BraintreeCard", package: "Braintree"),
                .product(name: "BraintreeCore", package: "Braintree"),
                .product(name: "BraintreeUnionPay", package: "Braintree"),
                .product(name: "BraintreePaymentFlow", package: "Braintree"),
                .product(name: "BraintreePayPal", package: "Braintree"),
                .product(name: "BraintreeVenmo", package: "Braintree"),
                //.product(name: "PayPalDataCollector", package: "Braintree"),
                .target(name: "BraintreeUIKit")
            ],
            exclude: ["Info.plist"],
            publicHeadersPath: "Public",
            cSettings: [
                .headerSearchPath("Custom Views"),
                .headerSearchPath(".")
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
        )
//        .binaryTarget(
//            // https://developer.apple.com/documentation/swift_packages/distributing_binary_frameworks_as_swift_packages
//            name: "BraintreeThreeDSecure",
//            url: "https://tmpfiles.org/dl/109215/BraintreeThreeDSecure.xcframework.zip",
//            checksum: "72ddb118fb9f2eb5560c1f103eea88f728da770a37c6b6667cdd0b5c7bf2c6b9"
//        )
    ]
)
