Pod::Spec.new do |s|
  s.name             = "BraintreeDropIn"
  s.version          = "9.12.2"
  s.summary          = "Braintree Drop-in SDK: A modern foundation for accepting payments"
  s.description      = <<-DESC
                       Braintree is a full-stack payments platform for developers

                       This CocoaPod will help you accept payments in your iOS app.

                       Check out our development portal at https://developer.paypal.com/braintree/docs.
  DESC
  s.homepage         = "https://developer.paypal.com/braintree/docs"
  s.documentation_url = "https://developer.paypal.com/braintree/docs/start/hello-client/ios/v5"
  s.screenshots      = ["https://github.com/braintree/braintree-ios-drop-in/raw/main/Images/client-sdk-ios-series-light.png", "https://github.com/braintree/braintree-ios-drop-in/raw/main/Images/client-sdk-ios-series-dark.png"]
  s.license          = "MIT"
  s.author           = { "Braintree" => "team-bt-sdk@paypal.com" }
  s.source           = { :git => "https://github.com/braintree/braintree-ios-drop-in.git", :tag => s.version.to_s }

  s.platform         = :ios, "12.0"
  s.requires_arc     = true
  s.compiler_flags = "-Wall -Werror -Wextra"
  s.swift_version = "5.9"

  s.source_files  = "Sources/BraintreeDropIn/**/*.{h,m}"
  s.public_header_files = "Sources/BraintreeDropIn/Public/BraintreeDropIn/*.h"
  s.frameworks = "UIKit"
  s.dependency "Braintree/ApplePay", "~> 5.25"
  s.dependency "Braintree/Card", "~> 5.25"
  s.dependency "Braintree/Core", "~> 5.25"
  s.dependency "Braintree/UnionPay", "~> 5.25"
  s.dependency "Braintree/PayPal", "~> 5.25"
  s.dependency "Braintree/ThreeDSecure", "~> 5.25"
  s.dependency "Braintree/Venmo", "~> 5.25"
  s.resource_bundles = {
    "BraintreeDropIn-Localization" => ["Sources/BraintreeDropIn/Resources/*.lproj"],
    "BraintreeDropIn_PrivacyInfo" => ["Sources/BraintreeDropIn/PrivacyInfo.xcprivacy"]
}

end
