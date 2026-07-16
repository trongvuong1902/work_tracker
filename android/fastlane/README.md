fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## Android

### android beta

```sh
[bundle exec] fastlane android beta
```

Build the release APK (via repo build script) and distribute it via Firebase App Distribution

### android add_internal_testers

```sh
[bundle exec] fastlane android add_internal_testers
```

Add/update testers from android/fastlane/internal_testers.txt into the Firebase 'internal' testers group

### android add_nexsoft_testers

```sh
[bundle exec] fastlane android add_nexsoft_testers
```

Add/update testers from android/fastlane/nexsoft_testers.txt into the Firebase 'Nexsoft' testers group

### android internal

```sh
[bundle exec] fastlane android internal
```

Build the release AAB (via repo build script) and upload it to the Play Store Internal testing track

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
