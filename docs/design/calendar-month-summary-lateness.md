# Calendar Month Summary — Lateness & Overtime Stats

## Overview

The Calendar tab's top summary row (`MonthSummaryRow`) currently shows three check-in punctuality *counts* for the selected month: Late, Soon, In time. This design replaces that row's content with three different stats that better reflect what matters at a glance for the month: how much total time was lost to late arrivals, how many days that happened on, and how much overtime was worked. It lives in the exact same slot it occupies today — the card sitting above the month header/grid on the Calendar tab (`/calendar`) — with no change to its position, container, or column count.

## Flow

1. User opens the Calendar tab (bottom nav) → `CalendarPage` renders `MonthSummaryRow` at the top, above `MonthHeader`/`WeekdayRow`/`MonthGrid`, for the currently selected month.
2. User changes month (existing month navigation, unchanged) → the row's three stats recompute for the newly selected month and re-render in place.
3. No new exit point — the row itself is not tappable in this design (no change to interaction surface).

## Screens

### Calendar tab — month summary row (full replacement of existing `MonthSummaryRow` content)

This is the only surface this design touches: the same `ShadowCard`, same position (top of `CalendarPage`, above the grid), same 3-column `Row` shape. Only the three items inside change — from punctuality counts to the stats below.

**Layout, left to right (3 columns, unchanged shape):**

1. **Late time** — a dot + bold value (`TimeFormat.hMm(totalLateMinutes)`, e.g. "4h 05m") + caption label "Late time" beneath, matching the existing dot-value-label layout of `_SummaryItem`.
2. **Late days** — a dot + bold value (day count, e.g. "12") + caption label "Late days" beneath, same layout.
3. **Overtime** — a dot + bold value (`TimeFormat.hMm(totalOvertimeMinutes)`, e.g. "6h 20m") + caption label "Overtime" beneath, same layout.

**Reused components/tokens:** `ShadowCard` (unchanged margin/padding), the existing `_SummaryItem`-style layout (8px colored dot + bold `title` value + `caption`/`textSecondary` label, stacked), `AppSpacing.space16`/`space12`/`space4`, `AppTypography.title`/`caption`, `TimeFormat.hMm` (already used for the "Worked" tile in `DaySummaryView` and elsewhere), `colors.warning` and `colors.tertiary` (both already used for these exact concepts in `today_summary_view.dart`'s Home-tab summary card — "Arrived late" uses `warning`, "Overtime" uses `tertiary`).

**No new component is introduced.** This is a content substitution inside the existing `_SummaryItem`-shaped tile, reusing its current visual structure as-is.

## States

- **Populated** — the normal case: all three values computed for the selected month and rendered as described above.
- **Zero state** — a month with no late arrivals and/or no overtime at all renders the literal zero value plainly: "0h 00m" for the duration stats, "0" for the day count — no dimming, graying-out, or hiding of the stat. This matches how the current row already shows a bare "0" when a category has no days, and how `DaySummaryView`'s "Worked" tile shows a literal zero.
- **Loading / error** — inherits whatever loading/error handling `CalendarPage`/`MonthSummaryRow` already has for the month's underlying data fetch (unchanged by this design; this spec only concerns the populated content of the row once data is available).
- **Overflow-safety (constraint, not a visual state)** — the new values are meaningfully longer than the old bare counts ("4h 05m" / "12" / "6h 20m" vs. single/double-digit counts), inside a 3-column row that must not switch to wrap/multi-row. This design treats "no `RenderFlex` overflow and no clipped/truncated text at any of the three tiles, on the narrowest supported iOS phone width" as a hard constraint on this row, alongside the existing "one primary action per screen" / 8pt-grid rules. The exact mechanism to guarantee this (e.g. font auto-sizing, adjusted flex weighting between columns, minimum tap/column width, letter-spacing/padding trimming, etc.) is left to `flutter-engineer`'s judgment — this spec only states the non-negotiable outcome: text must not wrap or visibly clip in this row at any supported width.

## Interactions

- Changing the selected month (existing calendar month-navigation interaction) recomputes and re-renders all three values in place. No other interaction changes — the row remains non-tappable, exactly as it is today.

## Data touchpoints

- **Displays, for the currently selected month:** total minutes late across the month's attendance records, total number of days with a late arrival, and total overtime minutes across the month's attendance records.
- **Underlying values available per day-record** (already existing, per the tech-lead-owned `Attendance` model): `lateMinutes` (0 if the day wasn't late) and `overtimeMinutes` (0 if none) — this design only specifies that the row aggregates these across the month's records; it does not prescribe how "late" or "overtime" per day is derived, nor how the monthly totals/aggregation should be modeled or computed (that belongs to tech-lead, analogous to how `MonthSummary`/`deriveMonthSummary` is structured today).
- No new data is captured by this row — display-only, same as before.

## Open questions

- Whether the three new fields should live on a renamed/re-shaped successor to today's `MonthSummary` model (e.g. adding `totalLateMinutes`, `totalOvertimeMinutes` alongside or instead of `lateCount`/`soonCount`/`onTimeCount`), and whether the "Soon"/"In time" counts are dropped entirely from the model or just no longer surfaced in this row, is a data-modeling decision left to tech-lead.
- Whether "Late days" should count distinct calendar days (i.e., de-duplicated) versus some other unit is assumed to be "count of days with `lateMinutes > 0`," consistent with how the old "Late" count worked — tech-lead should confirm this carries over unambiguously to the new aggregation.
- No design change is proposed for what happens on tap of this row (it remains non-interactive) — if product wants this row to become tappable (e.g., to open a month-level detail view) that would be a separate, later design exercise, out of scope here.
