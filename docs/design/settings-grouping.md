# Settings page — grouped sections

## Overview
The Settings page was a flat list of individually rounded cards with no grouping, so unrelated items (reminders, work schedule, integrations, appearance, about, debug) all read as one undifferentiated column. This refactor groups related items into titled sections rendered as an iOS-style grouped list. It lives on the Settings tab (`AppRoutes.settings` = `/settings`, [lib/features/setting/presentation/pages/setting_page.dart](../../lib/features/setting/presentation/pages/setting_page.dart)). Presentation-only — no behavior, navigation, or data changes.

## Flow
Settings tab → scroll through six grouped sections. Each row either opens a modal setup sheet or navigates to a sub-page, then returns to Settings (statuses re-load on return).

## Screens
### Settings page
Top-to-bottom: screen title **Settings**, then one `SettingsSection` per group. Each section is an uppercase header label above a single rounded `ShadowCard` whose rows are stacked and separated by thin left-inset dividers.

Sections and rows:
1. **REMINDERS** — Leave reminders (status), Checkout reminder
2. **WORK** — Work schedule, Location activity (status)
3. **INTEGRATIONS** — Zentao account (status)
4. **GENERAL** — Appearance (inline theme `SegmentedButton`, no chevron)
5. **ABOUT** — app version caption line, Privacy Policy
6. **DEVELOPER** — Debug tools, ObjectBox database file (path + copy) — only in debug builds (`kDebugMode`)

Reused widgets/tokens: `ShadowCard`, `AppSpacing`, `AppTypography`, `context.colors` (`primary`/`textSecondary`/`divider`). New reusable widgets:
- **`SettingsSection`** ([widgets/settings_section.dart](../../lib/features/setting/presentation/widgets/settings_section.dart)) — uppercase header + grouped card with inset dividers; owns the trailing section gap.
- **`SettingsTile`** / **`SettingsTileStatus`** ([widgets/settings_tile.dart](../../lib/features/setting/presentation/widgets/settings_tile.dart)) — standard navigable row (label + optional trailing status + chevron); status text switches to primary/semibold when active.

## States
- **Loading:** version shows `Loading…`; Zentao row hides its status until loaded; status rows show no status text until their loader returns.
- **Populated:** each status reflects live state — Leave reminders (`Off` / `N of 2 locations set` / `Active`), Location activity (`On`/`Off`), Zentao (`Connected — <domain>` / `Not connected`, ellipsized).
- **Debug vs release:** Developer section only renders in debug builds.

## Interactions
- Leave reminders / Checkout reminder / Location activity / Zentao → open respective modal setup sheets; the three stateful ones re-load status on dismiss.
- Work schedule / Privacy Policy / Debug tools → push their pages.
- Appearance → switches theme live via `AppCubit`.
- ObjectBox copy button → copies DB path to clipboard with a snackbar.

## Data touchpoints
Displays: leave-reminder status, location-activity on/off, Zentao connection domain, app name/version/build, ObjectBox DB path. Captures nothing new — all inputs go through the existing sheets/pages.

## Open questions
- Header casing is uppercase (`REMINDERS`); switch to title case if preferred.
- No leading row icons (kept minimal); can be added later.
