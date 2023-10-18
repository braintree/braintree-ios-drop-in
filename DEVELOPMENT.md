# Braintree iOS Drop-in Development Notes

This document outlines development practices that we follow while developing this SDK.

## Development Merchant Server

The included demo app utilizes a [sandbox sample merchant server](https://braintree-sample-merchant.herokuapp.com) hosted on Heroku.

## Tests

Running the tests requires Xcode 13+.

Run the following test schemes in Xcode:
- `UITests`
- `UnitTests`

## Importing Header Files

Example: importing a public header file
```objc
#import <BraintreeDropIn/BTDropInRequest.h>
```

Example: importing an internal header file
```objc
#import "BTUIKAppearance.h"
```

For more information on how header imports work for each package manager, see the [DEVELOPMENT guide](https://github.com/braintree/braintree_ios/blob/main/DEVELOPMENT.md#importing-header-files) in Braintree iOS.

## Releasing

Refer to the `ios/releases` section in the SDK Knowledge Repo.
