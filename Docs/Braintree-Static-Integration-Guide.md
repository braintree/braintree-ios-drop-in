Static Library Integration Guide
------------------------------------

Please follow these instructions to integrate Braintree iOS Drop-In into your app using the provided static library.

> Note: We assume that you are using Xcode 7+ and iOS 9.0+ as your Base SDK.

1. Follow all of the instructions to add the [Braintree iOS SDK as a static library](https://github.com/braintree/braintree_ios/blob/master/Docs/Braintree-Static-Integration-Guide.md) to your project.

2. Add the Braintree iOS Drop-In SDK code to your repository
  - [Download the SDK as a ZIP file from GitHub](https://github.com/braintree/braintree-ios-drop-in/archive/master.zip) and unzip it into your app's root directory in Finder

3. Open up your app in Xcode

4. Add BraintreeDropIn as a subproject
  - Open your project and drag the BraintreeDropIn.xcodeproj file to your Project Navigator under your project. Be sure *NOT* to have the BraintreeDropIn.xcodeproj open while doing this step.
  
5. Add `BraintreeDropIn-StaticLibrary` to your build phases (`[Your App Target]` > `Build Phases`)
  - `Target Dependencies`
    - Click the `+` and add `BraintreeDropIn-StaticLibrary`
    
  - `Link Binary With Libraries`
    - Click the `+` and add `libBraintreeDropIn-StaticLibrary.a`

6. Add `localized strings` to `Copy Bundle Resources` (`[Your App Target]` > `Build Phases`)
  - In the Project Navigator, locate the `BTUI.strings` (`BraintreeDropIn.xcodeproj` > `BraintreeUIKit` > `Localization` > `BTUI.strings`)
  - Drag the `BTUI.strings` file from the Navigator to the `Copy Bundle Resources` panel and drop it
    
7. Modify your build settings (`[Your App Target]` > `Build Settings`)
  - Update `Header Search Paths`
    - Add `$(PROJECT_DIR)/braintree-ios-drop-in` (or whatever the name of the braintree folder at the top level of your project is)
    - Be sure to select recursive from the drop down at the right
    
  - Update `Other Linker Flags`
    - Add `-ObjC`
    
8. `Build and Run` your app to test out the integration

9. [Integrate the SDK in your checkout form](https://developers.braintreepayments.com/ios/start/overview)
