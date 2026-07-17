# Task tracking + Zentao import

## Overview
Introduces the app's first Task feature: a "Tasks" tab (replacing the placeholder "Insight"
tab) where users track time-boxed work items, created manually or imported from Zentao.
Imported tasks remain linked to their source Zentao ticket and can be manually refreshed to
reflect the ticket's current status. Lives at the 3rd bottom-nav slot (was Statistics/Insight).

## Flow
1. Bottom nav "Tasks" → Task List
2. Task List (empty) → "Create task" / "Import from platform" primary actions.
   Task List (populated) → "+" action → Add Task sheet → **Create manually** | **Import from platform**
3. **Create manually** → Manual Task Form → Save → back to Task List (new task, Open status)
4. **Import from platform** → Platform Picker (Zentao enabled; other platforms shown
   disabled/"Coming soon") → Zentao chosen:
   - Not connected → Connect Zentao form (instance URL + API token) → Connect → on success,
     proceeds straight to Ticket List
   - Already connected → straight to Ticket List
   → Ticket List (live fetch from Zentao) → tap a ticket → imports immediately, snackbar
     "Imported '<title>'" → back to Task List (new linked task appears, Open status)
5. Task List → tap any task row → Task Detail
   - Manual task: title/description (editable), Open/Done toggle, timer start/stop
   - Linked (Zentao) task: same, plus "Imported from Zentao — Ticket #<id>", "Last synced
     <time>", "Refresh" action, "Open in Zentao" external link
6. Settings → new "Zentao account" row (status text: "Not connected" / "Connected — <instance
   host>", mirrors the existing Leave Reminder/Checkout Reminder row pattern) → tap → Manage
   Zentao Connection sheet (shows connected instance URL, "Disconnect" action; shows the same
   Connect form inline if not yet connected)

## Screens

### Task List
Replaces `InsightPage` (`lib/features/insight/presentation/pages/insight_page.dart`), becomes
the 3rd tab in `lib/app/router/app_shell.dart` — icon/label changed from bar_chart/"Statistics"
to a checklist-style icon/"Tasks".
- Empty state: icon + message + two actions ("Create task", "Import from platform"), replacing
  `ComingSoonView` for this tab.
- Populated: `ShadowCard` rows — title, Open/Done indicator, source badge (small "Zentao" chip
  vs none for manual), linked tasks show a small "synced Xm ago" caption.
- "+" action opens the Add Task sheet.

### Add Task sheet
Modal bottom sheet, 2 options: "Create manually" / "Import from platform".

### Manual Task Form
Full screen or sheet: title field, description field, Save action. This is the app's first
free-text input UI — no existing shared text-field component to reuse (closest precedent,
`_SearchBar` in `location_picker_page.dart`, is currently local/unshared — worth promoting to
`lib/components/` here).

### Platform Picker
Rows for each platform (Zentao enabled; future platforms shown greyed/disabled with "Coming
soon" trailing text) — reuses/generalizes the ad-hoc picker-row pattern from
`location_picker_page.dart`'s `_SuggestionsDropdown`.

### Connect Zentao form
Instance URL field, API token field, "Connect" action, inline error text on failure (mirrors
`leave_reminder_setup_sheet.dart`'s inline-error pattern).

### Zentao Ticket List
Fetched tickets as `ShadowCard` rows (ticket ID, title, Zentao's own status field), loading
spinner, error state with retry, empty state ("No tickets found on this Zentao instance").

### Task Detail
Title, description, Open/Done toggle, timer controls (Start/Stop + elapsed time), and for
linked tasks an "Imported from Zentao" section (ticket id/link, last-synced timestamp,
"Refresh" button, "Open in Zentao" action).

### Settings → Zentao account row
Same visual shape as the existing Leave Reminder/Checkout Reminder rows in
`lib/features/setting/presentation/pages/setting_page.dart`.

### Manage Zentao Connection sheet
Connected instance URL + "Disconnect" action, or the Connect form inline if not connected.

## States
- Task List: loading / empty / populated / error
- Connect Zentao form: idle / connecting / error (invalid URL, auth failed) / success
- Zentao Ticket List: loading / populated / empty / error (fetch failed) with retry
- Task Detail (linked): synced (shows last-synced time) / refreshing / refresh failed (inline
  error, keeps last known data)
- Timer: stopped ("Start") / running (elapsed time + "Stop")

## Interactions
- Tab tap → Task List
- Empty-state buttons / "+" → Add Task sheet → option tap → Manual Task Form or Platform Picker
- Platform Picker → tap Zentao → Connect form (if unconnected) or Ticket List (if connected);
  disabled future-platform rows are no-ops
- Connect form → "Connect" → success auto-navigates to Ticket List; failure shows inline error,
  stays on form
- Ticket List → tap ticket → immediate import + snackbar → pop back to Task List
- Task List → tap task row → Task Detail
- Task Detail → toggle Open/Done updates in place; Start/Stop timer toggles running state with
  live elapsed time; Refresh (linked only) re-fetches ticket status and updates "last synced";
  "Open in Zentao" opens the ticket URL externally
- Settings → "Zentao account" row → Manage Zentao Connection sheet; "Disconnect" clears the
  connection (with confirmation), row reverts to "Not connected"

## Data touchpoints
- Task shows: title, Open/Done status, source (manual vs Zentao), linked tasks additionally
  show the source ticket identifier and last-synced time
- Manual Task Form captures: title, description
- Connect Zentao form captures: Zentao instance base URL, API token — first credential-entry UI
  in the app; no secure-storage precedent exists yet (only unencrypted `SharedPreferences`)
- Zentao Ticket List row shows: ticket ID, title, Zentao's own status field
- Task Detail additionally shows/captures: elapsed tracked time (timer), and for linked tasks
  the ticket's status as of last refresh + a link back to the ticket in Zentao

## Open questions
- Exact Zentao API shape (auth endpoint, ticket-list endpoint, available fields) is unconfirmed
  against real Zentao API docs — this design assumes ID/title/status/description are available.
- Secure storage for the API token needs a real decision (e.g. `flutter_secure_storage`) — no
  existing pattern in the app.
- Whether "Refresh" re-fetches just that one ticket or the whole ticket list in the background
  is a behavior choice for tech-lead, not a UI question.
- Task fields beyond title/description (priority, due date, project/category) are intentionally
  minimal for v1; can expand later.
- Whether the Zentao Ticket List should support filtering/switching between projects/boards, or
  show all accessible tickets flatly — left open, default to a flat list for v1 unless told
  otherwise.
