# Braintree iOS Drop-in v9 Beta Migration Guide

See the [CHANGELOG](/CHANGELOG.md) for a complete list of changes. This migration guide outlines the basics for updating your client integration from v8 to v9.

_Documentation for v5 will be published to https://developers.braintreepayments.com once it is available for general release._

## Table of Contents

1. [Supported Versions](#supported-versions)
1. [UI Customization](#ui-customization)
1. [Accessibility](#accessibility)

## Supported Versions

v9 supports a minimum deployment target of iOS 12+. It requires the use of Xcode 12+ and Swift 5+.

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

In v9, dynamic type is enabled by default for both system and custom fonts. We strongly encourage you to leave this feature on, but if you need to disable it, you may do so by setting `disableDynamicType` to `true` on `BTDropInUICustomization`.

```swift
let uiCustomization = BTDropInUICustomization(colorScheme: .light)
uiCustomization.disableDynamicType = true

let dropInRequest = BTDropInRequest()
dropInRequest.uiCustomization = uiCustomization
```
