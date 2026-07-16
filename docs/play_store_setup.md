# Google Play Store uploads: local setup

> **Important — read this before doing anything else.** Google requires the
> **very first release** of a new app to be uploaded **manually** through the
> Play Console web UI before the Play Developer API — and therefore
> `fastlane`'s `internal` lane, which uses that API — will accept **any**
> upload for that package. Steps 1-7 below are a one-time, by-hand bootstrap
> for release #1. The `internal` fastlane lane described later in this doc
> only starts working from **release #2 onward**.

Uploading a release build to the Play Store is automated via Fastlane
(`android/fastlane/Fastfile`, lane `internal`) once bootstrapped. It
authenticates to the Play Developer API using a **GCP service-account JSON
key**, mirroring why the Firebase and iOS pipelines use scoped,
non-interactive credentials instead of a personal Google/Apple account login
(see `docs/fastlane_firebase_distribution_setup.md` and
`docs/fastlane_testflight_setup.md`).

## One-time manual bootstrap (release #1)

### 1. Create the app in Play Console

In the [Play Console](https://play.google.com/console), create a new app
with package name **`io.fury.workTracker`** — this must match
`android/app/build.gradle.kts`'s `applicationId` exactly.

### 2. Generate the upload keystore

```bash
keytool -genkey -v -keystore android/fastlane/upload-keystore.jks \
  -keyalg RSA -keysize 2048 -validity 9125 -alias upload
```

This `.jks` file signs every release build going forward. It must **never**
be committed — it's gitignored via `/android/fastlane/*.jks` (see root
`.gitignore`). Back it up somewhere safe outside the repo; losing it (before
opting into Play App Signing in step 5) means losing the ability to update
the app under the same package name.

### 3. Store listing content

Before the app can be published (even to internal testing in some cases),
Play Console requires store listing content: title, short/full description,
screenshots, feature graphic, hi-res icon, app category, and a contact
email.

**TODO (product owner):** none of this content exists yet — it needs to be
authored and uploaded directly in Play Console. This doc does not fill it in.

### 4. App content declarations

Play Console also requires several compliance declarations before
publishing:

- **Privacy policy URL** — does not exist yet. **TODO:** must be authored and
  hosted somewhere (e.g. a simple static page), then linked in Play Console.
- **Data safety form** — **TODO (product owner sign-off required):** this
  form asks exactly what data is collected (e.g. location for attendance
  tracking, Crashlytics crash/diagnostics data) and why, and who it's shared
  with. This doc intentionally does not author specific answers — get
  product-owner sign-off first.
- **Content rating questionnaire** — fill in via Play Console.
- **Target audience** declaration — fill in via Play Console.
- **Ads declaration** — likely "No ads" (no ad SDK is currently present in
  `pubspec.yaml`), but confirm this is still accurate at publish time before
  declaring it.

### 5. Build and upload release #1 by hand

Export the keystore credentials from `.env` into your shell (see step 8 for
how `.env` is provisioned), then build the AAB:

```bash
set -a; source android/fastlane/.env; set +a
./scripts/build_release_aab.sh
```

Then, in Play Console, go to **Testing → Internal testing → Create new
release** and manually upload the resulting `.aab` from
`build/app/outputs/bundle/release/`. When prompted, **opt into Play App
Signing** — Google re-signs the app for distribution while your upload
keystore (from step 2) only signs the upload artifact.

### 6. Add internal testers

Go to **Testing → Internal testing → Testers** and add testers there.
Unlike Firebase App Distribution, there is **no fastlane automation for
this** — tester list management for the Play Store stays a manual Play
Console step, indefinitely.

### 7. Set up API access for future automated releases

In **Play Console → Setup → API access**, create (or link) a GCP service
account. Download its JSON key. Then, in **Play Console → Users and
permissions**, grant that service account access with **least privilege**:
testing-track release permission only — no production, no app content, no
financial data permissions.

## Provisioning credentials locally

Copy the tracked example env file and fill in the real values:

```bash
cp android/fastlane/.env.example android/fastlane/.env
```

Then edit `android/fastlane/.env` and fill in the `PLAY_STORE_*` and
`ANDROID_KEYSTORE_*` values (package name, path to the downloaded
service-account JSON key, and the upload keystore path/passwords/alias from
step 2). `android/fastlane/.env` is gitignored — never commit it. All
`*.json`, `*.jks`, and `*.keystore` files under `android/fastlane/` are also
gitignored — never commit the service-account key or the keystore itself.

## From release #2 onward: the `internal` fastlane lane

Once release #1 has been uploaded manually and API access is granted:

```bash
cd android && bundle exec fastlane internal
```

This lane calls `scripts/build_release_aab.sh` to produce the AAB (so
`dart_defines.json` must already be provisioned locally — see
`docs/leave_reminder_setup.md`), then uploads it to the Play Store track
configured via `PLAY_STORE_TRACK` (defaults to `internal`) using
`upload_to_play_store`, with `release_status: "completed"` and metadata/image
uploads skipped (store listing content is managed manually in Play Console,
per step 3/4 above).

### Note on versionCode

The `internal` lane auto-increments the Play Store `versionCode` by querying
the **max versionCode already present on the target track**
(`google_play_track_version_codes`) and adding 1 — passed to
`scripts/build_release_aab.sh` as `BUILD_NUMBER`. This is:

- **Independent of `pubspec.yaml`'s version** — it does not read or bump the
  version string there.
- **Independent of iOS's TestFlight build-number sequence** — Android and
  iOS build numbers can diverge; this is expected, not a bug.

## Manual steps that stay manual forever

- **Tester list management** — adding/removing internal testers in Play
  Console; there is no fastlane automation for this (see step 6).
- **Content and compliance declarations** — store listing, privacy policy,
  data safety form, content rating, target audience, ads declaration; these
  require human judgment and product-owner sign-off, not automation.
- **Key rotation** — rotating the upload keystore or the service-account
  JSON key if either is lost or compromised requires manual action in Play
  Console / GCP IAM.
- **Creating any future additional test tracks** (e.g. closed/open testing,
  production) — must be created once in Play Console before any lane can
  target them.
