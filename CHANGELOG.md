# Braintree iOS Drop-in SDK - Release Notes

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
