# Day Detail & Edit (Calendar Day Summary)

## Overview

When the user taps a date in the Calendar tab's month grid, the existing day-summary card below the grid should show the fullest picture available for that day: recorded attendance if there is any, otherwise the applicable work schedule, otherwise a prompt to set one up. It should also let the user create or correct that day's check-in/check-out time directly from the card. This lives entirely inside the existing Calendar tab (`/calendar`), as an extension of the current `DaySummaryView` card — no new screen or route.

## Flow

1. User opens the Calendar tab (bottom nav) → `CalendarPage` renders the month grid with `MonthSummaryRow`, `MonthHeader`, `WeekdayRow`, `MonthGrid`, and the day-summary card below it, defaulted to today.
2. User taps a day cell in `MonthGrid` → `CalendarCubit.selectDate(date)` updates the selection (existing behavior, unchanged) → the day-summary card re-renders below the grid in one of the states described below.
3. From the card, if the state permits editing (State A or State B), the user taps a check-in/check-out (or Start/End) tile → a time picker sheet opens → on confirm, that day's check-in or check-out is created/updated → the card re-renders in place (State B may transition to State A once both check-in and check-out exist).
4. From State E ("no schedule at all"), the user taps "Set schedule" → pushes to the existing `SettingSchedulePage` → on save, returns to Calendar, card re-renders (should now show State B/C/D depending on the tapped date, or State A if the day already has attendance).
5. Exit points: back to browsing other days/months (grid interaction unchanged), or out to `SettingSchedulePage` and back (existing route).

No new screen and no new route are introduced by this design — everything happens inline in the existing Calendar tab.

## Screens

### Calendar tab — day-summary card (extension of existing `DaySummaryView`)

This is the only surface this design touches. It sits inside the existing `ShadowCard` below `MonthGrid` on `CalendarPage`, unchanged in position and container styling.

**Layout, top to bottom:**

1. **Header row** (existing, extended)
   - Date line: `"Mon, 15 Jul 2026"` — weekday + day + month + year, `subtitle` style, `w600` (unchanged).
   - `"· Today"` suffix appended to the date line, `caption` style, `textSecondary`, shown only when the selected date is today.
   - "Edited" line: a small `Icons.edit` icon (~12-14px) + `"Edited"` text, `caption`/`textSecondary`, shown directly under the date line only when the day's attendance record has `isEdited == true`. Absent in all other states.

2. **Body region** — one of the six states below, replacing the current "no attendance" text / 3-tile row.

**Reused components:** `ShadowCard`, the existing `_DetailItem`-style stat tile (label + big value), `PrimaryButton`, `showAppTimePicker`, `TimeFormat.hhMmFromDateTime`, `TimeFormat.hhMm(minuteOfDay)`, `TimeFormat.hMm(totalMinutes)`, the `primaryLight`-background `ShadowCard` banner styling already used by `SettingSchedulePage`'s purpose banner.

**No new components are introduced.** The edit affordance reuses the tap-to-open-time-picker *interaction* already proven in `TodaySummaryView._handleEditCheckOut` (tap a stat tile → `showAppTimePicker` → apply), applied to the existing tile layout in `DaySummaryView`, rather than swapping in the row-shaped `TimePickerRow` widget (which would change this card's visual family). The only additive visual detail is a small edit-pencil icon next to editable tile labels, to hint they're tappable — not a new component, just an `Icon` beside existing text.

## States

The body region renders exactly one of these, determined by: does attendance exist for the date, does a schedule exist at all, is the date's weekday in the schedule's working-days mask, and is the date in the future.

### State A — Populated (attendance exists)
Applies whenever the tapped date has an attendance record — regardless of past, today, or (edge case) future.
- 3-tile row, unchanged visual layout: **Check-in / Check-out / Worked**, values via `TimeFormat.hhMmFromDateTime` / `TimeFormat.hMm(workedMinutes)`, `"-"` when a time isn't set yet.
- Check-in and Check-out tiles are tappable (edit-pencil icon next to their labels); Worked is not tappable (it's derived).
- Header shows the "Edited" line whenever `isEdited == true` on that record.
- Future date with an attendance record (edge case that shouldn't normally occur) also falls back to this state — no special handling.

### State B — Schedule fallback, past or today (no attendance, schedule applies to this weekday)
Applies when there is no attendance record for the date, a schedule exists, and the date's weekday is in the working-days mask, and the date is today or earlier.
- Small caption above the tiles: `"Scheduled (no attendance recorded)"`, `caption`/`textSecondary`.
- 3-tile row, same visual family, relabeled **Start / End / Lunch**: `TimeFormat.hhMm(startMinuteOfDay)`, `TimeFormat.hhMm(endMinuteOfDay)`, `TimeFormat.hMm(lunchMinutes)`.
- Start and End tiles are tappable (edit-pencil icon next to labels) and, on confirm, create that day's check-in/check-out (transitioning the card to State A on next render). Lunch is not tappable.

### State C — Schedule fallback, future date (read-only)
Applies when there is no attendance record, a schedule exists, the date's weekday is in the working-days mask, and the date is after today.
- Same Start/End/Lunch tile layout as State B, caption changed to `"Scheduled"` (no "no attendance recorded" wording, since none is expected yet).
- No tap affordance on any tile, no edit-pencil icons — fully read-only.

### State D — Not a scheduled work day
Applies when there is no attendance record, a schedule exists, but the date's weekday is **not** in the working-days mask. Applies regardless of past/today/future.
- No tiles. Single line of body text, `body`/`textSecondary`: `"Not a scheduled work day."`
- No action, no CTA — purely informational.

### State E — No schedule set up at all
Applies when there is no attendance record and no schedule exists at all (independent of the date).
- `ShadowCard`-style banner reusing the `primaryLight` background treatment from `SettingSchedulePage`'s purpose banner: title `"No schedule set up"`, body copy `"Set your work hours to see your schedule and track attendance."`
- `PrimaryButton` labeled `"Set schedule"` — the one primary action for this state — navigates to `SettingSchedulePage` via the existing `AppNavigator.pushWorkScheduleSettings(context)`.

### Edit-in-progress / error feedback (applies within States A and B)
Not a separate visual state so much as transient feedback during the tap-to-edit interaction:
- Tapping an editable tile opens `showAppTimePicker` seeded with the tile's current value (or `now` if unset).
- On confirm, the tile updates in place; if the edit produces both a check-in and check-out where before there was only a schedule, the card transitions from State B to State A.
- If the edit is invalid (e.g., setting a check-out before an existing check-in, or setting a check-out in State B before any check-in exists), show inline `error`-colored text below the tiles, in the same style as the existing error-message pattern in `SettingSchedulePage` (e.g. `"Check-out time must be after check-in time"` / `"Add a check-in time first"`). The tile reverts to its prior value; no separate error screen or dialog.

## Interactions

- Tap a day cell in `MonthGrid` → selects the date (existing `CalendarCubit.selectDate`) → day-summary card body re-renders to the matching state above.
- Tap Check-in / Check-out tile (State A) → time picker → creates/updates that day's check-in or check-out.
- Tap Start / End tile (State B only) → time picker seeded with the scheduled minute → creates that day's check-in or check-out (State B → State A on success).
- Tap "Set schedule" button (State E) → pushes `SettingSchedulePage` (existing route) → on save, returns to Calendar; card re-evaluates state for the currently selected date.
- No taps are actionable in States C and D — purely informational/read-only.

## Data touchpoints

- **Displays, for the selected date:** weekday/date label, whether the date is today, whether that day's attendance was ever edited, recorded check-in time, recorded check-out time, total worked time, scheduled start time, scheduled end time, scheduled lunch duration, and whether the date's weekday is a scheduled work day.
- **Captures:** a check-in time and/or a check-out time for the selected date (as a time value on that date), entered via the same time-picker sheet already used elsewhere in the app.
- Nothing about *how* lateness/overtime/worked-minutes are computed is prescribed here — this design only describes which values are shown and where they come from (attendance record vs. schedule), leaving derivation to existing logic / tech-lead.

## Open questions

- **Repo-level gap (blocks implementation of the edit interactions):** `AttendanceRepository.checkIn(time)` / `checkOut(time)` are currently hardcoded to *today's* day-key internally (see `AttendanceRepositoryImpl._todayDayKey()`) — there is no way today to check-in/out for an arbitrary past date. This design assumes that gap is closed (the repository accepts an explicit target date), which needs a tech-lead-owned data-layer change before `flutter-engineer` can implement the tap-to-edit interactions in States A and B. Flagging this explicitly as a prerequisite, not something resolved by this spec.
- Whether the "Edited" indicator should also appear for a day that got its check-in/out set for the first time via this new flow (i.e., does creating count as "edited," or only correcting an existing value?) — current data model (`isEdited`) and repository logic already make this distinction somewhere; tech-lead should confirm which one applies to newly-created records from State B.
- Exact copy/wording for the inline error messages (e.g. "Add a check-in time first") is illustrative — final microcopy can be adjusted during implementation as long as the same states/behavior are preserved.
- Whether working-days-mask changes made later in `SettingSchedulePage` should retroactively affect how past dates are classified (State B/C vs. State D) is a schedule-history question outside this spec's scope — this design only describes reading the *current* mask, consistent with how `WorkScheduleRepository.getCurrentActiveSchedule()` already works today.
