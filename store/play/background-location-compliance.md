# Play Console — Background Location Compliance Pack

Everything needed to pass the Google Play review for `ACCESS_BACKGROUND_LOCATION`
(+ `ACCESS_FINE_LOCATION` / `ACCESS_COARSE_LOCATION`). Paste-match against the
Console screens.

---

## 1. Permission declaration — "background location access" form

**Feature that uses background location:** Location Activity (auto attendance).

**Which feature requires background location? / Describe how it's used:**

> WorkTracker's optional "Location Activity" feature automatically logs when the
> user arrives at and leaves their saved work location, and fills in their
> check-in / check-out times. To detect arrival and departure while the app is
> closed or not in use, the app runs a short, bounded location watch around the
> user's scheduled work hours (starting ~30 minutes before their start time and
> ending on departure or midnight). It is not continuous tracking: only the
> arrival and departure events are recorded, they are stored on the device, and
> location is never sold or shared. The feature is off by default and must be
> explicitly enabled by the user, who also chooses their work location.

**Video URL:** `https://youtu.be/________`  ← YouTube **Unlisted** (not Private).

---

## 2. Prominent disclosure (shown in-app before the permission prompt)

Lives in `lib/features/location_log/presentation/widgets/location_log_setup_sheet.dart`,
above the enable toggle. Current text:

> Automatically logs when you arrive at and leave work, and fills in your
> check-in/check-out if not set yet.
>
> To do this, WorkTracker collects your location in the background — even when
> the app is closed or not in use — during a short window around your scheduled
> work hours. Location is only used to detect arrival at and departure from your
> saved work location. It is stored on your device and never sold or shared.

Reviewer checklist for the video: this text must be **fully visible before** the
Android "Allow all the time" dialog is triggered.

---

## 3. Data safety form answers

### Location
- **Precise location** — Collected: **Yes**
  - Purpose: **App functionality** (only)
  - Required? **No** — "Users can choose whether this data is collected"
  - Processed ephemerally? **No** (some is stored on-device)
  - Shared? **No** *(see note below)*
- **Approximate location** — Collected: **Yes** (COARSE permission requested)
  - Same purpose / optional / shared answers as above.

### App info & performance
- **Crash logs** — Collected: **Yes** → App functionality / Analytics (Firebase Crashlytics)
- **Diagnostics** — Collected: **Yes** → same

### Shared vs. not — the judgment call
Leave Reminders sends **coordinates only** (no identity) to Google Distance
Matrix, Google Places, Google Geocoding, and Open-Meteo, as service providers.
Privacy policy frames these as processing on the app's behalf → **Shared: No**
is defensible. Caveat: `leave_reminder_background_dispatcher.dart` sends
coordinates in the background (no live user action), which weakens the
"user-initiated" defense. If unsure the endpoints act only as processors,
mark **Shared: Yes → App functionality** — that is the safe, non-rejectable
choice.

### Not declared (with reason)
- **Location Activity data** — never leaves the device (ObjectBox only), so it
  is not "collected" for Data safety purposes.
- **Zentao credentials / imported tasks** — sent only to the user's own
  self-specified server at their direction; not collected by the developer.

---

## 4. Pre-submit checklist
- [ ] Video recorded, uploaded to YouTube as **Unlisted**, URL pasted in the declaration.
- [ ] Video shows the prominent disclosure **before** the "Allow all the time" dialog.
- [ ] Data safety form: Precise + Approximate location marked collected, optional, App functionality.
- [ ] Data safety form: **Crashlytics** (Crash logs + Diagnostics) declared — easy to forget.
- [ ] Data safety "Shared" answer chosen deliberately (see §3).
- [ ] Data safety privacy-policy URL points to the policy that covers the
      background watch (`docs/privacy_policy.html`, §2 Location Data).
- [ ] Store listing / app content does not contradict "off by default, opt-in."
