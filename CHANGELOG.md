# Braintree iOS Drop-in SDK - Release Notes

## unreleased

* Accessibility
  * VoiceOver improvements
  * Fix color contrast ratios
  * Increase hit area for several buttons
* Card form
  * Fix iOS 13 UI bug where "Next" button overlapped with card number text field
  * Add validation to cardholder name field to prevent users from accidentally inputting credit card numbers
* Payment selection sheet
  * Fix bug where vaulted payment methods were shown even when the payment method was disabled on `BTDropInRequest` (fixes #179)
* Breaking changes
  * Localization
    * Rename `BTUIKLocalizedString` to `BTDropInLocalization`
    * Remove `insertIntoLocalizedString` methods
    * Remove translation string static helper methods
  * BTDropInResult
    * Rename `BTUIKPaymentOptionType` enum to `BTDropInPaymentMethodType`
    * Rename `paymentOptionType` property to `paymentMethodType`

## 9.0.0-beta1 (2021-03-29)

* Add support for Swift Package Manager (resolves #155)
* Breaking changes
  * Bump minimum supported deployment target to iOS 12.0
  * Require Braintree ~> 5.3.0
  * BraintreeApplePay, BraintreeVenmo and BraintreeUnionPay are now required dependencies
  * Make headers private:
    * `BTCardFormViewController`
    * `BTDropInBaseViewController`
    * `BTPaymentSelectionViewController`
    * `BTVaultManagementViewController`
  * Add `BTDropInUICustomization`, which replaces `BTUIKAppearance` for customizing UI
  * Enable Dynamic Type by default. This can be disabled with the `disableDynamicType` property on `BTDropInUICustomization`.
  * Show last four digits of vaulted cards, instead of "••• ••11", which truncates in larger fonts.
  * Remove support for Turkish localization
  * Remove `BraintreeUIKit` framework
  * Use number pad for expiration date input on card form
  * Require two-digit year for expiration date instead of four-digit year
  * Remove Carthage support
  * Change spelling of `isCancelled` property on `BTDropInResult` to `isCanceled`

## 8.1.4 (2021-03-25)

* Cards
  * Fix crash on slow network connections (fixes #243)

## 8.1.3 (2021-03-02)

* Fix localizations for Carthage integrations (fixes #272)

## 8.1.2 (2020-11-30)

* Exclude arm64 simulator architectures via Podspec (fixes #233)

## 8.1.1 (2020-07-14)

* Show activity indicator on payment method selection screen at the beginning of PayPal, Venmo and 3DS flows (resolves #177)
* Update constraints for SwiftUI support (resolves #202)

## 8.1.0 (2020-04-01)

* Add `vaultVenmo` flag to `BTDropInRequest`
* Require Braintree ~> 4.32
* Fix UIKit deprecation warnings:
  * UIApplication's `statusBarOrientation` and `statusBarFrame` properties
  * UIViewController's `topLayoutGuide` and `bottomLayoutGuide` properties

## 8.0.0 (2020-02-06)

* Remove deprecated methods and properties
  * BTDropInBaseViewController showLoadingScreen:animated: method
  * BTDropInRequest amount property
  * BTUIKAppearance darkTheme and lightTheme methods
* Remove support for CardIO, a no longer maintained framework.
* Change postal code default keyboard type to `UIKeyboardTypeDefault`.
* Update podspec to require versions `~> 4.31` of Braintree SDK dependencies.

## 7.5.0 (2019-11-19)

* Require Braintree ~> 4.30
* Add support for iOS 13 Dark Mode
  * Add `colorScheme` property to `BTUIKAppearance`, with support for light, dark and dynamic color schemes
  * Deprecate `lightTheme` and `darkTheme`

## 7.4.0 (2019-08-29)

* Deprecate `amount` property on `BTDropInRequest`
* Show activity indicator when 3D Secure flow is triggered for a vaulted payment method

## 7.3.0 (2019-08-09)

* UI changes to support iOS 13
* Demo app maintenance
* Remove unneeded pre-processor directives
* Support for 3DS 2 verification

## 7.2.0 (2019-06-17)

* Add ability for merchant and/or customer to opt in/out of client side vaulting (card).

## 7.1.0 (2019-03-07)

* Add Hiper and Hipercard support

## 7.0.0 (2018-12-06)

* Add support for setting a BTPayPalRequest on the BTDropInRequest
* Set calendar type as Gregorian and syntax for pointers
* Added support for Maestro 56-59 card prefixes

## 6.5.0 (2018-10-09)

* Added the option to accept or require a cardholder name when entering credit card information
* Luhn validate UnionPay cards
* Check for ApplePay capability before displaying it as a payment method (Thanks @Nonepse)
* Increase the payment selection title labels resistance priority to prevent compression on iOS 12

## 6.4.1 (2018-08-20)

* Improve detection of Maestro card numbers

## 6.4.0 (2018-07-17)

* Require Braintree ~> 4.17.0
  * Ensures GraphQL is available for `vaultManager`
* Add `cardDisabled` option
* Fix issue where Carthage integrations were failing

## 6.3.0 (2018-07-13)

* Add `vaultManager` option
  * Allows for the deletion of vaulted payment methods
* Alpha-numeric keyboard will dismiss when Done button is pressed
* Add support for custom translations

## 6.2.0 (2018-05-16)

* Add card validation error alert when validation fails
* Fix transition animation issues with main Drop-in view

## 6.1.0 (2018-02-21)

* Add support to mask security code text field
* Fix issue that caused supported card types to be displayed more than once
* UI fixes and improved iPhone X support. Thanks @shpuntov

## 6.0.1 (2018-02-08)

* Fix code for implicit retain self warning

## 6.0.0 (2018-02-07)

* Fix empty payment method nonce and error in result for PayPal and Venmo flows
* Update 3DS integration to support browser switch
  - Drop-in will now return a `BTCardNonce` instead of a `BTThreeDSecureNonce`
  - The 3DS info can be access via the `threeDSecureInfo` property on a `BTCardNonce`

## 5.3.0 (2017-12-05)

* Add support for manually disabling PayPal and Venmo in Drop-in
* Fix issue that caused errors to not be returned in the Venmo and PayPal flows
* Update translation for scanning a card number with the camera
* Improve iOS 11 and iPhone X support

## 5.2.3 (2017-09-29)

* Update MasterCard and Maestro logos
* Xcode9 updates

## 5.2.2 (2017-08-02)

* Update Apple Pay mark
* Update Demo to support Xcode9 (Beta 4)

## 5.2.1 (2017-06-26)

* Fix UI issues associated with iOS11
* Update Demo to support Xcode9 (Beta 1) and iOS11
* Use `OverCurrentContext` for the card form modal when not an iPad device
* Update README to clarify Apple Pay integration
* Forward UINavigationBarTintColor to Card.io

## 5.2.0 (2017-04-07)

* Improve card BIN matching and added missing Maestro BIN
* Fix 3DS support (Thanks @meismyles)
* UI bug fixes
* Improved accessibility and localization support
* Added ability to set navigationBarTitleTextColor in BTUIKAppearance

## 5.1.0 (2017-01-18)

* Add support for card.io
* Remove beta warning
* Fix inclusion of non-modular header inside framework module error in BTPaymentSelectionViewController. Thanks @steveholt55
* Minor UI improvements
* Add access visual assets

## 5.0.1 (2016-11-09)

* Update [localizations](https://github.com/braintree/braintree-ios-drop-in/tree/master/BraintreeUIKit/Localization)

## 5.0.0 (2016-10-13)

* Bumped major version number to distinguish BraintreeDropIn from Braintree
* Update README for Swift 3
* Minor bug fixes

## 4.7.0 (2016-09-23)

* Moved BraintreeUIKit and BraintreeDropIn to [a separate repository](https://github.com/braintree/braintree-ios-drop-in/) to allow cleaner separation and iteration for Drop-in
