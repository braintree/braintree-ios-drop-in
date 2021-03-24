Pod::Spec.new do |s|
  s.name             = "BraintreeDropIn"
  s.version          = "8.1.3"
  s.summary          = "Braintree Drop-in SDK: A modern foundation for accepting payments"
  s.description      = <<-DESC
                       Braintree is a full-stack payments platform for developers

                       This CocoaPod will help you accept payments in your iOS app.

                       Check out our development portal at https://developers.braintreepayments.com.
  DESC
  s.homepage         = "https://www.braintreepayments.com/how-braintree-works"
  s.documentation_url = "https://developers.braintreepayments.com/ios/start/hello-client"
  s.screenshots      = ["https://github.com/braintree/braintree-ios-drop-in/raw/master/Images/client-sdk-ios-series-light.png", "https://github.com/braintree/braintree-ios-drop-in/raw/master/Images/client-sdk-ios-series-dark.png"]
  s.license          = "MIT"
  s.author           = { "Braintree" => "code@getbraintree.com" }
  s.source           = { :git => "https://github.com/braintree/braintree-ios-drop-in.git", :tag => s.version.to_s }

  s.platform         = :ios, "12.0"
  s.requires_arc     = true
  s.compiler_flags = "-Wall -Werror -Wextra"
  s.swift_version = "5.1"

  s.default_subspecs = %w[DropIn]

  s.subspec "DropIn" do |s|
    s.source_files  = "Sources/BraintreeDropIn/**/*.{h,m}"
    s.public_header_files = "Sources/BraintreeDropIn/Public/BraintreeDropIn/*.h"
    s.frameworks = "UIKit"
    s.dependency "Braintree/ApplePay", "~> 5.3"
    s.dependency "Braintree/Card", "~> 5.3"
    s.dependency "Braintree/Core", "~> 5.3"
    s.dependency "Braintree/UnionPay", "~> 5.3"
    s.dependency "Braintree/PayPal", "~> 5.3"
    s.dependency "Braintree/ThreeDSecure", "~> 5.3"
    s.dependency "Braintree/Venmo", "~> 5.3"
    s.dependency "BraintreeDropIn/UIKit"
  end

  s.subspec "UIKit" do |s|
    s.source_files  = "Sources/BraintreeUIKit/**/*.{h,m}"
    s.public_header_files = "Sources/BraintreeUIKit/Public/BraintreeUIKit/*.h"
    s.frameworks = "UIKit"
    s.resource_bundles = {
      "Braintree-UIKit-Localization" => ["Sources/BraintreeUIKit/Resources/*.lproj"] }
  end

  # https://github.com/CocoaPods/CocoaPods/issues/10065#issuecomment-694266259
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
end

