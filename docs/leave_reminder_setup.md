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

## iOS: populate `ios/Flutter/Secrets.xcconfig`

Copy the tracked example and fill in the real key:

```bash
cp ios/Flutter/Secrets.xcconfig.example ios/Flutter/Secrets.xcconfig
```

Then edit `ios/Flutter/Secrets.xcconfig`:

```
GOOGLE_MAPS_API_KEY = your-real-key-here
```

`Secrets.xcconfig` is gitignored (see root `.gitignore`) and is included
(optionally, via `#include?`) from both `ios/Flutter/Debug.xcconfig` and
`ios/Flutter/Release.xcconfig`. The value flows: xcconfig variable ->
`Info.plist`'s `GMSApiKey` key (`$(GOOGLE_MAPS_API_KEY)`) ->
`AppDelegate.swift`, which reads it via
`Bundle.main.object(forInfoDictionaryKey: "GMSApiKey")` and calls
`GMSServices.provideAPIKey(...)`. If the key is missing, the app still
builds/launches; the map view just won't render tiles.

This only wires up the **native** Maps SDK key used for map rendering — it
does *not* supply the key the Dart-side Distance Matrix HTTP client needs
(see next section).

## Dart side: populate `dart_defines.json`

`lib/di/register_module.dart` reads the commute-routing key via
`String.fromEnvironment('GOOGLE_MAPS_API_KEY')`, which is a Dart
**compile-time** define — separate from both the Android/iOS native config
above. Without it, every build (debug, profile, *and* release) resolves the
key to an empty string and Distance Matrix requests fail.

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
