#!/usr/bin/env bash
#
# Ship a new beta build to BOTH channels in one statement:
#   - iOS   -> TestFlight              (ios/fastlane   lane :beta)
#   - Android -> Firebase App Distribution (android/fastlane lane :beta)
#
# Both lanes read the version NAME from pubspec.yaml (a deliberate human bump —
# see docs/versioning.md) and auto-increment their own build NUMBER, so each
# run is a distinct, new/latest build on each channel. This only builds and
# uploads a fresh beta; it does not submit for review.
#
# Usage: ./scripts/ship_beta.sh
# Prerequisites: see docs/versioning.md and the release-engineer agent contract
# (dart_defines.json, ios/fastlane/.env, android/fastlane/.env, bundler deps).

set -euo pipefail

cd "$(dirname "$0")/.."

# Public-tester tier uses the prod config (AI_API_KEY omitted → AI self-disables).
# Both lanes' build scripts inherit this via `sh(...)`. See docs/release_flow.md.
export DART_DEFINES_FILE="${DART_DEFINES_FILE:-dart_defines.prod.json}"

if [[ ! -f "$DART_DEFINES_FILE" ]]; then
  echo "error: $DART_DEFINES_FILE not found." >&2
  echo "Copy dart_defines.prod.json.example to $DART_DEFINES_FILE and fill in" >&2
  echo "your keys (leave AI_API_KEY empty for public/prod builds)." >&2
  exit 1
fi

echo "==> iOS: building IPA and uploading to TestFlight"
( cd ios && bundle exec fastlane beta )

echo "==> Android: building APK and uploading to Firebase App Distribution"
( cd android && bundle exec fastlane beta )

echo "==> Done: shipped a new beta to TestFlight and Firebase."
