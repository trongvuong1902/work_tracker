# Fastlane Firebase App Distribution uploads: local setup

Distributing a release build to Android testers is automated via Fastlane
(`android/fastlane/Fastfile`, lane `beta`). It authenticates to Firebase
using a **GCP service-account JSON key** rather than a personal
`firebase login:ci` token — the key is scoped to the Firebase project (not a
personal Google account), works non-interactively, and is independently
revocable/rotatable from GCP IAM. This mirrors why the iOS pipeline uses an
App Store Connect API key instead of an Apple ID + 2FA session (see
`docs/fastlane_testflight_setup.md`).

Firebase App Distribution does **not** require embedding the Firebase SDK in
the app — no `google-services.json`, no new Gradle plugin, no new pubspec
dependency. It's a pure build-time upload-and-notify mechanism keyed off a
Firebase App ID and that service-account credential.

## Creating the Firebase project and Android app

1. In the [Firebase console](https://console.firebase.google.com), create a
   project (or pick an existing one for WorkTracker).
2. Add an Android app to it with package name **`io.fury.workTracker`**
   (must match `android/app/build.gradle.kts`'s `applicationId` exactly).
   Skip downloading `google-services.json` — it isn't needed for App
   Distribution alone.
3. Note the app's **Firebase App ID**, shown on the app's Settings page —
   it looks like `1:1234567890:android:abcabcabcabcabcabc`.

## Enabling App Distribution and creating a testers group

1. Open **Release & Monitor → App Distribution** for the Android app and
   accept the terms to enable it (or it auto-enables on first `fastlane`
   upload).
2. Create a testers group/alias — either in the console UI, or via the
   Firebase CLI (already installed locally):
   ```bash
   firebase appdistribution:group:create "Beta Testers" beta-testers
   ```
   The second argument (`beta-testers`) is the **group alias**, used as
   `FIREBASE_GROUP` below.

## Creating the service account key

In [Google Cloud Console](https://console.cloud.google.com) for the same
project, go to **IAM & Admin → Service Accounts**, create a new service
account, and grant it the **Firebase App Distribution Admin** role only
(least privilege — do not grant broader Editor/Owner). Generate a JSON key
for it and download it; unlike Apple's `.p8`, this key can be re-downloaded
or a new one generated at any time from the same page if lost.

## Provisioning the key locally

Save the downloaded key under `android/fastlane/`, e.g.:

```
android/fastlane/firebase-service-account.json
```

This path and all `*.json` files under `android/fastlane/` are gitignored —
never commit the real key.

Copy the tracked example env file and fill in the real values:

```bash
cp android/fastlane/.env.example android/fastlane/.env
```

Then edit `android/fastlane/.env`:

```
FIREBASE_APP_ID=1:1234567890:android:abcabcabcabcabcabc
FIREBASE_SERVICE_ACCOUNT_FILEPATH=./firebase-service-account.json
FIREBASE_GROUP=beta-testers
FIREBASE_RELEASE_NOTES="Bug fixes and improvements."
```

`android/fastlane/.env` is gitignored (see root `.gitignore`). Fastlane
loads `.env` files from the `fastlane/` directory automatically.

## Installing and running Fastlane

```bash
cd android && bundle install   # first time only, installs fastlane + the firebase_app_distribution plugin
cd android && bundle exec fastlane beta
```

The `beta` lane always calls `scripts/build_release_apk.sh` to produce the
APK, so `dart_defines.json` must already be provisioned locally (see
`docs/leave_reminder_setup.md`) — the lane fails fast the same way the
script does if it's missing. That script also syncs `GOOGLE_MAPS_API_KEY`
from `dart_defines.json` into `android/local.properties` automatically, so
you only ever need to edit `dart_defines.json` by hand.

Unlike TestFlight, Firebase App Distribution has no separate review-gated
"submit to external testers" step — `firebase_app_distribution` uploads the
APK **and** notifies the configured group's testers in the same call. There
is no `distribute_beta`-equivalent lane because there's nothing separate
left to do.

## Adding testers in bulk

There are two Firebase App Distribution groups — `internal` and `Nexsoft` —
each with its own gitignored tester list (real people's personal email
addresses, not something to commit to a shared repo), one email per line:

```bash
cp android/fastlane/internal_testers.txt.example android/fastlane/internal_testers.txt
cp android/fastlane/nexsoft_testers.txt.example android/fastlane/nexsoft_testers.txt
```

Then run whichever lane matches the group you're updating:

```bash
cd android && bundle exec fastlane add_internal_testers
cd android && bundle exec fastlane add_nexsoft_testers
```

Each lane adds/updates every tester in its file into the corresponding
Firebase group, authenticating with the same service-account key as the
`beta` lane. It's safe to re-run — existing testers are just updated, not
duplicated.

## Google Maps API key restrictions

If the `GOOGLE_MAPS_API_KEY` used in `dart_defines.json` has Android API-key
restrictions configured in Google Cloud Console (package name + SHA-1
fingerprint), add this app's signing certificate's SHA-1 there too, or maps
will silently fail to load for distributed testers. The app currently signs
release builds with the **debug** keystore (see
`android/app/build.gradle.kts`) — there is no dedicated release keystore
yet, so the SHA-1 to register is whatever `debug.keystore`'s is
(`./gradlew signingReport` from `android/` prints it). This is a known,
deliberate gap — see `android/app/build.gradle.kts`'s `release` buildType
comment — and should be revisited if/when a real Play Store release
keystore is introduced.

## Manual steps that still require the Firebase/GCP web console

- Creating the Firebase project and registering the Android app.
- Creating the service account and granting it the App Distribution Admin
  role, and generating its JSON key.
- Creating the initial App Distribution testers group.
