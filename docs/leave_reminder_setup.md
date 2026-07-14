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
