# Leave Reminder Setup Sheet — Commute Waypoints (Stops)

## Overview

Leave reminders currently model the commute as a single leg: Home -> Work,
and the total commute duration used for notifications is that one leg's
duration. This adds support for up to 3 optional "stop" locations along the
route, so the commute becomes Home -> Stop 1 -> Stop 2 -> Stop 3 (max) ->
Work, with the total duration used for notifications becoming the sum of
each *enabled* leg's duration. This lives entirely inside the existing
`showLeaveReminderSetupSheet` modal bottom sheet's "Locations" section — no
new screen, route, or tab.

## Flow

Unchanged entry/exit; only the interaction inside the "Locations" section
grows:

1. Entry: post-check-in discovery prompt (`trigger` set) or Settings ->
   "Leave reminders" (`trigger` null) -> opens the modal bottom sheet.
2. User enables reminders, sets Home and Work (as today), and optionally adds
   0–3 stops via "Add a stop", which opens the existing location picker
   (`AppNavigator.pushLocationPicker`) each time.
3. User can toggle any stop on/off, tap a stop to re-pick its location, or
   remove a stop entirely, at any point, in any order.
4. Exit: user dismisses the sheet; all changes save immediately as they're
   made, same as every other control in this sheet today — no separate
   "Save" action.

## Screens

Single screen: **Leave Reminder Setup Sheet**, "Locations" section only.
Region by region, top to bottom:

1. **`_LocationsHeader`** — unchanged component, changed count math. Shows
   `"$setCount of $total set"` where `total = 2 + stops.length` and
   `setCount = (home set ? 1 : 0) + (work set ? 1 : 0) + stops.length`. Every
   stop that exists in the list counts as "set" toward both numbers the
   moment it's added, regardless of its enabled/disabled toggle — set/unset
   and enabled/disabled are independent axes, and this header only reflects
   the former. Net effect: the existing `isComplete = setCount >= total`
   completion check is untouched by stops (adding one increases numerator and
   denominator equally), so the header's completion state — and its
   "Both are needed to estimate your commute time..." caption, shown only
   while incomplete — continues to depend solely on Home and Work being set,
   unchanged in wording.
2. **"Set Home" row** (`_LocationRow`) — unchanged.
3. **Stop rows** (new — `_StopRow`, 0 to 3 instances, in the order each stop
   was added) — sit between the Home and Work rows, each in its own
   `ShadowCard` with the same `space8` vertical gap already used between
   Home/Work, so the vertical stack visually reads as the route order:
   Home -> Stop 1 -> Stop 2 -> Stop 3 -> Work. Each row is a single `Row`:
   - **Leading**: a 32dp numbered circle badge reusing the exact visual
     pattern already used for the working-days selector in
     `setting_schedule_page.dart` — filled `context.colors.primary`
     background with a white number when the stop is enabled; outlined
     (`context.colors.outline` border, `textSecondary` number) when disabled.
     The number is the stop's current position among stops (1, 2, or 3) —
     a display detail reflecting current route order, not a stored identity,
     so removing an earlier stop renumbers the ones after it.
   - **Middle** (`Expanded`, wrapped in its own `InkWell` so it doesn't
     conflict with the trailing controls' tap targets): the stop's
     address/name text (`AppTypography.label`), `textPrimary` when enabled,
     `textSecondary` when disabled (the "dimmed" treatment the product spec
     calls for). Tapping this area reopens
     `AppNavigator.pushLocationPicker(...)` with `initial` set to the stop's
     current point, to change its location — mirrors how tapping "Set Home"/
     "Set Work" works today.
   - **Trailing**: a standard Flutter `Checkbox` (no existing checkbox
     component/pattern found under `lib/shared/`, `lib/core/`, or
     `lib/components/`, so this introduces the app's first one — styled with
     `activeColor: context.colors.primary` to match the app's primary-color
     convention for active controls, no other new styling) to enable/disable
     the stop, immediately followed by an `IconButton(Icons.delete_outline)`
     to remove it entirely. Both are separate tap targets from the middle
     `InkWell`.
4. **"Add a stop" button** (new) — reuses the existing `SecondaryButton`
   component (outlined, icon + label, already supports `isLoading`):
   `icon: Icons.add`, label `"Add a stop"`. Placed directly after the last
   stop row (or directly after the Home row if there are no stops yet) and
   before the Work row — reinforcing that a new stop is inserted next in the
   sequence, right before Work. Available at any time, not gated on Home/Work
   being set. Tapping it opens the location picker immediately; canceling
   adds nothing; picking a location shows the button's own `isLoading`
   spinner while it's persisted, then a new `_StopRow` appears at the end of
   the stops list, enabled by default.
   - At 0 stops: button shown, plus a one-time caption below it (same
     caption style as the header's existing helper text): *"Optional — add
     up to 3 stops along your commute."*
   - At 1–2 stops: button shown, no caption.
   - At 3 stops (cap): button is replaced entirely by a caption line,
     *"Maximum of 3 stops reached."* — no disabled/greyed-out button is left
     in place.
5. **"Set Work" row** (`_LocationRow`) — unchanged, still always last.
6. **`_CommuteReadoutCard`** — no visual change. Its displayed minutes are
   understood to be a sum over only the currently-*enabled* legs of the
   route (Home -> first enabled stop -> ... -> Work); toggling a stop off
   changes the number without removing the stop or its saved location.

No new visual style, color, or spacing token is introduced other than the
`Checkbox` widget itself (see Interactions/Open questions) — everything else
reuses `ShadowCard`, `SecondaryButton`, the working-days circle-badge
pattern, and existing typography/spacing/color tokens exactly as used
elsewhere in this sheet.

## States

- **Loading** (initial sheet load): unchanged — centered spinner replaces
  the whole form; stops load together with Home/Work as part of the same
  initial fetch.
- **Zero stops**: only the "Add a stop" button (with its explanatory
  caption) appears between Home and Work; no stop rows rendered.
- **1–3 stops, all enabled**: all stop rows shown with filled badges,
  `textPrimary` address text, checked checkboxes.
- **Mixed enabled/disabled stops**: enabled rows shown normally; disabled
  rows shown dimmed (outlined badge, `textSecondary` address text,
  unchecked checkbox) — visually distinct at a glance, but still fully
  present with their saved location.
- **3-stop cap reached**: "Add a stop" button is replaced by the "Maximum of
  3 stops reached" caption; existing stops remain fully editable
  (toggle/edit/delete) — the cap only blocks adding a 4th.
- **Per-row in-flight states** (reusing the sheet's existing "replace the
  control being acted on with a small 16x16 spinner" convention):
  - Toggling a stop's checkbox -> checkbox replaced by a spinner while it
    saves (same idea as the top-level "Enable leave reminders" switch's own
    in-flight spinner).
  - Removing a stop -> delete icon replaced by a spinner while it saves.
  - Re-picking a stop's location (after returning from the picker) -> the
    row's trailing controls (checkbox + delete icon) are replaced by a
    spinner while it saves — same treatment as `isSettingHome`/
    `isSettingWord` today.
  - Adding a new stop -> the "Add a stop" button itself shows its own
    `isLoading` spinner (native `SecondaryButton` behavior) until the new
    row appears.
- **Error**: unchanged single error slot at the bottom of the sheet
  (`state.errorMessage`, red/error-colored text) — any failure adding,
  toggling, removing, or re-picking a stop's location surfaces there, same
  as the existing notification-permission error today. No per-row inline
  errors.

## Interactions

- Tap "Add a stop" -> opens `AppNavigator.pushLocationPicker(...)` -> on a
  picked location, a new enabled stop row is appended at the end of the
  stops list (immediately before Work).
- Tap a stop row's address/name text -> opens
  `AppNavigator.pushLocationPicker(...)` with `initial` set to that stop's
  current point -> on a picked location, that stop's saved location is
  replaced in place (position/number unchanged).
- Tap a stop row's checkbox -> toggles that stop's enabled/disabled state
  immediately (no confirmation) — this is the sole control that determines
  whether the stop's leg counts toward the total commute duration.
- Tap a stop row's delete icon -> removes that stop immediately, no
  confirmation dialog (matches the low-friction interaction style already
  used throughout this sheet; there's no existing destructive-confirmation
  pattern elsewhere in the app to depart from). Remaining stops after it
  renumber to close the gap.
- No drag-to-reorder anywhere — stops always display in the order they were
  added, which is also their route order.

## Data touchpoints

- Each stop displays a resolved address/name (falling back to a formatted
  lat/long, matching the same fallback already used elsewhere in the
  location picker's own selected-location display) and captures a location
  point, same shape as Home/Work today.
- Each stop additionally captures/displays an enabled/disabled flag,
  independent of whether it's set (a stop is always "set" once added; the
  flag only controls whether its leg counts toward the total).
- The commute total shown in `_CommuteReadoutCard` is a sum of durations
  across only the enabled legs of the full ordered route
  (Home -> ... -> Work); how each leg's duration is computed and how they're
  summed is unchanged/out of scope for this spec (existing commute-estimate
  mechanism, extended to iterate legs instead of assuming exactly one).
- The header's "set" count is purely presence-based (location chosen or
  not), not dependent on the enable/disable flag.

## Open questions

Resolved with the user already:

- No delete confirmation — immediate removal on tap.
- "Add a stop" is available at any time, not gated on Home/Work being set.
- Tapping a stop row to re-pick its location is in scope, mirroring
  Home/Work.
- A single bottom error slot is sufficient; no per-row inline errors.

Still open, out of scope for this UI spec, flagged for tech-lead /
data-repository layer:

- **Duplicate/near-identical locations**: what happens if a stop is picked
  at the same (or a near-identical) point as Home, Work, or another stop —
  this is a validation/business-logic question, not a UI design decision,
  and is intentionally left unresolved here.
- **New component**: this design introduces the app's first `Checkbox`
  usage (no existing checkbox component/pattern was found under
  `lib/shared/`, `lib/core/`, or `lib/components/`). A standard Flutter
  `Checkbox` styled with `activeColor: context.colors.primary` is what this
  spec assumes; flutter-engineer/figma-widget-core should confirm no shared
  checkbox component needs to be introduced instead for future reuse.

Remaining work is otherwise implementation: tech-lead should treat this as
extending the existing single-leg Home/Work location model into an ordered,
variable-length waypoint list with a per-waypoint enabled flag; no other
product decision is implied beyond what's captured above.
