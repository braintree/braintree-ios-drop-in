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
  pod 'Braintree/ApplePay', '~> 5.0.0-beta'
  pod 'Braintree/PaymentFlow', '~> 5.0.0-beta'
  pod 'Braintree/PayPal', '~> 5.0.0-beta'
  pod 'Braintree/ThreeDSecure', '~> 5.0.0-beta'
  pod 'Braintree/UnionPay', '~> 5.0.0-beta'
  pod 'Braintree/Venmo', '~> 5.0.0-beta'

  target 'Demo' do
    project 'Demo/Demo'
    pod 'InAppSettingsKit', :inhibit_warnings => true
  end

  target 'BraintreeDropIn'

  target 'UnitTests' do
    pod 'xcbeautify'
  end
end
