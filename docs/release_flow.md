# Release flow

How WorkTracker moves code through three audience tiers — **internal**, **public testers**, and
**production** — using a lightweight Gitflow and the existing Fastlane lanes. This owns the
*branching + audience* model; the *version-number* policy lives in [versioning.md](versioning.md)
(read both before a release).

## The three tiers

| Tier | Who | Git source | iOS channel | Android channel | Config |
|------|-----|-----------|-------------|-----------------|--------|
| **Internal** | You + trusted teammates | `develop` | TestFlight internal (auto-receive) | Firebase App Distribution, group `internal` | `dart_defines.internal.json` — **AI key baked in** |
| **Public testers** | External beta group | `release/X.Y` | TestFlight External group (`Nexsoft`) | Firebase group `Nexsoft` (Play **Closed testing** optional, run manually) | `dart_defines.prod.json` — **AI key omitted** |
| **Production** | Everyone (stores) | `master` @ tag `vX.Y.Z` | App Store | Play `production` track | `dart_defines.prod.json` |

The only build difference between tiers is **config, not code**: internal builds carry `AI_API_KEY`
so the in-app "Resolve with AI" works; public/prod builds leave it empty, so `AiClient.isConfigured`
is false and AI self-disables. See `dart_defines.internal.json.example` and
`dart_defines.prod.json.example` for the two templates (both gitignored once filled in).

## Branching model (Gitflow-lite)

```
feature/*  ──┐ (branch off develop, PR back)
             ▼
develop    ──●──●──●──●──●──●        →  INTERNAL       (every merge is eligible)
                     │
             cut release/X.Y when a feature set is ready for outside eyes
                     ▼
release/X.Y ─────────●──●──●          →  PUBLIC TESTERS (only bugfixes land here)
                           │
              merge to master + tag when approved
                           ▼
master     ────────────────●          →  PRODUCTION    (tagged vX.Y.Z)
                           │ (merge master back into develop)
hotfix/*   (branch off master for urgent prod fixes → tag patch → merge to master + develop)
```

- **`develop`** is the integration trunk. Feature branches (`feature/*`, or the `feat/*` style
  already in use) branch off it and PR back. Anything merged here is internal-tester material.
- **`release/X.Y`** freezes scope for a version. New features do **not** land here — only
  stabilization fixes, which are then merged back to `develop`.
- **`master`** always reflects what is (or is being) submitted to the stores, and every production
  release is tagged `vX.Y.Z`. (No tags exist yet — the first production release starts the sequence.)

## Runbooks

### Ship to internal testers (from `develop`)
```bash
git checkout develop
# (ensure dart_defines.internal.json exists — copy from the .example and fill AI_API_KEY)
./scripts/ship_internal.sh
```
iOS internal testers auto-receive the build; Android lands in the Firebase `internal` group. Each run
gets a strictly higher build number (see [versioning.md](versioning.md)).

### Cut a public-tester release
```bash
git checkout develop && git pull
git checkout -b release/1.2                 # X.Y for the version you're stabilizing
# bump pubspec.yaml version: 1.2.0+<n>  (MINOR for new features — see versioning.md), commit
./scripts/ship_beta.sh                       # iOS TestFlight external (Nexsoft) + Android Firebase (Nexsoft)
# optional: cd android && bundle exec fastlane closed   # also push AAB to Play Closed testing (alpha)
```
`ship_beta.sh` distributes to public testers on two channels automatically:

- **iOS** (`beta_external`): builds, uploads, **waits for Apple to finish processing** (~10-30 min),
  then pushes to the `TESTFLIGHT_GROUP` (Nexsoft) group. The first external build of a version then
  passes Apple's async beta review before testers see it. To promote a build that was *already
  uploaded* (rather than build a fresh one), use `cd ios && bundle exec fastlane distribute_beta`.
- **Android**: Firebase App Distribution (group `Nexsoft`, roster synced from `nexsoft_testers.txt`
  first via `add_nexsoft_testers`).

Play **Closed testing** is **not** part of this auto flow — to also ship the public build to the Play
`alpha` track, run `cd android && bundle exec fastlane closed` manually (only works after the
one-time Play Console bootstrap — app record, store listing, compliance, manual release #1 + Play App
Signing, API access, testers added to the Closed testing track; see
[play_store_setup.md](play_store_setup.md)). Land only bugfixes on `release/1.2` afterward, and merge
them back into `develop`.

### Promote to production
```bash
git checkout master && git pull
git merge --no-ff release/1.2
# ensure pubspec.yaml version name is final (e.g. 1.2.0), commit if needed
git tag v1.2.0 && git push origin master --tags
./scripts/ship_production.sh                 # iOS App Store submit (Android: Firebase only)
git checkout develop && git merge --no-ff master && git push   # don't lose release fixes
```
`ship_production.sh` refuses to run off `master` without confirmation and requires
`dart_defines.prod.json`. It submits the iOS build for review with `automatic_release: false`, so you
tap **Release** in App Store Connect after approval. Android has no production store lane — Android
distribution is Firebase App Distribution only (internal/beta).

### Hotfix a production bug
```bash
git checkout master && git pull
git checkout -b hotfix/1.2.1
# fix, bump pubspec.yaml to 1.2.1+<n> (PATCH), commit
git checkout master && git merge --no-ff hotfix/1.2.1
git tag v1.2.1 && git push origin master --tags
./scripts/ship_production.sh
git checkout develop && git merge --no-ff master && git push
```

## Tester groups — mind the drift

The committed `.env.example` files and the live `.env` files disagree, so confirm the target group
before a public release:

The public flow (`ship_beta.sh`) targets **Nexsoft** on both platforms: iOS via `beta_external`
(external distribution, blocks on Apple processing), Android via Firebase (`beta`). The Play
**Closed testing** (`alpha`) track is available via the `closed` lane but is run manually, not by
`ship_beta.sh`.

- iOS `TESTFLIGHT_GROUP` — `.env.example` says `External Testers`; the live `ios/fastlane/.env` uses
  `Nexsoft`. Both `beta_external` and `distribute_beta` send to whatever `TESTFLIGHT_GROUP` resolves
  to.
- Android `FIREBASE_GROUP` — `.env.example` says `beta-testers`; the live `android/fastlane/.env`
  uses `Nexsoft`. `ship_internal.sh` pins this to `internal` inline; `ship_beta.sh` pins it to
  `Nexsoft` inline (so the public target can't drift with `.env`).
- Android `PLAY_CLOSED_TRACK` — the Play track the `closed` lane uploads to; defaults to `alpha`
  (Play's built-in Closed testing track).
- **Roster management differs by channel.** Firebase group rosters are managed by
  `bundle exec fastlane android add_internal_testers` / `add_nexsoft_testers` (and `ship_beta.sh`
  auto-syncs Nexsoft before shipping); TestFlight external testers by
  `./scripts/add_testflight_testers.sh`. **Play Store testers have no fastlane automation** — add
  them by hand in Play Console → Testing → Closed testing → Testers (see
  [play_store_setup.md](play_store_setup.md)).

## Fastlane lanes referenced here

| Platform | Lane | Purpose |
|---|---|---|
| iOS | `beta` | build IPA + upload to TestFlight (internal auto-receive) |
| iOS | `beta_external` | build IPA + upload + wait for processing + distribute to the External Testers group |
| iOS | `distribute_beta` | promote an already-uploaded build to the External Testers group |
| iOS | `release` | build IPA + submit to the App Store (production) |
| Android | `beta` | build APK + Firebase App Distribution (`FIREBASE_GROUP`) |
| Android | `closed` | build AAB + Play Closed testing track (`PLAY_CLOSED_TRACK`, default `alpha`) |
| Android | `internal` | build AAB + Play `internal` track |
| Android | `production` | build AAB + Play `production` track |
| Android | `promote_to_production` | promote the latest internal-track build to production (no rebuild) |
