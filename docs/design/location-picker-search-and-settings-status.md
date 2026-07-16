
# Location Picker Search + Default GPS Pin + Settings "Active" Status

## Overview
Three related UX changes to the Leave Reminder feature. (1) The location picker (used for both "Set Home" and "Set Work") gains free-text address search with autocomplete suggestions, so users can type an address instead of hunting on the map — this is the app's first free-text input component anywhere. (2) Opening the picker fresh with no location already chosen and GPS permission granted now auto-selects the device's current position as the actual pick (not just a camera recenter), immediately labeled with a reverse-geocoded address. (3) The Settings page's "Leave reminders" row gains a status subtitle showing whether the feature is fully active, partially configured, or off. Lives in: `lib/features/leave_reminder/presentation/pages/location_picker_page.dart` (items 1-2) and `lib/features/setting/presentation/pages/setting_page.dart` (item 3), reached from the Settings tab.

## Flow

**Location picker (items 1 & 2):**
1. Entry: user taps "Set Home" or "Set Work" in the leave-reminder setup sheet → `LocationPickerPage` opens.
2. If no `initial` location was passed in and GPS permission is granted: blocking "Finding your location…" scrim shows while both the GPS fix and its reverse-geocoded address resolve together → scrim dismisses with a pin already placed and labeled, Confirm already enabled.
3. If GPS fails/denied: scrim dismisses, camera silently falls back to the hardcoded default center, no pin, no label, Confirm disabled — unchanged from today.
4. User may, in any order, any number of times: type in the search field to get suggestions and tap one, tap the map directly, or tap the "center on me" FAB (recenters camera only, does not itself pick a point — unchanged).
5. Every pin placement (search selection, default GPS pin, or manual tap) triggers a reverse-geocode call and populates the selected-location card with a name/address.
6. Exit: user taps the AppBar Confirm checkmark (enabled whenever `_picked` is non-null) → pops back to the setup sheet with the chosen point; or backs out with no selection → pops null, unchanged.

**Settings status row (item 3):**
1. Entry: user opens the Settings tab.
2. "Leave reminders" row shows a status subtitle reflecting current enabled/locations state, read fresh on page load.
3. Tap → opens the existing leave-reminder setup sheet (unchanged entry point).
4. Exit: sheet closes → row re-fetches and updates its status subtitle immediately.

## Screens

### Location Picker (`location_picker_page.dart`)
Purpose: pick a single point (Home or Work) via map tap or address search, with a live labeled preview of the current pick.

Layout (Stack, paint order bottom → top):
1. `GoogleMap`, full-bleed — unchanged (traffic on, native "my location" blue dot on, native locate button off).
2. **New — search bar + suggestions/selected-location column**, top-anchored, only rendered when not in the initial-GPS-resolving phase:
   - Search field: a `ShadowCard`-style surface (`surfaceSecondary` fill, `AppShadow.small` elevation, but `AppRadius.radius12` instead of the row-default `radius8` to read as an input rather than a navigable row), positioned with `AppSpacing.space16` margin on top/left/right. Row layout: leading search icon → `Expanded` borderless `TextField` (hint "Search for an address", `AppTypography.body`/textSecondary) → trailing state area (see States).
   - Directly below (`AppSpacing.space8` gap), one of two mutually-exclusive elements occupies the same slot:
     - **Suggestions dropdown** (while the field has focus + an active query): a twin surface (same fill/radius/elevation as the search field) containing up to ~5 visible suggestion rows (internally scrollable beyond that), each row: place name (`AppTypography.body`, w600) + secondary address line (`AppTypography.caption`, textSecondary), `space16`/`space12` padding, thin `context.colors.divider` between rows, full row tappable.
     - **Selected-location card** (whenever `_picked` is set and the dropdown isn't active): small `Icons.place` (primary) + place name (`AppTypography.label`, w600, 1 line, ellipsis) + address (`AppTypography.caption`, textSecondary, 1 line, ellipsis). Non-interactive (informational only).
3. FAB "center on me", bottom-right — unchanged position/behavior, still only recenters the camera, does not move or set `_picked`. Only rendered when not in the initial-GPS-resolving phase (unchanged gate).
4. Blocking scrim "Finding your location…" — unchanged visual, but now covers both the GPS fetch and its reverse-geocode call as one combined resolving phase (see States).

AppBar: unchanged — title "Set Home"/"Set Work", trailing Confirm checkmark. Search lives entirely inside the body `Stack`, never touches the AppBar.

Reused components/tokens: `ShadowCard`'s visual language (fill color, `AppShadow.small`), `AppTypography` (label/body/caption), `AppSpacing` (space8/space16), `AppRadius.radius12`, `context.colors` (primary, textSecondary, error, surfaceSecondary). Existing `Marker` at `_picked` is unchanged (plain default pin icon, no native `InfoWindow` — the selected-location card is the label, not a map callout).

New component needed (justified — first free-text input in the app): a search-field-with-suggestions unit as described above. No new color, spacing, or radius value is introduced; `radius12` and `radius8` both already exist in `AppRadius` and are simply applied to a new context (distinguishing "input" from "row").

### Settings page (`setting_page.dart`) — "Leave reminders" row only
Purpose: let the user see at a glance, without opening the sheet, whether leave reminders are actually working.

Layout: unchanged `ShadowCard` → `InkWell` → `Padding` → single-line `Row(spaceBetween)`. Left side unchanged (`Text('Leave reminders')`). Right side changes from a bare chevron to:
```
Row(mainAxisSize: min)[ Text(status), SizedBox(width: space8), Icon(chevron_right) ]
```
"Work schedule" and "Checkout reminder" rows are untouched (out of scope this pass).

Reused components/tokens: same `ShadowCard`/`InkWell`/`Padding`/`Row` shape already in place; the primary+w600-vs-textSecondary+normal text convention from `_LocationRow`/`_LocationsHeader` in `leave_reminder_setup_sheet.dart`. No new component.

## States

### Location picker
- **Initial GPS resolving** (fresh open, no `initial`, permission granted): full-bleed scrim, spinner + "Finding your location…" (single message throughout — no two-phase copy change during the reverse-geocode sub-step). Search bar and FAB are not rendered during this phase. Resolves once both the GPS fix and its reverse-geocode attempt have completed (reverse-geocode failure does not hold up the scrim — see below).
- **GPS denied/failed**: scrim dismisses, camera falls back to the hardcoded default center, no pin, no card, Confirm disabled — unchanged from pre-existing behavior, no new error UI.
- **Search — empty**: placeholder text, leading search icon, no trailing control, nothing rendered in the slot below.
- **Search — typing (debouncing)**: text visible, trailing "×" clear button appears as soon as there's any text; leading icon stays the static search icon during the debounce window (no spinner per keystroke).
- **Search — loading suggestions** (debounce elapsed, request in flight): leading icon swaps to a small 16×16 spinner in place of the search icon. Nothing shown in the slot below yet (avoids a flashing empty dropdown).
- **Search — results shown**: dropdown card populated with suggestion rows as described in Screens.
- **Search — no results**: same dropdown container, single centered row with a muted icon + "No matching addresses."
- **Search — error** (API failure): same dropdown container, single row with a message such as "Couldn't load suggestions — check your connection." No explicit retry control — continuing to type retries naturally on the next debounce.
- **Pin selected, label resolving**: selected-location card shows a neutral "Selected location" placeholder with a small trailing spinner, for any pin (search result, default GPS pin, or manual tap) while its reverse-geocode call is in flight.
- **Pin selected, label resolved**: card shows place name + address.
- **Pin selected, reverse-geocode failed**: card silently falls back to showing raw coordinates as the title — no error banner, consistent with the app's existing silent-degrade convention for location features.
- **No pin selected** (nothing tapped/searched yet, and no default GPS pin applied): no card rendered, Confirm disabled — unchanged.

### Settings row
- **Not yet loaded** (page just opened, first read pending): row renders exactly as it does today — label + chevron, no status text. No skeleton/spinner (this is a fast local read).
- **Off**: `enabled == false`, regardless of location completeness → status text "Off", `context.colors.textSecondary`, normal weight.
- **Partially set up**: `enabled == true` but home and/or work not set → status text "{n} of 2 locations set" (e.g. "1 of 2 locations set"), `context.colors.textSecondary`, normal weight.
- **Fully active**: `enabled == true` and both home and work are set → status text "Active", `context.colors.primary`, `FontWeight.w600`.
- **Read error**: falls back to the same rendering as "not yet loaded" (no subtitle) — no error message, consistent with the app's existing quiet-degrade convention for minor non-critical status reads.

## Interactions

### Location picker
- Type in the search field → debounced query fires → dropdown updates per state above.
- Tap a suggestion row → dropdown closes, keyboard dismisses, search field text updates to the selected place's name, camera animates to the place (proposed zoom level 16 — an engineer's judgment call, not a hard requirement), `_picked` is set, reverse-geocode fires for the label card.
- Tap the map directly (with or without an active search) → dropdown closes, keyboard dismisses, **search field text clears**, `_picked` moves to the tapped point, reverse-geocode fires for the label card. This is a deliberate, consistent rule: every pin placement — search selection, default GPS pin, or manual tap — is reverse-geocoded and shown in the same selected-location card. (See Data touchpoints / Open questions for the resulting call-volume note to tech-lead.)
- Tap the "×" clear button → clears the search field text only; does not touch `_picked` or the selected-location card.
- Tap "center on me" FAB → animates camera only, does not change `_picked` or trigger a reverse-geocode — unchanged.
- Tap AppBar Confirm → enabled whenever `_picked` is non-null (as soon as the resolving scrim dismisses in the default-GPS-pin case, without requiring the label itself to have resolved) → pops the picker back to the caller with the chosen point.

### Settings row
- Tap the "Leave reminders" row → opens the existing leave-reminder setup sheet (unchanged).
- On return from the sheet → row re-fetches and its status subtitle updates immediately.

## Data touchpoints
- Search field captures free-text query input and displays place-name + secondary-address suggestion pairs.
- Selecting a suggestion captures a place's coordinate and its name/address for display.
- Every pin placement (search, default GPS, or manual tap) displays a reverse-geocoded name/address alongside the coordinate — this is a new, higher-frequency reverse-geocode touchpoint than originally scoped (previously only the two specific moments in the plan — search selection and default GPS pin — were expected to reverse-geocode; manual taps now do too, on every tap). Flagging explicitly for tech-lead: this changes the expected call volume from "up to 2 per picker session" to "up to 1 per pin placement, and a user can tap the map repeatedly" — worth accounting for with per-tap debouncing/coalescing (e.g. only reverse-geocode the settled final tap, not every intermediate one) and awareness of Places/Geocoding API cost and rate limits.
- The picker's return value needs to carry both the coordinate and the resolved (or fallback-to-coordinate) label back to the setup sheet, for persistence alongside Home/Work — exact shape left to tech-lead.
- Settings row displays a plain-language status: "Active," "{n} of 2 locations set," or "Off," derived from the enabled flag plus whether Home and Work are both set.

## Open questions
- None outstanding from this design pass — all prior open questions (manual-tap labeling, clear-on-tap, single-phase scrim copy, Settings copy, retry button, zoom level) were resolved by the user; see decisions folded into the States/Interactions sections above.
- For tech-lead: confirm the debouncing/coalescing approach for reverse-geocode calls on manual taps (flagged above) and the exact call-volume/cost tradeoff of labeling every pin vs. only search/default-GPS pins.
- For tech-lead: exact model shape for the picker's new return value (coordinate + label) and how it's persisted alongside `home`/`work`.
- For flutter-engineer: the search-field-with-suggestions component described here has no prior implementation in the codebase to reference — first free-text input pattern, build per the layout/states/tokens described above.
- Non-blocking, for a future pass: "Work schedule" and "Checkout reminder" Settings rows could get the same status-subtitle treatment for consistency — explicitly out of scope for this pass.
