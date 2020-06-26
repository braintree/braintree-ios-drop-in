source 'https://cdn.cocoapods.org/'

platform :ios, '9.0'
inhibit_all_warnings!

workspace 'BraintreeDropIn.xcworkspace'

target 'DropInDemo' do
  pod 'InAppSettingsKit'

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

  target 'UnitTests'
  target 'UITests'
end

