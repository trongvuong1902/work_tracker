# Release flow

How WorkTracker moves code through three audience tiers — **internal**, **public testers**, and
**production** — using a lightweight Gitflow and the existing Fastlane lanes. This owns the
*branching + audience* model; the *version-number* policy lives in [versioning.md](versioning.md)
(read both before a release).

## The three tiers

| Tier | Who | Git source | iOS channel | Android channel | Config |
|------|-----|-----------|-------------|-----------------|--------|
| **Internal** | You + trusted teammates | `develop` | TestFlight internal (auto-receive) | Firebase App Distribution, group `internal` | `dart_defines.internal.json` — **AI key baked in** |
| **Public testers** | External beta group | `release/X.Y` | TestFlight External group | Firebase group `beta-testers` | `dart_defines.prod.json` — **AI key omitted** |
| **Production** | Everyone (stores) | `master` @ tag `vX.Y.Z` | App Store | — (Firebase only; no Play Store lane) | `dart_defines.prod.json` |

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
./scripts/ship_beta.sh                       # TestFlight (upload) + Firebase beta-testers
cd ios && bundle exec fastlane distribute_beta   # promote to TestFlight External group (Apple review)
```
Land only bugfixes on `release/1.2` afterward, and merge them back into `develop`.

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

- iOS `TESTFLIGHT_GROUP` — `.env.example` says `External Testers`; the live `ios/fastlane/.env` uses
  `Nexsoft`. `distribute_beta` sends to whatever `TESTFLIGHT_GROUP` resolves to.
- Android `FIREBASE_GROUP` — `.env.example` says `beta-testers`; the live `android/fastlane/.env`
  uses `Nexsoft`. `ship_internal.sh` overrides this to `internal` inline; `ship_beta.sh` uses the
  `.env` value.
- Firebase group rosters are managed by `bundle exec fastlane android add_internal_testers` /
  `add_nexsoft_testers`; TestFlight external testers by `./scripts/add_testflight_testers.sh`.

## Fastlane lanes referenced here

| Platform | Lane | Purpose |
|---|---|---|
| iOS | `beta` | build IPA + upload to TestFlight (internal auto-receive) |
| iOS | `distribute_beta` | promote latest build to the External Testers group |
| iOS | `release` | build IPA + submit to the App Store (production) |
| Android | `beta` | build APK + Firebase App Distribution (`FIREBASE_GROUP`) |
| Android | `internal` | build APK + Firebase App Distribution (group `internal`) |
