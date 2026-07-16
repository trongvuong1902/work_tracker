# Leave-reminder notifications: local setup

The leave-reminder feature (`lib/features/leave_reminder/`) needs a Google
Maps API key at build time for both platforms, plus a couple of native
permission/background-task registrations. This key is **not** committed to
git — each engineer (and CI) must provision it locally before building.

## Google Cloud setup

Create (or reuse) a Google Cloud project with billing enabled, and create a
single API key with the following APIs enabled:

- **Maps SDK for Android**
- **Maps SDK for iOS**
- **Distance Matrix API** (used for traffic-aware commute time)
- **Places API** (used for the location picker's address-search autocomplete
  and place-details lookup)
- **Geocoding API** (used to reverse-geocode a picked coordinate into a
  human-readable address in the location picker)

Both `GOOGLE_MAPS_API_KEY` and `GOOGLE_MAPS_API_KEY_DEV` need all of the
above APIs enabled the same way — the dev key isn't a reduced subset.

Restrict the key per-platform (Android app + SHA-1, iOS bundle ID) once you
have one, to avoid it being usable outside this app.

## Android: populate `android/local.properties`

`android/local.properties` is already gitignored (see `android/.gitignore`).
Add a line to your local copy:

```properties
GOOGLE_MAPS_API_KEY=your-real-key-here
```

`android/app/build.gradle.kts` reads this property and wires it into
`AndroidManifest.xml` via `manifestPlaceholders["GOOGLE_MAPS_API_KEY"]`,
which the manifest's `<meta-data android:name="com.google.android.geo.API_KEY" .../>`
entry references as `${GOOGLE_MAPS_API_KEY}`. If the property is missing,
the build still succeeds with an empty key (Maps just won't load).

### Dev flavor uses a separate key

The `dev` product flavor ships under a different `applicationId`
(`io.fury.workTracker.dev`) than `prod` (`io.fury.workTracker`). If your
Google Cloud key has Android application restrictions (package name +
SHA-1), it's restricted to the *prod* package and won't authorize the dev
flavor's Maps SDK calls. Add a second property for it:

```properties
GOOGLE_MAPS_API_KEY_DEV=your-dev-key-here
```

`build.gradle.kts` reads `GOOGLE_MAPS_API_KEY_DEV` and applies it only to the
`dev` product flavor (overriding the default `GOOGLE_MAPS_API_KEY` for that
variant); `prod` is unaffected. If `GOOGLE_MAPS_API_KEY_DEV` is left unset,
it falls back to the same value as `GOOGLE_MAPS_API_KEY`, so dev builds keep
working until you provision a real, separately-restricted dev key (needed if
you want application-restricted keys per flavor; an unrestricted or
IP-restricted key can safely be shared across both).

## iOS: populate `ios/Flutter/Secrets.xcconfig`

Copy the tracked example and fill in the real key:

```bash
cp ios/Flutter/Secrets.xcconfig.example ios/Flutter/Secrets.xcconfig
```

Then edit `ios/Flutter/Secrets.xcconfig`:

```
GOOGLE_MAPS_API_KEY = your-real-key-here
GOOGLE_MAPS_API_KEY_DEV = your-dev-key-here
```

`Secrets.xcconfig` is gitignored (see root `.gitignore`) and is included
(optionally, via `#include?`) from `Debug.xcconfig`/`Release.xcconfig` (prod
scheme) and `Debug-dev.xcconfig`/`Release-dev.xcconfig`/`Profile-dev.xcconfig`
(dev scheme). The value flows: xcconfig variable ->
`Info.plist`'s `GMSApiKey` key (`$(GOOGLE_MAPS_API_KEY)`) ->
`AppDelegate.swift`, which reads it via
`Bundle.main.object(forInfoDictionaryKey: "GMSApiKey")` and calls
`GMSServices.provideAPIKey(...)`. If the key is missing, the app still
builds/launches; the map view just won't render tiles.

Same reasoning as Android: the `*-dev.xcconfig` files override
`GOOGLE_MAPS_API_KEY` with `$(GOOGLE_MAPS_API_KEY_DEV)` after including
`Secrets.xcconfig`, since the dev scheme's bundle id differs from prod and an
iOS-application-restricted key won't authorize it. Unset
`GOOGLE_MAPS_API_KEY_DEV` (or left equal to the prod value) keeps dev builds
working with the same key until a real one is provisioned.

This only wires up the **native** Maps SDK key used for map rendering — it
does *not* supply the key the Dart-side Distance Matrix HTTP client needs
(see next section).

## Dart side: populate `dart_defines.json`

`lib/di/register_module.dart`'s commute-routing client, plus the location
picker's `PlacesClient`/`ReverseGeocodingClient`
(`lib/features/leave_reminder/data/places_client.dart` and
`reverse_geocoding_client.dart`), all read the same key via
`String.fromEnvironment('GOOGLE_MAPS_API_KEY')`, which is a Dart
**compile-time** define — separate from both the Android/iOS native config
above. Without it, every build (debug, profile, *and* release) resolves the
key to an empty string and Distance Matrix/Places/Geocoding requests fail.

Copy the tracked example and fill in the real key:

```bash
cp dart_defines.json.example dart_defines.json
```

`dart_defines.json` is gitignored (see root `.gitignore`). VS Code's
`.vscode/launch.json` already passes `--dart-define-from-file=dart_defines.json`
for all three run configs, so `flutter run`/debugging from the IDE picks it
up automatically. For CLI/CI builds, pass the same flag explicitly:

```bash
flutter build ios --release --dart-define-from-file=dart_defines.json
flutter build ipa --release --dart-define-from-file=dart_defines.json
```

If you archive directly from Xcode's UI (Product → Archive) instead of via
`flutter build ipa`, this flag never reaches the build — Xcode's archive
action doesn't invoke the Flutter CLI with it. Prefer `flutter build ipa`
for release archives so the define is always applied. See "Release /
Archive builds" below for the supported way to do this.

Note: a Google Cloud key restricted by "Android apps" / "iOS apps"
application restrictions (as set up above for the native Maps SDK) is
**not** honored by the Distance Matrix REST API — those restrictions only
apply to calls made through the native Maps SDKs. If you reuse the same key
for both, either leave it unrestricted or restrict by IP instead; otherwise
provision a second, separately-restricted key just for Distance Matrix.

## Release / Archive builds

Do **not** produce the App Store build via Xcode's Product → Archive menu
directly — it packages whatever's already built and never calls
`flutter build`, so the `--dart-define-from-file=dart_defines.json` flag
described above is skipped entirely. The resulting IPA still builds and
installs fine, it just silently ships with an empty `GOOGLE_MAPS_API_KEY`,
breaking commute estimates for all users.

Instead, always build release IPAs with:

```bash
./scripts/build_release_ipa.sh
```

This wraps `fvm flutter build ipa --release --dart-define-from-file=dart_defines.json`
and fails fast with a clear error if `dart_defines.json` is missing. Once
it finishes, open the generated archive in Xcode (or use
`xcrun altool`/Transporter) to upload to App Store Connect as usual —
Xcode's Archive UI is fine for the *upload* step, just not for producing
the build itself.

## Manual steps that still require Xcode/Android Studio

- Actually filling in the real API key in `android/local.properties` and
  `ios/Flutter/Secrets.xcconfig` (both gitignored, machine-local files —
  no agent/CI script can populate them with a real key).
- Xcode's "Signing & Capabilities" tab may show "Background Modes" as
  unchecked even though `UIBackgroundModes` (`fetch`, `processing`) is
  already present in `Info.plist` and functionally sufficient for
  `workmanager`'s background refresh — this is cosmetic; ticking the boxes
  in Xcode just re-writes the same plist array. No functional entitlement
  file is required for these two modes specifically.
- Running `pod install` (iOS) / a Gradle sync (Android) after pulling these
  changes, so `GoogleMaps`/`workmanager_apple`/`flutter_local_notifications`
  native dependencies actually get resolved.
- Testing Maps rendering, notification scheduling, and exact-alarm behavior
  on a real device — these are unreliable or unsupported on simulators.
