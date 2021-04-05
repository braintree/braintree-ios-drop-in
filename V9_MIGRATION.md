# Braintree iOS Drop-in v9 Beta Migration Guide

See the [CHANGELOG](/CHANGELOG.md) for a complete list of changes. This migration guide outlines the basics for updating your client integration from v8 to v9.

_Documentation for v9 will be published to https://developers.braintreepayments.com once it is available for general release._

## Table of Contents

1. [Supported Versions](#supported-versions)
1. [Swift Package Manager](#swift-package-manager)
1. [CocoaPods](#cocoapods)
1. [Carthage](#carthage)
1. [UI Customization](#ui-customization)
1. [Accessibility](#accessibility)
1. [Drop-in Result](#drop-in-result)
1. [Venmo](#venmo)

## Supported Versions

v9 supports a minimum deployment target of iOS 12+. It requires the use of Xcode 12+ and Swift 5+.

## Swift Package Manager

v9 adds support for Swift Package Manager. To add the `BraintreeDropIn` package to your Xcode project, select File > Swift Packages > Add Package Dependency and enter `https://github.com/braintree/braintree-ios-drop-in` as the repository URL. Tick the checkbox for `BraintreeDropIn`.

If you look at your app target, you will see that the `BraintreeDropIn` library is automatically linked as a framework to your app (see General > Frameworks, Libraries, and Embedded Content).

## CocoaPods

v9 includes the `Braintree/Apple-Pay`, `Braintree/Venmo`, and `Braintree/UnionPay` subspecs by default in `BraintreeDropIn`. You no longer need to manually include these subspecs in your Podfile.

v9 combines `BraintreeDropIn/UIKit` into `BraintreeDropIn`. You no longer need to include the `BraintreeDropIn/UIKit` subspec in your Podfile.

## Carthage

v9 drops support for Carthage. We recommend using Swift Package Manager.

## UI Customization

v9 introduces `BTDropInUICustomization`, which you can use to customize Drop-in's UI. Instantiate an instance of `BTDropInUICustomization` using the light, dark or dynamic color schemes, and then override additional properties as needed. Set your instance of `BTDropInUICustomization` on `BTDropInRequest`'s `uiCustomization` property.

```swift
let uiCustomization = BTDropInUICustomization(colorScheme: .light)
uiCustomization.fontFamily = "Helvetica"
uiCustomization.boldFontFamily = "Helvetica Bold"

let dropInRequest = BTDropInRequest()
dropInRequest.uiCustomization = uiCustomization
```

Delete any code that used `BTUIKAppearance` to customize Drop-in's UI.

## Accessibility

#### Dynamic Type

In v9, Dynamic Type is enabled by default for both system and custom fonts. We strongly encourage you to leave this feature on, but if you need to disable it, you may do so by setting `disableDynamicType` to `true` on `BTDropInUICustomization`.

```swift
let uiCustomization = BTDropInUICustomization(colorScheme: .light)
uiCustomization.disableDynamicType = true

let dropInRequest = BTDropInRequest()
dropInRequest.uiCustomization = uiCustomization
```

## Drop-in Result

The `isCancelled` property on `BTDropInResult` has been changed to `isCanceled`.

The `paymentOptionType` property on `BTDropInResult` has been changed to `paymentMethodType`. The name of this enum has changed from `BTUIKPaymentOptionType` to `BTDropInPaymentMethodType`.

## Venmo

In v9, `BTDropInRequest` has a `venmoRequest` property that can be used to specify options for the Venmo flow. v9 also removes the `vaultVenmo` property. If you were previously using `vaultVenmo`, you should now use `venmoRequest.vault` instead.

```swift
let venmoRequest = BTVenmoRequest()
venmoRequest.vault = true
// set additional Venmo options as needed

let dropInRequest = BTDropInRequest()
dropInRequest.venmoRequest = venmoRequest
```

If you do not set `venmoRequest`, vaulting will be on by default during the Venmo flow.