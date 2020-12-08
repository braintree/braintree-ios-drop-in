source 'https://cdn.cocoapods.org/'

workspace 'BraintreeDropIn.xcworkspace'
platform :ios, '12.0'
use_frameworks!

target 'UITests' do
  project 'Demo/Demo'
  pod 'xcbeautify'
end

# TODO: Can we migrate demo to use SPM?
abstract_target 'All' do
  pod 'Braintree/ApplePay', :git => 'https://github.com/braintree/braintree_ios.git', :branch => 'apple-pay-last-two'
  pod 'Braintree/PaymentFlow', :git => 'https://github.com/braintree/braintree_ios.git', :branch => 'apple-pay-last-two'
  pod 'Braintree/PayPal', :git => 'https://github.com/braintree/braintree_ios.git', :branch => 'apple-pay-last-two'
  pod 'Braintree/ThreeDSecure', :git => 'https://github.com/braintree/braintree_ios.git', :branch => 'apple-pay-last-two'
  pod 'Braintree/UnionPay', :git => 'https://github.com/braintree/braintree_ios.git', :branch => 'apple-pay-last-two'
  pod 'Braintree/Venmo', :git => 'https://github.com/braintree/braintree_ios.git', :branch => 'apple-pay-last-two'

  target 'Demo' do
    project 'Demo/Demo'
    pod 'InAppSettingsKit', :inhibit_warnings => true
  end

  target 'BraintreeDropIn'

  target 'UnitTests' do
    pod 'xcbeautify'
  end
end
