source 'https://cdn.cocoapods.org/'

workspace 'BraintreeDropIn.xcworkspace'
platform :ios, '12.0'
use_frameworks!

target 'Demo' do
  project 'Demo/Demo'
  pod 'InAppSettingsKit', :inhibit_warnings => true

  pod "BraintreeDropIn", :path => "./"

  pod 'Braintree/Apple-Pay'
  pod 'Braintree/PayPal'
  pod 'Braintree/Venmo'
  pod 'Braintree/PaymentFlow'
end

abstract_target 'Tests' do
  pod 'Specta'
  pod 'Expecta'
  pod 'OCMock'
  pod 'OHHTTPStubs'
  pod 'xcbeautify'

  pod 'Braintree/Apple-Pay'
  pod 'Braintree/PayPal'
  pod 'Braintree/Venmo'
  pod 'Braintree/PaymentFlow'

  target 'UnitTests'
  target 'UITests'
end

