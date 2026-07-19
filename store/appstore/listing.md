# WorkTracker — App Store listing

Paste into **App Store Connect → your app → (version) → App Store tab**.
Character limits are Apple's; counts below are current.

---

## App Name (max 30)
```
WorkTracker
```
<sub>11 / 30</sub>

## Subtitle (max 30)
```
Attendance & task time tracker
```
<sub>30 / 30</sub>

## Promotional Text (max 170) — editable anytime without review
```
Clock in with one tap, time your tasks, and get a smart nudge when it's time to leave — all private and on-device. No account required.
```
<sub>133 / 170</sub>

## Keywords (max 100, comma-separated)
```
attendance,time tracking,timesheet,work hours,task timer,clock in,clock out,commute,leave reminder
```
<sub>98 / 100</sub>

## Description (max 4000)
```
WorkTracker is your personal work companion — a private, single-user app that tracks your attendance, times your tasks, and reminds you when it's time to head home. No account, no sign-up, no cloud: everything you enter stays on your device.

CHECK IN, CHECK OUT
Tap once to clock in and once to clock out. The home screen shows your work-hours progress at a glance, plus your expected leave time (adjusted for a late start and minus lunch), total hours worked, overtime, and when you arrived and left.

YOUR SCHEDULE, YOUR RULES
Set your start and end times, working days, and lunch break once. WorkTracker uses it to power every calculation — lateness, overtime, and reminders.

CALENDAR
Browse a month view with a per-day summary of attendance and lateness, and open any day to review or edit past check-in and check-out records.

SMART LEAVE REMINDERS
Pin your Home and Work locations on an in-app map (with address search). WorkTracker estimates your commute using live traffic and checks the weather at your workplace, then sends an on-device "heads-up" and a "leave now" nudge timed to your schedule — so you're never caught leaving too late.

CHECKOUT REMINDER
Get an end-of-day reminder to clock out, automatically shifted later if you started late, with a lead time you control.

TASK TIME TRACKING
Create tasks and start a per-task timer to see exactly where your hours go. A "Manage task times" screen lets you review and edit per-day time logs.

ZENTAO INTEGRATION (OPTIONAL)
Connect to your own Zentao instance to import assigned tasks and bugs as trackable items — complete with priority, severity, comments, and attachments. Your credentials are stored encrypted on your device and sent only to your Zentao server.

AI BUG-FIX ASSISTANT (OPTIONAL)
For a task linked to a Zentao bug, generate a framework-aware fix prompt tailored to your coding AI of choice. Available only when configured with your own API key.

PRIVATE BY DESIGN
WorkTracker has no account and no backend. Your attendance, schedule, tasks, and settings live only in an on-device database. Location coordinates are sent to mapping and weather services solely to power the leave-reminder features you opt into — never for advertising or tracking. See our privacy policy for full details.

Take control of your workday — download WorkTracker today.
```
<sub>Recount with `wc -m` before pasting; keep under 4000.</sub>

---

## URLs & categorization
- **Support URL:** https://trongvuong1902.github.io/work_tracker/support.html
- **Marketing URL (optional):** (leave blank or reuse support URL)
- **Privacy Policy URL:** https://trongvuong1902.github.io/work_tracker/privacy_policy.html
- **Primary category:** Productivity
- **Secondary category (optional):** Business
- **Age rating:** 4+ (no objectionable content — answer "None" to all questionnaire items)
- **Copyright:** 2026 Trong Vuong

## Build / encryption
- App icon: read automatically from the build (Icon-App-1024x1024 in the asset catalog) — no separate upload.
- Encryption: the `release` lane already declares `export_compliance_uses_encryption: false`, matching `ITSAppUsesNonExemptEncryption=false` in Info.plist. No extra compliance docs needed.

---

## App Privacy answers (App Store Connect → App Privacy)

Apple treats data as "collected" only if it leaves the device. Everything you enter
(attendance, tasks, schedule) is stored **on-device only** and is NOT collected.
Declare exactly these two types:

### 1. Location — Precise Location
- **Collected:** Yes (coordinates are sent to Google Maps/Distance Matrix/Geocoding and the Open-Meteo weather service when you use Leave Reminders).
- **Used for:** App Functionality.
- **Linked to identity:** No.
- **Used for tracking:** No.

### 2. Diagnostics — Crash Data
- **Collected:** Yes (Firebase Crashlytics).
- **Used for:** App Functionality (and/or Analytics).
- **Linked to identity:** No.
- **Used for tracking:** No.

Everything else (attendance records, tasks, schedule, notes, Zentao data) is NOT
collected — it stays on the device. Zentao credentials are stored encrypted on-device
and sent only to the user's own server (not to the developer). Answer **No** to
Contact Info, Identifiers, Purchases, and all other categories. **No** advertising,
**no** third-party analytics/ad SDK, **no** tracking.
