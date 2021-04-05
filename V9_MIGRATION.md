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

The `fetch` method has been renamed to `mostRecentPaymentMethod`:

```swift
BTDropInResult.mostRecentPaymentMethod(forClientToken: authorization) { result, error in
  guard let result = result, error == nil else {
    // either an error occurred or the customer doesn't have any vaulted payment methods
    return
  }

  if result.paymentMethodType == .applePay {
    // Apple Pay is the most recently selected payment method
    // Note that result.paymentMethod will be nil in this case; display Apple Pay button and tokenize using `BTApplePayClient`
  }

  // Update your UI
  let type = result.paymentOptionType
  let icon = result.paymentIcon
  let description = result.paymentDescription

  // Use the payment method to transact
  let paymentMethod = result.paymentMethod
}
```
