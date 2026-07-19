#!/usr/bin/env bash
#
# Ship a new build to INTERNAL testers only, on both channels:
#   - iOS   -> TestFlight            (internal testers auto-receive every build)
#   - Android -> Firebase App Distribution, group "internal"
#
# iOS: TestFlight internal testers automatically get every processed build, so
# `fastlane beta` (build + upload) is all that's needed — no review, no group,
# and NOT `distribute_beta` (that's for external testers).
# Android: the `internal` lane builds the release APK and distributes it via
# Firebase App Distribution to the "internal" testers group.
#
# Both lanes take the version NAME from pubspec.yaml and auto-increment their
# own build NUMBER (see docs/versioning.md), so each run is a distinct
# new/latest build. This only builds and uploads; it does not submit for
# external review.
#
# Usage: ./scripts/ship_internal.sh

set -euo pipefail

cd "$(dirname "$0")/.."

# Internal tier gets the AI-enabled config (AI_API_KEY baked in). Both lanes'
# build scripts inherit this via `sh(...)` in the Fastfile. See docs/release_flow.md.
export DART_DEFINES_FILE="${DART_DEFINES_FILE:-dart_defines.internal.json}"

if [[ ! -f "$DART_DEFINES_FILE" ]]; then
  echo "error: $DART_DEFINES_FILE not found." >&2
  echo "Copy dart_defines.internal.json.example to $DART_DEFINES_FILE and fill in" >&2
  echo "your keys (including AI_API_KEY for internal builds)." >&2
  exit 1
fi

echo "==> iOS: building IPA and uploading to TestFlight (internal testers auto-receive)"
( cd ios && bundle exec fastlane beta )

echo "==> Android: building APK and uploading to Firebase App Distribution (group: internal)"
( cd android && bundle exec fastlane internal )

echo "==> Done: shipped a new internal build to TestFlight and Firebase (internal)."
