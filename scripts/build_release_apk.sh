#!/usr/bin/env bash
#
# Build a release APK for Firebase App Distribution.
#
# WHY THIS SCRIPT EXISTS:
# `GOOGLE_MAPS_API_KEY` is needed in two different places for a release
# build: baked into the Dart binary via `--dart-define-from-file` (read via
# `String.fromEnvironment` in lib/di/register_module.dart), and injected into
# AndroidManifest.xml via a Gradle manifest placeholder that reads
# `android/local.properties` (see android/app/build.gradle.kts). Keeping two
# gitignored files in sync by hand is easy to get wrong, so this script
# treats the repo-root `dart_defines.json` as the single source of truth and
# syncs its GOOGLE_MAPS_API_KEY into android/local.properties before every
# release build.
#
# See docs/leave_reminder_setup.md for how to provision dart_defines.json.
#
# Usage: ./scripts/build_release_apk.sh
# Optional: BUILD_NUMBER=<n> to override the version code (the `beta` fastlane
# lane sets this from the unified Android counter — see docs/versioning.md),
# BUILD_NAME=<x.y.z> to override the version name (normally left unset so it
# comes from pubspec.yaml).

set -euo pipefail

cd "$(dirname "$0")/.."

FLAVOR="${FLAVOR:-prod}"

DART_DEFINES_FILE="dart_defines.json"
LOCAL_PROPERTIES_FILE="android/local.properties"

if [[ ! -f "$DART_DEFINES_FILE" ]]; then
  echo "error: $DART_DEFINES_FILE not found." >&2
  echo "Copy dart_defines.json.example to dart_defines.json and fill in" >&2
  echo "GOOGLE_MAPS_API_KEY before building a release APK." >&2
  exit 1
fi

if [[ ! -f "$LOCAL_PROPERTIES_FILE" ]]; then
  echo "error: $LOCAL_PROPERTIES_FILE not found." >&2
  echo "Open the android/ project in Android Studio once (or run" >&2
  echo "'flutter build apk' in debug mode) so Flutter/Android tooling" >&2
  echo "generates it, then rerun this script." >&2
  exit 1
fi

GOOGLE_MAPS_API_KEY="$(jq -r '.GOOGLE_MAPS_API_KEY' "$DART_DEFINES_FILE")"
if [[ -z "$GOOGLE_MAPS_API_KEY" || "$GOOGLE_MAPS_API_KEY" == "null" ]]; then
  echo "error: GOOGLE_MAPS_API_KEY missing or empty in $DART_DEFINES_FILE." >&2
  exit 1
fi

if grep -q '^GOOGLE_MAPS_API_KEY=' "$LOCAL_PROPERTIES_FILE"; then
  # Portable in-place edit (works on both BSD/macOS and GNU sed).
  sed -i.bak "s|^GOOGLE_MAPS_API_KEY=.*|GOOGLE_MAPS_API_KEY=${GOOGLE_MAPS_API_KEY}|" "$LOCAL_PROPERTIES_FILE"
  rm -f "${LOCAL_PROPERTIES_FILE}.bak"
else
  echo "GOOGLE_MAPS_API_KEY=${GOOGLE_MAPS_API_KEY}" >> "$LOCAL_PROPERTIES_FILE"
fi

# Full clean first: without it the Android Gradle/Flutter build can reuse a
# cached libapp.so and ship a stale Dart snapshot under a freshly-bumped
# version (see docs/versioning.md). Correctness over speed for release builds.
fvm flutter clean

fvm dart run build_runner build --delete-conflicting-outputs

# Plain strings, not bash arrays: macOS ships bash 3.2 (pre-4.4), which
# throws "unbound variable" when expanding an empty array under `set -u`.
# These flag values never contain whitespace, so unquoted word-splitting
# below is safe and sidesteps that bash-version footgun entirely.
BUILD_NAME_ARG=""
if [[ -n "${BUILD_NAME:-}" ]]; then
  BUILD_NAME_ARG="--build-name=$BUILD_NAME"
fi

BUILD_NUMBER_ARG=""
if [[ -n "${BUILD_NUMBER:-}" ]]; then
  BUILD_NUMBER_ARG="--build-number=$BUILD_NUMBER"
fi

fvm flutter build apk --release --flavor "$FLAVOR" --dart-define-from-file="$DART_DEFINES_FILE" $BUILD_NAME_ARG $BUILD_NUMBER_ARG
