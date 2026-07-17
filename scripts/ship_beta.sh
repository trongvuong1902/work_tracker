#!/usr/bin/env bash
#
# Ship a new beta build to BOTH channels in one statement:
#   - iOS   -> TestFlight              (ios/fastlane   lane :beta)
#   - Android -> Firebase App Distribution (android/fastlane lane :beta)
#
# Both lanes read the version NAME from pubspec.yaml (a deliberate human bump —
# see docs/versioning.md) and auto-increment their own build NUMBER, so each
# run is a distinct, new/latest build on each channel. This only builds and
# uploads a fresh beta; it does not touch the Play Store or submit for review.
#
# Usage: ./scripts/ship_beta.sh
# Prerequisites: see docs/versioning.md and the release-engineer agent contract
# (dart_defines.json, ios/fastlane/.env, android/fastlane/.env, bundler deps).

set -euo pipefail

cd "$(dirname "$0")/.."

echo "==> iOS: building IPA and uploading to TestFlight"
( cd ios && bundle exec fastlane beta )

echo "==> Android: building APK and uploading to Firebase App Distribution"
( cd android && bundle exec fastlane beta )

echo "==> Done: shipped a new beta to TestFlight and Firebase."
