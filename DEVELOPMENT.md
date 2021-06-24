# Braintree iOS Drop-in Development Notes

This document outlines development practices that we follow while developing this SDK.

## Development Merchant Server

The included demo app utilizes a [sandbox sample merchant server](https://braintree-sample-merchant.herokuapp.com) hosted on Heroku.

## Tests

There are a number of test targets for each section of the project.

It's a good idea to run `rake`, which runs all unit tests, before committing.

Running the tests requires Xcode 13+.

Use the following commands to run tests:
* UI tests: `bundle && rake spec:ui`
* Unit tests: `bundle && rake spec:unit`
* All tests: `bundle && rake spec:all`

## Importing Header Files

Example: importing a public header file
```objc
#import <BraintreeDropIn/BTDropInRequest.h>
```

Example: importing an internal header file
```objc
#import "BTUIKAppearance.h"
```

For more information on how header imports work for each package manager, see the [DEVELOPMENT guide](https://github.com/braintree/braintree_ios/blob/master/DEVELOPMENT.md#importing-header-files) in Braintree iOS.

