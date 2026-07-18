#!/usr/bin/env bash
#
# Build a release IPA for App Store submission.
#
# WHY THIS SCRIPT EXISTS:
# Xcode's "Product > Archive" action does NOT invoke `flutter build` — it
# just compiles/packages whatever Flutter build artifacts are already on
# disk. It never passes `--dart-define-from-file=dart_defines.json`, so a
# direct Xcode archive silently ships a release binary where
# `GOOGLE_MAPS_API_KEY` (read via `String.fromEnvironment` in
# lib/di/register_module.dart) resolves to an empty string, breaking
# leave-reminder commute estimates in production. This script is the only
# supported way to produce a release/App Store build — it always runs
# `flutter build ipa` with the dart-define file so the key is baked in.
#
# See docs/leave_reminder_setup.md for how to provision dart_defines.json.
#
# Usage: ./scripts/build_release_ipa.sh
# Optional: DART_DEFINES_FILE=<file> to build against a tier-specific config
# (e.g. dart_defines.internal.json vs dart_defines.prod.json — see
# docs/release_flow.md). Defaults to dart_defines.json for local builds.

set -euo pipefail

cd "$(dirname "$0")/.."

DART_DEFINES_FILE="${DART_DEFINES_FILE:-dart_defines.json}"

if [[ ! -f "$DART_DEFINES_FILE" ]]; then
  echo "error: $DART_DEFINES_FILE not found." >&2
  echo "Copy dart_defines.json.example to dart_defines.json and fill in" >&2
  echo "GOOGLE_MAPS_API_KEY before building a release IPA." >&2
  exit 1
fi

# Plain string, not a bash array: macOS ships bash 3.2 (pre-4.4), which
# throws "unbound variable" when expanding an empty array under `set -u`.
# This flag value never contains whitespace, so unquoted word-splitting
# below is safe and sidesteps that bash-version footgun entirely.
BUILD_NUMBER_ARG=""
if [[ -n "${BUILD_NUMBER:-}" ]]; then
  BUILD_NUMBER_ARG="--build-number=$BUILD_NUMBER"
fi

# Full clean first, for parity with the Android release scripts — guarantees a
# release build never reuses a stale cached Dart snapshot (see docs/versioning.md).
fvm flutter clean

fvm flutter build ipa --release --dart-define-from-file="$DART_DEFINES_FILE" $BUILD_NUMBER_ARG
