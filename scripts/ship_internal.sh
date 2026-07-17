#!/usr/bin/env bash
#
# Ship a new build to INTERNAL testers only, on both channels:
#   - iOS   -> TestFlight            (internal testers auto-receive every build)
#   - Android -> Firebase App Distribution, group "internal"
#
# iOS: TestFlight internal testers automatically get every processed build, so
# `fastlane beta` (build + upload) is all that's needed — no review, no group,
# and NOT `distribute_beta` (that's for external testers).
# Android: the `beta` lane distributes to $FIREBASE_GROUP; we pin it to
# "internal" for this script (the inline value overrides android/fastlane/.env).
#
# Both lanes take the version NAME from pubspec.yaml and auto-increment their
# own build NUMBER (see docs/versioning.md), so each run is a distinct
# new/latest build. This only builds and uploads; it does not touch the Play
# Store or submit for external review.
#
# Usage: ./scripts/ship_internal.sh

set -euo pipefail

cd "$(dirname "$0")/.."

echo "==> iOS: building IPA and uploading to TestFlight (internal testers auto-receive)"
( cd ios && bundle exec fastlane beta )

echo "==> Android: building APK and uploading to Firebase App Distribution (group: internal)"
( cd android && FIREBASE_GROUP=internal bundle exec fastlane beta )

echo "==> Done: shipped a new internal build to TestFlight and Firebase (internal)."
