# App icon source image

Drop the branded app icon here as `icon.png` to match the
`flutter_launcher_icons` config in the root `pubspec.yaml`. Requirements:

- Exactly **1024x1024px**.
- **PNG** format.
- **No transparency / alpha channel** — flatten to a solid background.
  iOS rejects icons that still have an alpha channel.
- **No rounded corners baked in** — iOS applies its own corner mask, so
  provide a square, full-bleed image.
- Filename must be exactly `icon.png` (this directory is otherwise empty
  until that file is added).

See `docs/app_icon_setup.md` for how to regenerate all iOS/Android icon
sizes from this file.
