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
  pod 'Braintree/Apple-Pay'
  pod 'Braintree/PaymentFlow'
  pod 'Braintree/PayPal'
  pod 'Braintree/Venmo'
  pod 'Braintree/UnionPay'

  target 'Demo' do
    project 'Demo/Demo'
    pod 'InAppSettingsKit', :inhibit_warnings => true
  end

  target 'BraintreeDropIn'

  target 'UnitTests' do
    pod 'xcbeautify'
  end
end
