#!/usr/bin/env bash
#
# Ship a new beta build to the PUBLIC-tester channels in one statement:
#   - iOS   -> TestFlight External group          (ios/fastlane   lane :beta_external)
#   - Android -> Firebase App Distribution, group "Nexsoft" (android/fastlane lane :beta)
#
# The iOS lane builds, uploads, WAITS for Apple to finish processing, and then
# distributes to the external testers group (TESTFLIGHT_GROUP = Nexsoft). That
# processing wait makes this a long-running command (~10-30 min); the first
# external build of a version then goes through Apple's async beta review before
# testers receive it.
#
# On Android the public tier goes to Firebase App Distribution (group "Nexsoft",
# pinned inline below; roster synced from nexsoft_testers.txt first so the group
# is never empty). Play Store Closed testing is NOT part of this auto flow — to
# push to it, run `cd android && bundle exec fastlane closed` manually (see
# docs/play_store_setup.md).
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

# The Firebase "Nexsoft" group is populated from this file. Without it the group
# is empty and the Firebase build reaches no testers — fail fast (before the long
# iOS build) rather than shipping to nobody.
if [[ ! -f android/fastlane/nexsoft_testers.txt ]]; then
  echo "error: android/fastlane/nexsoft_testers.txt not found." >&2
  echo "Copy android/fastlane/nexsoft_testers.txt.example to it and add the real" >&2
  echo "tester emails (one per line). It populates the Firebase 'Nexsoft' group;" >&2
  echo "without it the Firebase build has no testers." >&2
  exit 1
fi

echo "==> iOS: building IPA, uploading to TestFlight, and distributing to external testers (Nexsoft)"
echo "    (this waits for Apple to finish processing the build — expect ~10-30 min)"
( cd ios && bundle exec fastlane beta_external )

echo "==> Android: syncing Nexsoft roster and distributing via Firebase App Distribution (group: Nexsoft)"
(
  cd android
  bundle exec fastlane add_nexsoft_testers            # populate the Firebase 'Nexsoft' group (idempotent)
  FIREBASE_GROUP=Nexsoft bundle exec fastlane beta     # Firebase App Distribution -> Nexsoft
)

echo "==> Done: shipped a new beta to TestFlight external (Nexsoft) and Firebase (Nexsoft)."
