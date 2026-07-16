# Fastlane TestFlight uploads: local setup

Uploading a release build to TestFlight is automated via Fastlane
(`ios/fastlane/Fastfile`, lane `beta`). It authenticates to App Store Connect
using an **App Store Connect API Key** rather than an Apple ID + 2FA session
— the key is scoped to the team (not a personal account) and works
non-interactively, which an Apple ID/2FA login cannot do headlessly or in CI.

## Creating the API key

In App Store Connect, go to **Users and Access → Integrations → App Store
Connect API**, and generate a new key with the **App Manager** role (needed
to upload and manage TestFlight builds). Note the **Key ID** and **Issuer
ID** shown on that page, and download the `.p8` private key file — Apple
only allows downloading it **once**, at creation time. If it's lost, you
must revoke it and generate a new one; there is no way to re-fetch it.

## Provisioning the key locally

Save the downloaded key under `ios/fastlane/`, named after its Key ID, e.g.:

```
ios/fastlane/AuthKey_ABC123XYZ.p8
```

This path and all `.p8` files under `ios/fastlane/` are gitignored — never
commit the real key.

Copy the tracked example env file and fill in the real values:

```bash
cp ios/fastlane/.env.example ios/fastlane/.env
```

Then edit `ios/fastlane/.env`:

```
ASC_KEY_ID=ABC123XYZ
ASC_ISSUER_ID=your-issuer-id
ASC_KEY_FILEPATH=./AuthKey_ABC123XYZ.p8
```

`ios/fastlane/.env` is gitignored (see root `.gitignore`). Fastlane loads
`.env` files from the `fastlane/` directory automatically — no extra gem or
manual `source` step needed.

## Installing and running Fastlane

```bash
cd ios && bundle install   # first time only, installs the `fastlane` gem
cd ios && bundle exec fastlane beta
```

The `beta` lane always calls `scripts/build_release_ipa.sh` to produce the
IPA, so `dart_defines.json` must already be provisioned locally (see
`docs/leave_reminder_setup.md`) — the lane fails fast the same way the
script does if it's missing. This also means dart-defines are never
silently skipped the way they would be with a manual Xcode Archive.

Once the build succeeds, the lane uploads the resulting `.ipa` from
`build/ios/ipa/` to TestFlight via the API key and returns without waiting
for Apple's build-processing step to finish (`skip_waiting_for_build_processing: true`).

## Adding external testers in bulk

Testers are listed in `ios/fastlane/testers.csv` (gitignored — it holds real
people's personal email addresses, not something to commit to a shared repo).
Each row is `first_name,last_name,email` (first/last may be left blank):

```bash
cp ios/fastlane/testers.csv.example ios/fastlane/testers.csv
```

Then run:

```bash
./scripts/add_testflight_testers.sh
```

This adds/updates every tester in the CSV into the app's "External Testers"
TestFlight group, authenticating with the same App Store Connect API key as
the `beta`/`distribute_beta` lanes. It's safe to re-run — existing testers
are just updated, not duplicated.

## Manual steps that still require the App Store Connect web UI

- Generating the API key itself — Apple only allows downloading the `.p8`
  once, at creation, so this can't be scripted or provisioned by any
  automated tool.
- Rotating or revoking a lost/compromised key — same limitation, must be
  done from **Users and Access → Integrations** in the web UI.
- Adding external testers or a TestFlight testing group for the first time,
  and answering export compliance questions on first submission.
