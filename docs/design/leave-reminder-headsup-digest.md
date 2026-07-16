# Leave Reminder — Heads-Up Notification "Morning Digest"

## Overview
The leave-reminder heads-up notification (fired ahead of the separate, more urgent "leave now" alert) currently states one fact set in a single sentence: traffic + weather headline + computed leave time. This design enriches it into a short, scannable multi-line digest — adding current temperature to the existing weather line, and forecasted weather (condition + temperature) at two other moments in the user's day: their break/lunch start time and their computed leave time. It lives entirely in the leave-reminder feature's notification composition (`scheduleTodayReminders()`); no new screen or route is introduced. The separate "leave now" notification is explicitly unchanged. (Revision note: an earlier round of this design included a conditional checkout-reminder mention as line 4 — that has been dropped entirely per user request, replaced by the leave-time weather forecast described below.)

## Flow
1. `scheduleTodayReminders()` runs (on settings change, app open, or the periodic Workmanager task) and computes today's leave time as it does today.
2. It composes the heads-up notification body as a multi-line digest (facts described below) and schedules it at the existing heads-up lead time.
3. User receives the notification pre-commute; collapsed view shows title + as many lines as the OS allows before truncating; expanding (Android big-text expand / iOS long-press) reveals the full digest.
4. Tapping the notification opens the app to its default entry point — unchanged, no deep link is introduced by this design.
5. The separate "leave now" notification continues to fire at leave time with its own unchanged single-line body — out of scope for this design.

## Notification composition

**Title** (unchanged): `🌅 Time to plan your commute`

**Body — fully populated case, one fact per line (`\n`-joined):**
```
🚦 Traffic is light — leave at 07:42 to arrive on time.
☀️ Clear skies, 24°C right now.
🍽️ ☀️ 22°C expected at break time.
🌤️ 20°C expected when you leave.
```

Line-by-line intent:
- **Line 1 — traffic + leave time (existing fact, kept as the anchor line).** Always line 1 regardless of what else is available, since OS-collapsed views may truncate everything after it. Includes the `🚦` emoji prefix on the traffic phrase (`traffic_copy.dart`) for visual/tonal consistency with the already-emoji-prefixed weather headline.
- **Line 2 — current weather + temperature.** Reflects current conditions at the moment the notification body is composed ("right now"), not a forecast. Wording: `"<weather headline>, <temp>°C right now."`
- **Line 3 — forecasted weather at break/lunch time (revised — no longer states the clock time).** Sourced from `WorkSchedule.lunchStartMinuteOfDay`, but the line now shows only weather status + temperature for that moment, not the break's actual clock time. Wording: `"🍽️ <weather emoji> <temp>°C expected at break time."` The `🍽️` prefix is kept as the sole marker that this line is about the break (since the clock time itself is no longer stated). Uses the condensed emoji+temp shorthand (no repeated full condition phrase) since the fuller condition wording already appeared on line 2.
- **Line 4 — forecasted weather at leave time (NEW — replaces the dropped checkout-reminder mention).** Wording: `"<weather emoji> <temp>°C expected when you leave."` Same condensed emoji+temp shorthand as line 3.
  - **Implementation nuance (tech-lead-confirmed, not a copy change):** when the lookup time for line 3 or line 4 falls very close to "now" (same hourly bucket, or within roughly 45 minutes), the underlying value should reuse the current-conditions reading rather than a separately indexed forecast bucket — this avoids two adjacent lines showing inconsistent readings for two nearly-identical clock times. This is purely about which value is picked internally; the user-facing wording stays the same ("expected"-style phrasing) either way. Noting this for flutter-engineer's implementation, not something that changes what's specified above.

**"Leave now" notification** (`kLeaveNowNotificationId`): unchanged. Stays a single terse line (`'Your commute is about $commuteMinutes min — leave now.'`), title `🚗 Time to leave`. Not enriched by this design.

## States
- **Fully populated:** all 4 lines shown, as above.
- **Weather/forecast fetch failed:** lines 2, 3, and 4 are omitted **together**, not independently. Per tech-lead's feasibility work, current conditions and the hourly forecast are now fetched via a single combined Open-Meteo call (`current_weather` + hourly forecast in one request, with a `timezone=auto` fix for correct local-hour alignment) — so one failure takes out all three weather-derived lines as a unit, since they share one data source. *(Trade-off worth naming explicitly: this means a weather-only outage also removes the plain break-time fact on line 3, since it's now presented merged with its forecast rather than as a standalone fact. Flagging this rather than silently absorbing it — happy to add a break-time-only fallback if a bare schedule fact should survive a weather outage, but implementing the simplification as instructed for now.)*
- **Break/lunch start time not configured on the active schedule:** line 3 omitted entirely, independent of whether weather succeeded — there's no target clock time to look up a forecast for, so the whole line disappears (same graceful-omission principle as before, just now covering the combined fact).
- **Traffic estimate degraded** (live commute-routing fetch failed, falling back to a previously cached commute-minutes value with no live estimate object to describe): line 1 loses its traffic descriptor since there is no live estimate to characterize as light/moderate/heavy. Falls back to leave-time only: `"🚗 Leave at 07:42 to arrive on time."`
- **No commute estimate at all** (no live estimate and no cached value): unchanged existing behavior — nothing is scheduled/posted. Not affected by this design.
- **Minimal case** (weather/forecast failed + no break configured): digest degrades to just line 1 — equivalent in spirit to today's single-sentence notification, so nothing looks broken when enrichment data isn't available.

## Interactions
- No new tap/navigation behavior. Tapping the notification opens the app to its default entry point, matching current behavior (no deep link exists today for either leave-reminder notification ID, and none is introduced here).
- No user input is captured by this notification; it is read-only content.

## Data touchpoints
- Displays: traffic condition headline, computed leave time, current weather condition + temperature, break/lunch start time, and forecasted weather condition + temperature at two additional future timestamps (break/lunch start time, and computed leave time).
- Captures: nothing new — no new user input introduced by this design.
- No cross-feature data read is required by this design (the earlier checkout-reminder-conditional line, which needed a leave_reminder → checkout_reminder enabled-flag read, has been dropped entirely — confirmed by user, and tech-lead confirmed nothing else in this design needs that dependency).

## Open questions
- **Forecast window coverage:** if a user's break or leave time falls outside whatever hourly forecast window `WeatherClient` ends up requesting (e.g., an unusually late shift), should that specific line just gracefully omit (consistent with the other omission rules above), or should the fetch always request enough forecast hours to cover any plausible schedule? Flagging for tech-lead's `WeatherClient` extension work — my assumption for this spec is graceful omission, matching every other missing-fact case above.
- **Traffic emoji styling depth:** confirmed to add a single `🚦` prefix for all traffic severities (light/moderate/heavy use the same emoji, differentiated only by the existing text). If a future iteration wants severity-differentiated emoji (e.g., 🟢/🟡/🔴), that's an explicit follow-up, not implied by this spec.

---

**For downstream readers:**
- **tech-lead:** the item needing architecture/implementation work is extending `WeatherClient` to make a single combined current-conditions + hourly-forecast call (with the `timezone=auto` fix), and exposing lookups for arbitrary future clock times (break time, leave time) — including the near-now reuse-current-reading nuance noted under line 4 above, and the forecast-window-coverage open question above. The previously-flagged leave_reminder → checkout_reminder cross-feature dependency is no longer needed anywhere in this design and can be disregarded.
- **flutter-engineer:** exact line-by-line copy, per-fact omission rules, and the near-now value-reuse implementation nuance are specified above; no new widgets/screens are involved, this is notification body composition only.
- **qa-engineer:** the States section above is the test matrix — verify each omission case (combined weather/forecast failure removing lines 2-4 together, no break configured omitting line 3 alone, degraded traffic estimate, and the fully-minimal fallback) renders without placeholder/blank-line artifacts, and confirm the "leave now" notification is unaffected. Also worth spot-checking a case where break or leave time is very close to "now" to confirm lines 2/3/4 don't show visibly contradictory readings for near-identical clock times.
