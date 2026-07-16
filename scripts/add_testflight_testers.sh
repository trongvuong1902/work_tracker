#!/usr/bin/env bash
#
# Bulk-add/update external TestFlight testers from ios/fastlane/testers.csv.
#
# Each row is: first_name,last_name,email (first/last may be left blank).
# Testers are added to (or updated in) the TESTFLIGHT_GROUP configured in
# ios/fastlane/.env. See docs/fastlane_testflight_setup.md for how to
# provision the CSV file and the App Store Connect API key this script
# authenticates with.
#
# Usage: ./scripts/add_testflight_testers.sh

set -euo pipefail

cd "$(dirname "$0")/.."

TESTERS_FILE="ios/fastlane/testers.csv"
ENV_FILE="ios/fastlane/.env"
APP_IDENTIFIER="io.fury.workTracker"

if [[ ! -f "$TESTERS_FILE" ]]; then
  echo "error: $TESTERS_FILE not found." >&2
  echo "Copy ios/fastlane/testers.csv.example to $TESTERS_FILE and list your testers." >&2
  exit 1
fi

if [[ ! -f "$ENV_FILE" ]]; then
  echo "error: $ENV_FILE not found." >&2
  echo "See docs/fastlane_testflight_setup.md to provision the App Store Connect API key." >&2
  exit 1
fi

set -a
# shellcheck disable=SC1090
source "$ENV_FILE"
set +a

GROUP="${TESTFLIGHT_GROUP:-External Testers}"

KEY_FILE_ABS="$(cd ios/fastlane && realpath "$ASC_KEY_FILEPATH")"
API_KEY_JSON_FILE="$(mktemp)"
trap 'rm -f "$API_KEY_JSON_FILE"' EXIT

jq -n --arg key_id "$ASC_KEY_ID" --arg issuer_id "$ASC_ISSUER_ID" --rawfile key "$KEY_FILE_ABS" \
  '{key_id: $key_id, issuer_id: $issuer_id, key: $key, in_house: false}' > "$API_KEY_JSON_FILE"

cd ios
bundle exec fastlane pilot import \
  --testers_file_path "../$TESTERS_FILE" \
  -a "$APP_IDENTIFIER" \
  -g "$GROUP" \
  --api_key_path "$API_KEY_JSON_FILE"
