# Onboarding

## Overview
A 3-screen, swipeable value-prop intro shown once, on first launch only, before mandatory schedule setup. It replaces the current placeholder `OnBoardPage` stub. Each screen introduces exactly one of WorkTracker's three core features (attendance tracking, task time tracking, leave reminders) so a new user understands what the app does before being asked to configure a work schedule. It lives outside the tab shell, as its own full-screen route reached only from the app's first-run flow (before Home/Calendar/Insight/Settings tabs exist for this user).

This spec covers copy and layout only. No permission requests, no data capture, no skip affordance.

## Flow
1. App launch (first run, onboarding not yet completed) -> `OnBoardPage`
2. `OnBoardPage` shows Screen 1 (Attendance) with dots indicator at position 1/3
3. User swipes left or taps "Next" -> Screen 2 (Task time tracking), dots at 2/3
4. User swipes left or taps "Next" -> Screen 3 (Leave reminders), dots at 3/3, primary button label changes to "Get Started"
5. User taps "Get Started" -> `AppCubit.completeOnboarding()` fires -> app navigates to mandatory schedule-setup flow
6. User can swipe back (right) from screen 2 or 3 to revisit a previous screen; dots update accordingly
7. No skip exit exists — the only way out is completing the 3rd screen

## Screens

There is one screen template reused three times with different content (illustration/icon, headline, body copy). Screens are pages inside a single horizontally-scrolling `PageView` on one `OnBoardPage` route.

### Shared template — layout (top to bottom)
- Safe-area top spacing (`AppSpacing.space48`)
- Centered illustration/icon area: a large circular icon using the existing `AppIcon` component pattern (scaled up for onboarding, e.g. 96x96, background = `primaryLight`, foreground icon = `primary`), or a simple full-bleed illustration if the team later wants one — icon-in-circle is the default since it reuses an existing component shape rather than inventing new illustration style
- `AppSpacing.space32` gap
- Headline text, `AppTypography.headline`, centered, `textPrimary`
- `AppSpacing.space12` gap
- Body copy, `AppTypography.body`, centered, `textSecondary`, max 2 lines
- Flexible spacer pushes footer down
- Footer (fixed across all 3 screens):
  - New **Dots Page Indicator** component, centered, `AppSpacing.space24` above the button
  - `PrimaryButton` full-width (`expanded: true`), label "Next" on screens 1-2, "Get Started" on screen 3, wired to `PageController.nextPage()` on screens 1-2 and to `AppCubit.completeOnboarding()` on screen 3
  - Bottom safe-area padding (`AppSpacing.space24`)

No card/`ShadowCard` wrapper is needed — onboarding content sits directly on `background`, consistent with a full-screen intro rather than a card-based content screen.

### Screen 1 — Attendance tracking
- Icon: check-in style icon (e.g. clock/checkmark), background `primaryLight`
- Headline: "Track your attendance"
- Body: "Check in and out with one tap, and see your work hours at a glance."

### Screen 2 — Task time tracking
- Icon: stopwatch/timer style icon, background `primaryLight`
- Headline: "Time your tasks"
- Body: "Start a timer for any task and know exactly where your hours go."

### Screen 3 — Leave reminders
- Icon: bell/location style icon, background `primaryLight`
- Headline: "Never miss a leave time"
- Body: "Get a nudge when it's time to head out, based on your schedule."
- Primary button: "Get Started" (only difference in footer content vs. screens 1-2)

### New component — Dots Page Indicator
- Name: `DotsPageIndicator` (or similar), proposed home: `lib/components/indicators/dots_page_indicator.dart`, exported via `lib/components/components.dart`
- Purpose: shows current position in a fixed-length paged flow (here, 3 dots for onboarding); reusable anywhere else a lightweight page position indicator is needed
- Visual spec (uses only existing tokens):
  - Row of 3 small circles, `AppSpacing.space8` gap between each
  - Inactive dot: 6x6 circle, color `outline`
  - Active dot: widens to a short pill (e.g. 20x6, `AppRadius.radius4` corners) OR stays a 8x8 circle — recommend the widening pill for a clearly "alive" indicator that's still minimal; color `primary`
  - Purely presentational: takes a `pageCount` and `currentPage` (index), no internal state/animation logic specified here — implementation detail for flutter-engineer/figma-widget-core
- Why new: nothing under `lib/components/` currently addresses paged-progress; no existing token/color is skipped — it reuses `primary`, `outline`, `AppSpacing.space8`, `AppRadius.radius4` as-is.

## States
- **Loading**: none — onboarding content is static copy, no async data fetch. `OnBoardPage` renders immediately on route entry.
- **Populated**: the only real state — one of screens 1/2/3 showing per the flow above.
- **Empty**: not applicable (no user data displayed).
- **Error**: not applicable (no network/data calls on this screen). If `completeOnboarding()` could fail (e.g. local-storage write), that's a tech-lead concern for the app-level cubit, not a distinct visual state on this screen — pressing "Get Started" should feel instant.
- **First screen vs. last screen**: only variation in state is footer button label ("Next" vs "Get Started") and dots position — not separate visual states, just per-page footer content as described above.

## Interactions
- Swipe left/right anywhere on the page body: moves between screens 1-2-3 (standard `PageView` gesture), dots update to match
- Tap "Next" (screens 1-2): advances one page, same as swipe
- Tap "Get Started" (screen 3 only): triggers `AppCubit.completeOnboarding()`, which exits onboarding and hands off to the app's post-onboarding flow (mandatory schedule setup) — no confirmation dialog, single tap
- Tapping a dot: out of scope / not required — dots are indicator-only, not tappable navigation, to keep the indicator simple
- No back button, no close/X button, no skip button anywhere in this flow

## Data touchpoints
- Displays: static headline + body copy per screen (3 pairs of strings), an icon per screen, current page position (for the dots indicator)
- Captures: nothing — no user input, no toggles, no permission prompts on this screen
- Triggers on final tap: a single "onboarding completed" signal (already exists as `AppCubit.completeOnboarding()`) — no other data written by this screen

## Open questions
- Illustration style: this spec defaults to reusing `AppIcon`-style circular icon backgrounds scaled up. If the team wants custom illustrations instead (not just icons), that's a new visual asset decision beyond this spec's scope — flag to user/product before commissioning artwork.
- Exact icon choices (which Material/Cupertino icon per screen) are left to flutter-engineer/figma-widget-core to pick from the existing icon set used elsewhere in the app, as long as they clearly read as "attendance", "timer", and "reminder/bell".
- Dots indicator visual treatment (widening pill vs. simple size/opacity change for active dot) — recommended pill above, but flutter-engineer/figma-widget-core can choose the simpler size-only variant if preferred; both reuse only existing tokens.
- Whether `DotsPageIndicator` should support tap-to-navigate for future reuse elsewhere in the app (not needed for onboarding) — left for tech-lead/flutter-engineer if another feature wants it later.
- Confirm final copy wording with product/user before implementation — copy above is a first draft in a minimal tone since no existing brand-voice doc was found in the repo.
