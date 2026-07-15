# App icon regeneration

WorkTracker still ships the stock Flutter template launcher icon on both
platforms. The `flutter_launcher_icons` dev dependency (configured in the
root `pubspec.yaml`) regenerates every iOS (`ios/Runner/Assets.xcassets/AppIcon.appiconset/`)
and Android (`android/app/src/main/res/mipmap-*/ic_launcher.png`) icon size
from a single source image.

To (re)generate the launcher icons: drop your branded 1024x1024 `icon.png`
into `assets/icon/` (see `assets/icon/README.md` for the exact image
requirements), then run:

```bash
fvm flutter pub get
fvm dart run flutter_launcher_icons
```

This overwrites the existing icon files in place for both platforms. Rerun
the same command any time the source `assets/icon/icon.png` changes.
