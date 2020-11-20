#!/bin/sh
set -eo pipefail

gpg --quiet --batch --yes --decrypt --passphrase="$IOS_KEYS" --output ./.github/secrets/Provision.mobileprovision.mobileprovision ./.github/secrets/Provision.mobileprovision.mobileprovision.gpg
gpg --quiet --batch --yes --decrypt --passphrase="$IOS_KEYS" --output ./.github/secrets/distribution_key_and_cert.p12 ./.github/secrets/distribution_key_and_cert.p12.gpg

mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles

cp ./.github/secrets/Provision.mobileprovision.mobileprovision ~/Library/MobileDevice/Provisioning\ Profiles/Provision.mobileprovision.mobileprovision


security create-keychain -p "" build.keychain
security import ./.github/secrets/distribution_key_and_cert.p12 -t agg -k ~/Library/Keychains/build.keychain -P "" -A

security list-keychains -s ~/Library/Keychains/build.keychain
security default-keychain -s ~/Library/Keychains/build.keychain
security unlock-keychain -p "" ~/Library/Keychains/build.keychain

security set-key-partition-list -S apple-tool:,apple: -s -k "" ~/Library/Keychains/build.keychain