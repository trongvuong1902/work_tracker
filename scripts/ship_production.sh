#!/usr/bin/env bash
#
# Ship a PRODUCTION release to both stores in one statement:
#   - iOS   -> App Store        (ios/fastlane   lane :release — TestFlight + submit for review)
#   - Android -> Play Store production track (android/fastlane lane :production)
#
# Uses the prod config (dart_defines.prod.json), which OMITS AI_API_KEY so the
# in-app AI self-disables in production builds (AiClient.isConfigured is false
# when the key is empty). Both lanes read the version NAME from pubspec.yaml and
# auto-increment their own build NUMBER (see docs/versioning.md).
#
# PRECONDITIONS (see docs/release_flow.md):
#   - You are releasing from `master`, with the release merged in.
#   - You have bumped pubspec.yaml `version:` and tagged `vX.Y.Z` on master.
#   - App Store Connect + Play Console listings already exist (these lanes skip
#     metadata/screenshots and only submit the binary).
#
# Usage: ./scripts/ship_production.sh

set -euo pipefail

cd "$(dirname "$0")/.."

export DART_DEFINES_FILE="${DART_DEFINES_FILE:-dart_defines.prod.json}"

if [[ ! -f "$DART_DEFINES_FILE" ]]; then
  echo "error: $DART_DEFINES_FILE not found." >&2
  echo "Copy dart_defines.prod.json.example to $DART_DEFINES_FILE and fill in" >&2
  echo "your keys (leave AI_API_KEY empty for public/prod builds)." >&2
  exit 1
fi

# Sanity nudge: production should ship from a tagged master, not develop/release.
CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo unknown)"
if [[ "$CURRENT_BRANCH" != "master" ]]; then
  echo "warning: current branch is '$CURRENT_BRANCH', not 'master'." >&2
  echo "Production releases are expected to ship from a tagged master (see docs/release_flow.md)." >&2
  read -r -p "Continue anyway? [y/N] " reply
  [[ "$reply" == "y" || "$reply" == "Y" ]] || { echo "Aborted."; exit 1; }
fi

echo "==> iOS: building IPA, uploading to TestFlight, and submitting to the App Store for review"
( cd ios && bundle exec fastlane release )

echo "==> Android: building AAB and uploading to the Play Store production track"
( cd android && bundle exec fastlane production )

echo "==> Done: submitted a production release to the App Store and Play Store."
echo "    Verify: App Store Connect shows the build in review; Play Console production track shows the new AAB."
