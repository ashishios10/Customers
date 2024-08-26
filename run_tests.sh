#!/bin/bash

SCHEME='Devskiller'
DESTINATION='platform=iOS Simulator,OS=latest,name=iPhone 15'

xcodebuild test -scheme $SCHEME -workspace Customers.xcworkspace -sdk iphonesimulator -destination "$DESTINATION" CODE_SIGNING_ALLOWED='NO'
