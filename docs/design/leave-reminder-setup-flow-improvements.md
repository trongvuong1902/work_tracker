# Leave Reminder Setup Flow — Three Improvements

## Overview

Three independent, presentation-layer improvements to the leave-reminder
feature: (1) the setup sheet doesn't make the "both Home and Work locations
are required" requirement obvious upfront, (2) the commute readout only ever
shows a single noisy "latest" reading with no sense of a typical/average
commute, and (3) the location picker starts at a hardcoded fallback
coordinate and has no native position indicator, which is disorienting for a
first-time user picking Home/Work from wherever they actually are. All three
live inside the existing Leave Reminder feature — items 1 and 2 in the setup
bottom sheet (`showLeaveReminderSetupSheet`, reached from the post-check-in
discovery prompt or Settings -> "Leave reminders"), item 3 in the map picker
pushed from that sheet's "Set Home"/"Set Work" rows
(`AppNavigator.pushLocationPicker` -> `LocationPickerPage`).

No new screens, routes, or tabs. No new colors, spacing values, or visual
components — everything below reuses `ShadowCard`, `AppTypography`,
`AppSpacing`, `AppColors`, and the sheet's own existing full-screen loading
pattern.

## Flow

Unchanged entry/exit points from the feature's existing flow:

1. Entry: post-check-in discovery prompt (`trigger` set) or Settings ->
   "Leave reminders" (`trigger` null) -> opens the modal bottom sheet.
2. User enables reminders (toggle always tappable, independent of location
   state), sets Home and Work locations via the map picker, reviews the
   commute readout, adjusts "Expected arrival"/"Prepare duration".
3. From "Set Home"/"Set Work", the map picker opens; user taps to drop a pin,
   taps the confirm checkmark, and is returned to the sheet.
4. Exit: user dismisses the sheet (drag handle / tap outside); all changes
   save immediately as they're made, as today.

## Screens

### 1. Leave Reminder Setup Sheet (Items 1 and 2)

Region by region, top to bottom (only regions 3 and 5 change; everything
else — trigger banner/title, enable switch card, "Expected arrival"/"Prepare
duration" rows, debug cards, error text — reused exactly as today):

1. **Trigger banner** or **"Leave reminders" title** — unchanged.
2. **Enable switch card** (`ShadowCard` + label + `Switch`) — unchanged,
   always interactive regardless of location state (standing decision, not
   revisited here).
3. **NEW: "Locations" requirement header**, sitting between the enable
   switch card and the two location rows, always visible (not gated by
   `enabled`):
   - A row: left-aligned label `"Locations"` (`AppTypography.label`), right-
     aligned counter `"{n} of 2 set"` where `n` = number of `home`/`work`
     currently set. Styled exactly like the existing per-row `"✓ set"` text:
     `context.colors.textSecondary` while `n < 2`, `context.colors.primary`
     + `FontWeight.w600` once `n == 2`.
   - A caption line directly below (`AppTypography.caption`,
     `textSecondary`), shown **only while `n < 2`**: *"Both are needed to
     estimate your commute time and know when to remind you to leave."*
     Disappears once both are set — no need to keep explaining something
     already satisfied.
   - Plain text block, not wrapped in its own `ShadowCard` (matches this
     sheet's own convention of a bare title at the top, rather than
     `setting_page.dart`'s grouped-card sections elsewhere in the app —
     nesting a card inside a card isn't used anywhere in this codebase).
4. **Set Home / Set Work rows** (`_LocationRow`) — **now always visible**,
   regardless of `state.enabled`. This removes the current
   `if (state.enabled) ...` gate. Rationale: every other field in this sheet
   (the reminder-time pickers below) is already unconditionally visible
   regardless of the toggle; hiding only the location rows was the
   inconsistency causing the "I flipped the switch and nothing happened"
   confusion. No visual dimming/graying is applied when disabled — matches
   how the reminder-time pickers already behave regardless of toggle state.
5. **Commute readout card** (`_CommuteReadoutCard`, shown when both
   locations set) — **content changes**, see below; visibility rule
   (`state.hasBothLocations`) unchanged.
6. **"Expected arrival" / "Prepare duration" rows** — unchanged.
7. **Debug-only cards** (`kDebugMode`) — unchanged.
8. **Error message** — unchanged.

#### `_CommuteReadoutCard` (Item 2)

Becomes two lines instead of one:

- **Line 1** (`AppTypography.body`): the primary readout.
- **Line 2** (`AppTypography.caption`, `textSecondary`): timestamp/status.

Refresh button (icon, spinner-while-refreshing, tooltip) — unchanged
position and behavior.

### 2. Location Picker Page (Item 4a)

- **Native position indicator**: `myLocationEnabled: true` on the
  `GoogleMap`. `myLocationButtonEnabled` stays `false` — the app keeps its
  own custom-styled "center on me" FAB rather than Google's default round
  button, to match the app's visual language.
- **Custom "center on me" FAB: kept, not redundant.** The native blue dot is
  passive (shows where the device physically is); the FAB is the action that
  recenters the camera there on demand, e.g. after the user pans away. They
  serve different jobs. No behavior change to the FAB itself — still just
  recenters the camera, still never moves/sets the picked marker.
- **First-open behavior, `widget.initial == null`** (no location set yet —
  first time picking Home or Work): the page actively requests the current
  GPS position up front and centers the camera there, instead of starting at
  the hardcoded fallback and only opportunistically recentering later.
  - The `GoogleMap` still mounts immediately (camera defaulted to the
    existing hardcoded fallback under the hood) so map tiles begin loading
    in parallel — no extra cold-start delay once the overlay clears.
  - A **blocking loading overlay** covers the map while the GPS fetch is in
    flight: a scrim (`context.colors.surface` at ~85% opacity) with a
    centered `CircularProgressIndicator()` and caption "Finding your
    location…" below it. This mirrors the sheet's own existing
    `state.isLoading` pattern (full blocking spinner before content is
    usable) — not a new visual pattern, reused in a new place.
  - The custom "center on me" FAB is **hidden** while this overlay is up
    (avoids showing two competing loading affordances, and avoids a
    redundant duplicate request).
  - On success: overlay dismisses, camera animates to the resolved position,
    FAB reappears. No pin is auto-dropped — the user still has to tap, same
    as today.
  - On failure/denied: overlay dismisses, camera stays at the existing
    hardcoded fallback coordinate, FAB reappears. **Silent — no message,
    matching today's behavior exactly.** Explicitly out of scope: the
    existing v1.1 backlog item ("location permission denial has no
    user-facing rationale") remains separate, deferred future work, not
    folded into this pass.
- **First-open behavior, `widget.initial != null`** (editing an already-set
  Home/Work): **unchanged** — camera centers on the saved point immediately,
  no GPS request, no overlay. The native blue dot (if permission is granted)
  still shows wherever the device actually is, independent of camera
  center — a passive bonus reference while re-picking.

## States

### Setup sheet — "Locations" section (Item 1)

- **0 of 2 set**: header shows "Locations — 0 of 2 set" (textSecondary),
  caption visible, both rows show "Not set".
- **1 of 2 set**: header shows "Locations — 1 of 2 set" (textSecondary),
  caption still visible, one row "✓ set" / one "Not set".
- **2 of 2 set**: header shows "Locations — 2 of 2 set" (primary,
  semibold), caption hidden, both rows "✓ set".
- These are independent of `state.enabled` — identical appearance whether
  the toggle is on or off.

### `_CommuteReadoutCard` (Item 2)

- **No samples yet** (`minutes == null`): unchanged — single line, "No
  commute estimate yet", no Line 2.
- **Exactly one sample** (average would equal latest): Line 1 = "{latest}
  min drive" (no "avg" mentioned — showing an average identical to the
  latest reading would read as a copy bug). Line 2 = "Average appears after
  a few more refreshes · updated {HH:mm}".
- **2+ samples** (a real average exists): Line 1 = "{latest} min drive ·
  avg {avg} min" — plain numbers only, no day-window or trip-count
  qualifier (e.g. not "avg 25 min over 14 days" or "avg 25 min, 6 trips" —
  per explicit product simplification, just the number). Line 2 = "updated
  {HH:mm}".
- **Refreshing** (`isRefreshingCommute == true`): unchanged — spinner
  replaces the refresh icon; text content stays whatever it was before the
  tap until the new value arrives.

### Location picker (Item 4a)

- **No previous location, GPS resolving**: map visible underneath a
  blocking scrim + spinner + "Finding your location…"; FAB hidden; Confirm
  button disabled (no pin picked yet, unchanged from today).
- **No previous location, GPS resolved**: camera centered on device
  position; FAB visible; native blue dot visible (if permission granted).
- **No previous location, GPS failed/denied**: camera at the existing
  hardcoded fallback; FAB visible; no message shown (silent, matches today).
- **Editing existing location**: camera centered on the saved point
  immediately; no overlay; FAB visible from the start; native blue dot
  visible wherever the device actually is (if permission granted),
  independent of camera center.
- **Pin picked** (either flow): marker shown at tapped point; Confirm button
  enabled — unchanged from today.

## Interactions

- Tapping the enable `Switch` — unchanged, always works regardless of
  location state.
- Tapping "Set Home"/"Set Work" rows — unchanged, opens the location picker
  with `initial` set to the existing point if one is already set. Now
  reachable regardless of the enable toggle's state (rows are no longer
  hidden when disabled).
- Tapping the commute refresh icon — unchanged trigger
  (`cubit.refreshCommute()`), but now implicitly contributes a new sample
  toward the average (see Data touchpoints/assumption below) in addition to
  updating the "latest" reading.
- Tapping the map to drop/move a pin, tapping the confirm checkmark, tapping
  the "center on me" FAB — all unchanged from today.
- No new taps, gestures, dialogs, or navigation are introduced anywhere in
  this pass.

## Data touchpoints

- The "Locations" header displays a count of how many of Home/Work are
  currently set (0, 1, or 2) — purely derived from whether each is null,
  no new data captured.
- The commute readout card displays two independently-sourced numbers: the
  most recent commute-duration reading ("latest"), and a computed average
  over some bounded recent history ("avg") — tech-lead owns how that
  average is computed/bounded/reset; this design only specifies how the two
  numbers are displayed together and in what states.
- **Assumption stated explicitly (product didn't decide this, I'm making the
  call and flagging it): tapping the manual refresh button counts as a new
  sample toward the average**, not just a refresh of "latest" — this falls
  out of the existing call path (`refreshCommute()` already calls
  `_repository.scheduleTodayReminders()`, which per tech-lead's plan is
  where samples get written on every successful live fetch), so no
  special-casing is proposed to exclude manual refreshes from the average.
- The location picker captures a single lat/lng point per pick (Home or
  Work, depending on which row opened it) — unchanged data shape, just a
  different starting camera position and a new native map layer, no new
  captured data.

## Open questions

All open questions from the previous round were resolved by the user. One
remains, explicitly flagged for tech-lead (not a UI decision):

- **Sample de-duplication**: if a user taps the commute refresh button
  several times in quick succession (e.g. within the same minute), should
  those near-duplicate samples all count toward the average, or should
  tech-lead's data model de-dupe/cooldown samples that are too close
  together in time? This is an averaging/data-modeling decision, not a
  presentation one — this spec only establishes that manual refresh *does*
  contribute to the average in principle; whether it's rate-limited is
  tech-lead's call.

Everything else is settled:

- Item 1: text counter ("{n} of 2 set"), not a visual progress bar.
- Item 2: plain "avg {avg} min" once 2+ samples exist, no day-window or
  trip-count qualifier language.
- Item 4a: silent fallback on GPS failure/denial (existing v1.1 backlog item
  stays separate, deferred future work).
- Item 4a: blocking loading overlay ("Finding your location…") during the
  initial GPS fetch, not a non-blocking/interact-immediately approach.

## For downstream readers

- **tech-lead**: no architecture work is implied by Items 1 or 4a (both are
  presentation/cubit-level only). Item 2 needs the commute-sample history
  data model (new ObjectBox entity, bounded window, reset-on-location-change
  — as already scoped in `PROJECT_CONTEXT.md`'s backlog) and must expose at
  minimum a `latest` and an `average` value to the cubit/state; per this
  spec, the UI does **not** need a sample count or window-completeness flag
  surfaced — the average is shown as a plain number with no qualifying
  copy. Please weigh in on the sample de-duplication open question above.
- **flutter-engineer**: Item 1 is a straightforward sheet edit (remove the
  `if (state.enabled)` gate around the location rows, add the new header
  block, no new state fields needed — `state.home`/`state.work` nullness is
  already available). Item 4a is scoped to `location_picker_page.dart` only
  (native indicator flag, restructured first-open flow with the blocking
  overlay, FAB visibility toggle) — no new dependency. Item 2's UI changes
  in `_CommuteReadoutCard` depend on tech-lead's new average field landing
  in `LeaveReminderSetupState` first.
- **qa-engineer**: verify the "Locations" header updates live as each
  location is set/cleared and is visible with the toggle both on and off;
  verify the commute card's three copy states (no samples / one sample / 2+
  samples) render distinctly and never show a redundant duplicate number;
  verify the location picker shows the blocking overlay only on first pick
  (never when re-editing an existing Home/Work), degrades silently on
  simulator/permission-denied without crashing, and that the FAB
  hides/reappears correctly around the overlay.
