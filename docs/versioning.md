# Versioning & release builds

How WorkTracker versions builds across iOS (TestFlight) and Android (Firebase App
Distribution beta + Play Store internal). Two independent things — the **version name** and the
**build number** — must never be conflated.

## Version name — `MAJOR.MINOR.PATCH` (SemVer)

`pubspec.yaml` `version: X.Y.Z+N`. The `X.Y.Z` part is the **single source of truth for the version
name** on all channels, and is bumped **deliberately by a human in a commit** — CI (Fastlane)
**never** writes the version name.

- **MAJOR** — a breaking change (e.g. an ObjectBox migration that drops/repurposes stored data, or
  removing a core flow).
- **MINOR** — a new user-facing feature, added additively (e.g. ZenTao bug sync → `1.1.0`). Reset
  PATCH to 0.
- **PATCH** — bug fixes, performance, copy tweaks only; no new feature surface.

## Build number / versionCode — a monotonic machine counter

The `+N` suffix (Android `versionCode`, iOS `CFBundleVersion`) identifies a *build* of a given
name. It must be **strictly increasing and never reused**. The version name can stay fixed across
many betas while the build number climbs — betas read like `1.1.0 (11)`, `1.1.0 (12)`, **not**
`1.0.6 → 1.0.10`. CI overrides it per channel; `pubspec.yaml`'s `+N` is only a floor for local
builds.

- **iOS (TestFlight → App Store):** one counter — `latest_testflight_build_number + 1`
  (`ios/fastlane/Fastfile` `beta`).
- **Android — one unified counter across Firebase beta AND Play Store.** Both lanes draw from
  `max(latest Firebase buildVersion, latest Play versionCode) + 1` via the
  `next_android_version_code` private_lane in `android/fastlane/Fastfile`. Keeping them unified means
  a Firebase tester is never blocked from a Play upgrade (Android refuses `versionCode` downgrades).

### Why a new Firebase upload must have a higher versionCode

Firebase App Distribution keys a release by **versionName + versionCode**. If you upload a build
whose (name, code) matches an existing release, Firebase treats it as the **same release** and just
updates it (e.g. its notes) — it does **not** appear as a new/latest release. The old `beta` lane
never set `BUILD_NUMBER`, so `versionCode` was pinned and new uploads didn't register as new. The
`next_android_version_code` counter fixes this: every upload gets a strictly higher code, so it
always lands as a distinct new/latest release.

## Shipping a beta to both channels

One statement builds and uploads a fresh beta to **both** TestFlight and Firebase:

```bash
./scripts/ship_beta.sh
```

It runs `ios/fastlane beta` (IPA → TestFlight) then `android/fastlane beta` (APK → Firebase). Both
take the version name from `pubspec.yaml` and auto-increment their own build number.

For **internal testers only** (iOS TestFlight internal testers + Firebase `internal` group):

```bash
./scripts/ship_internal.sh
```

iOS internal testers auto-receive every uploaded build (no review/group); the Android lane is run
with `FIREBASE_GROUP=internal`.

To ship a single channel, run that lane directly:

```bash
cd ios && bundle exec fastlane beta        # TestFlight only
cd android && bundle exec fastlane beta    # Firebase only
cd android && bundle exec fastlane internal # Play Store internal track (AAB)
```

## Release checklist

1. Decide the SemVer bump and edit `pubspec.yaml` `version:` accordingly (feature → MINOR, fix →
   PATCH). CI won't do this for you.
2. Commit the bump.
3. `./scripts/ship_beta.sh` (or a single lane) to build & upload.
4. Verify the resulting build number is strictly higher than the previous one on that channel.

## Release builds always start from a clean state

`scripts/build_release_apk.sh`, `build_release_aab.sh`, and `build_release_ipa.sh` each run
`fvm flutter clean` before building. Without it the Android Gradle/Flutter build could reuse a cached
`libapp.so` and ship a **stale Dart snapshot under a freshly-bumped version** — the manifest reads
the new version (name/code are injected at the Gradle layer) while the app runs old code. Correctness
matters more than build speed for releases, so every release build recompiles from scratch.

## Notes / caveats

- The Firebase release object exposes the build number as `buildVersion` (name is `displayVersion`).
  If a future plugin version renames this, update `next_android_version_code`.
- Play Store release notes are **not** wired into the `internal` lane (it skips metadata); only the
  Firebase `beta` lane applies release notes (`FIREBASE_RELEASE_NOTES`).
- Prerequisites and credentials for each lane are covered by the release-engineer agent contract and
  `docs/fastlane_*`/`docs/play_store_setup.md`.
