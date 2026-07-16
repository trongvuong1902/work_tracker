# Leave Reminder Setup Sheet — Redesign

## Overview

The Leave Reminder setup bottom sheet currently exposes two independent
duration pickers ("Arrive early by", "Notify before leaving") plus a separate
read-only card that shows the two derived clock times those pickers imply
("Expected arrival", "Leave reminder alert"). This redesign collapses that
into two duration pickers that each show their own derived clock time inline,
removing the separate readout card and the debug-only heads-up-time preview
it made necessary. The sheet's purpose, entry points (post-check-in discovery
prompt, or manual access from Settings), and every other region (enable
toggle, home/work location, commute readout, debug pending-notifications
list, error text) are unchanged.

This lives entirely inside the existing `showLeaveReminderSetupSheet` modal
bottom sheet — no new screen, route, or tab.

## Flow

Unchanged from today:

1. Entry: post-check-in discovery prompt (`trigger` set) or Settings ->
   "Leave reminders" (`trigger` null) -> opens the modal bottom sheet.
2. User enables reminders, sets Home/Work locations, reviews commute
   estimate, adjusts "Expected arrival" and "Prepare duration".
3. Exit: user dismisses the sheet (drag handle / tap outside); all changes
   are saved immediately as they're made (no separate "Save" action — matches
   current behavior, this redesign doesn't add one).

## Screens

Single screen: **Leave Reminder Setup Sheet**. Region by region, top to
bottom (only regions 5–7 change; everything else reused as-is):

1. **Trigger banner** (contextual message) or **"Leave reminders" title** —
   unchanged.
2. **Enable switch card** (`ShadowCard` + label + `Switch`) — unchanged.
3. **Set Home / Set Work rows** (`_LocationRow`, shown when enabled) —
   unchanged.
4. **Commute readout card** (`_CommuteReadoutCard`, shown when both locations
   set) — unchanged. It has no new interaction with the rows below; it
   remains a passive input whose `lastCommuteMinutes` value feeds the derived
   clock time shown in the "Prepare duration" row (see Data touchpoints).
5. **"Expected arrival" row** (renamed from "Arrive early by") — reuses
   `MinutePickerRow` unchanged in every respect except the label string: same
   binding to the schedule's reminder-buffer minutes and the same option
   list, same disabled/placeholder behavior when no schedule is set, same
   composite value display of `"$minutes min · $time"` (falling back to
   `"$minutes min"` when the clock time isn't computable).
6. **"Prepare duration" row** (new — replaces "Notify before leaving") —
   reuses `MinutePickerRow`, same underlying duration control and option list
   as the old "Notify before leaving" row (no change to what value it
   captures or how it's saved). Only the label and the displayed value
   change: instead of plain `"$minutes min"`, it composites with a computed
   clock time — the same heads-up time the debug-only preview used to show —
   displayed as `"$minutes min · $time"`, falling back to plain
   `"$minutes min"` when that time isn't computable yet. No caption/helper
   text; styled identically to "Expected arrival" (label + composite value
   only, nothing extra).
7. **Removed**: the read-only card that used to sit below the two pickers
   (the one showing "Expected arrival" and "Leave reminder alert" as
   separate readout rows). Fully deleted, not replaced.
8. **Debug-only cards** (kDebugMode only) — the pending-scheduled-notifications
   debug card is unchanged. The debug notification-times preview card is
   trimmed: it drops its "Heads-up fires at" row (now redundant with the
   production "Prepare duration" row's composite value) but keeps its
   "Leave-now fires at" row — this becomes the only place in the app, debug
   builds only, where the actual "time you must leave" clock time is still
   visible.
9. **Error message** — unchanged.

No new visual component, color, spacing value, or interaction pattern is
introduced. Everything reuses `MinutePickerRow`, `ShadowCard`, and existing
typography/spacing tokens exactly as they're used elsewhere in this sheet
today.

## States

- **Loading**: unchanged — centered spinner in place of the form.
- **Reminders disabled**: unchanged — only the enable toggle card is shown.
- **No work schedule set**: "Expected arrival" row disabled, with its
  existing placeholder ("Set a work schedule first"); "Prepare duration" row
  stays enabled/editable and shows plain `"$minutes min"` (its clock time
  can't be computed without a schedule).
- **Schedule set, no commute estimate yet**: "Expected arrival" shows its
  full `"$minutes min · time"`; "Prepare duration" still falls back to plain
  `"$minutes min"` (its clock time additionally needs a commute estimate).
- **Fully populated** (schedule + commute estimate both available): both
  rows show their full composite `"$minutes min · time"` values.
- **Error**: unchanged — error text at the bottom (e.g. notification
  permission denied).
- **Debug builds**: pending-notifications card unchanged; notification-times
  preview card shows only "Leave-now fires at" (or its existing
  "not available yet" message when times aren't computable), no longer
  showing "Heads-up fires at".

## Interactions

- Tapping "Expected arrival" opens the existing wheel picker for the
  reminder-buffer minutes — unchanged behavior, only the row's label changed.
- Tapping "Prepare duration" opens the existing wheel picker for the
  heads-up-lead minutes (same options as the old "Notify before leaving")
  — unchanged behavior, only the row's label and displayed value changed.
- No new taps, gestures, or navigation are introduced. No "Save" action is
  added; both rows save immediately on selection, as today.

## Data touchpoints

- "Expected arrival" row captures a duration (how early before the work
  schedule's start time the user wants to be considered arrived) and
  displays the resulting clock time.
- "Prepare duration" row captures a duration (how long before the "time to
  leave" moment the user wants an earlier heads-up notification) and
  displays the clock time that earlier notification will fire at.
- The commute estimate (shown in the unchanged commute readout card) is a
  required input for the "Prepare duration" row's displayed clock time to
  become available, alongside the work schedule.
- No longer displayed anywhere in production UI: the "time you must leave
  home" clock time. It remains visible in debug builds only, in the trimmed
  notification-times preview card.

## Open questions

None outstanding — all design questions were resolved with the user:

- "Leave by" time: intentionally dropped from production UI (debug-only from
  now on).
- New row label: "Prepare duration" (final).
- No helper/caption text on the new row.
- New row is always editable (never disabled), matching current "Notify
  before leaving" behavior.
- Row order unchanged (Expected arrival, then Prepare duration).
- Debug notification-times card trimmed to keep only "Leave-now fires at".

Remaining work is entirely implementation: tech-lead/flutter-engineer should
treat this as a presentation-only change — no new state fields are implied
beyond what already exists (`reminderMinutes`/`kReminderBufferOptions`,
`headsUpLeadMinutes`/`kHeadsUpLeadOptions`, and the existing
`expectedArriveMinuteOfDay`/`alertMinuteOfDay` derived getters, which already
contain the math needed for the "Prepare duration" row's clock time via
`alertMinuteOfDay - headsUpLeadMinutes`). No repository, DI, or data-model
changes are needed for this redesign.
