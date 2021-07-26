Pod::Spec.new do |s|
  s.name             = "BraintreeDropIn"
  s.version          = "9.2.0"
  s.summary          = "Braintree Drop-in SDK: A modern foundation for accepting payments"
  s.description      = <<-DESC
                       Braintree is a full-stack payments platform for developers

                       This CocoaPod will help you accept payments in your iOS app.

                       Check out our development portal at https://developers.braintreepayments.com.
  DESC
  s.homepage         = "https://developer.paypal.com/braintree/docs"
  s.documentation_url = "https://developer.paypal.com/braintree/docs/start/hello-client/ios/v5"
  s.screenshots      = ["https://github.com/braintree/braintree-ios-drop-in/raw/master/Images/client-sdk-ios-series-light.png", "https://github.com/braintree/braintree-ios-drop-in/raw/master/Images/client-sdk-ios-series-dark.png"]
  s.license          = "MIT"
  s.author           = { "Braintree" => "code@getbraintree.com" }
  s.source           = { :git => "https://github.com/braintree/braintree-ios-drop-in.git", :tag => s.version.to_s }

  s.platform         = :ios, "12.0"
  s.requires_arc     = true
  s.compiler_flags = "-Wall -Werror -Wextra"
  s.swift_version = "5.1"

  s.source_files  = "Sources/BraintreeDropIn/**/*.{h,m}"
  s.public_header_files = "Sources/BraintreeDropIn/Public/BraintreeDropIn/*.h"
  s.frameworks = "UIKit"
  s.dependency "Braintree/ApplePay", "~> 5.4", ">=5.4.2"
  s.dependency "Braintree/Card", "~> 5.4", ">=5.4.2"
  s.dependency "Braintree/Core", "~> 5.4", ">=5.4.2"
  s.dependency "Braintree/UnionPay", "~> 5.4", ">=5.4.2"
  s.dependency "Braintree/PayPal", "~> 5.4", ">=5.4.2"
  s.dependency "Braintree/ThreeDSecure", "~> 5.4", ">=5.4.2"
  s.dependency "Braintree/Venmo", "~> 5.4", ">=5.4.2"
  s.resource_bundles = {
    "BraintreeDropIn-Localization" => ["Sources/BraintreeDropIn/Resources/*.lproj"] }

  # https://github.com/CocoaPods/CocoaPods/issues/10065#issuecomment-694266259
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
end

