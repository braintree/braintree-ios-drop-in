Pod::Spec.new do |s|
  s.name             = "BraintreeDropIn"
  s.version          = "7.4.0"
  s.summary          = "Braintree v.zero: A modern foundation for accepting payments"
  s.description      = <<-DESC
                       Braintree is a full-stack payments platform for developers

                       This CocoaPod will help you accept payments in your iOS app.

                       Check out our development portal at https://developers.braintreepayments.com.
  DESC
  s.homepage         = "https://www.braintreepayments.com/how-braintree-works"
  s.documentation_url = "https://developers.braintreepayments.com/ios/start/hello-client"
  s.screenshots      = "https://raw.githubusercontent.com/braintree/braintree_ios/master/screenshot.png"
  s.license          = "MIT"
  s.author           = { "Braintree" => "code@getbraintree.com" }
  s.source           = { :git => "https://github.com/braintree/braintree-ios-drop-in.git", :tag => s.version.to_s }
  s.social_media_url = "https://twitter.com/braintree"

  s.platform         = :ios, "9.0"
  s.requires_arc     = true
  s.compiler_flags = "-Wall -Werror -Wextra"

  s.default_subspecs = %w[DropIn]

  s.subspec "DropIn" do |s|
    s.source_files  = "BraintreeDropIn/**/*.{h,m}"
    s.public_header_files = "BraintreeDropIn/Public/*.h"
    s.frameworks = "UIKit"
    s.dependency "Braintree/Card", "~> 4.29"
    s.dependency "Braintree/Core", "~> 4.29"
    s.dependency "Braintree/UnionPay", "~> 4.29"
    s.dependency "Braintree/PaymentFlow", "~> 4.29"
    s.dependency "Braintree/PayPal", "~> 4.29"
    s.dependency "BraintreeDropIn/UIKit"
  end

  s.subspec "UIKit" do |s|
    s.source_files  = "BraintreeUIKit/**/*.{h,m}"
    s.public_header_files = "BraintreeUIKit/Public/*.h"
    s.frameworks = "UIKit"
    s.resource_bundles = {
      "Braintree-UIKit-Localization" => ["BraintreeUIKit/Localization/*.lproj"] }
  end
end

