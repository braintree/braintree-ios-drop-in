source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'
inhibit_all_warnings!

workspace 'BraintreeDropIn.xcworkspace'

target 'DropInDemo' do
  pod 'AFNetworking'
  pod 'CardIO'
  pod 'PureLayout'
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

  target 'UnitTests'
end

