#!/bin/bash

set -o pipefail && xcodebuild -workspace 'BraintreeDropIn.xcworkspace' -sdk 'iphonesimulator' -configuration 'Release' -scheme 'UnitTests' -destination 'name=iPhone 11,platform=iOS Simulator'  test  | ./Pods/xcbeautify/xcbeautify