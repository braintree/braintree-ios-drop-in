# Braintree iOS Drop-in Development Notes

This document outlines development practices that we follow while developing this SDK.

## Development Merchant Server

The included demo app utilizes a [sandbox sample merchant server](https://braintree-sample-merchant.herokuapp.com) hosted on Heroku.

## Tests

There are a number of test targets for each section of the project.

It's a good idea to run `rake`, which runs all unit tests, before committing.

Use the following commands to run tests:
* UI tests: `bundle && rake spec:ui`
* Unit tests: `bundle && rake spec:unit`
* All tests: `bundle && rake spec:all`

## Importing Header Files

To maintain support for CocoaPods, Swift Package Manager, and Carthage, our Objective-C import statements need specific attention.

CocoaPods creates a single BraintreeDropIn framework out of its subpsecs, whereas SPM, Carthage, and manual integrations treat each module as a separate framework, i.e., BraintreeUIKit & BraintreeDropIn.

SPM & Carthage use:
`#import <BraintreeDropIn/BraintreeDropIn.h>`
`#import <BraintreeUIKit/BraintreeUIKit.h>`
`#import <BraintreeCore/BraintreeCore.h>`

CocoaPods uses:
`#import <BraintreeDropIn/BraintreeDropIn.h>`
`#import <BraintreeDropIn/BraintreeUIKit.h>`
`#import <Braintree/BraintreeCore.h>`

Public headers for each module must live in the directory `Public/<MODULE_NAME>`. This allows SPM to use the same import syntax as Carthage (e.g., `<BraintreeUIKit/BraintreUIKit.h>`).

We use if-else preprocessor directives to satisfy each dependency manager. See the below example for importing a **public header file**.

```objc
#import <BraintreeDropIn/BTDropInRequest.h> // all package managers, since Pod name same as subspec name

#ifdef COCOAPODS // CocoaPods
#import <BraintreeDropIn/BraintreeUIKit.h>
#else // SPM or Carthage
#import <BraintreeUIKit/BraintreeUIKit.h>
#endif
```

To import a Braintree framework written in **Swift** into an Objective-C file, use the following syntax:
```objc
#ifdef COCOAPODS // CocoaPods
#import <BraintreeDropIn/BraintreeDropIn-Swift.h>

#elif SWIFT_PACKAGE // SPM
@import YourNewSwiftFramework;

#else // Carthage
#import <YourNewSwiftFramework/YourNewSwiftFramework-Swift.h>
#endif
```
