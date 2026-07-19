/// Verbatim privacy-policy copy shown on [PrivacyPolicyPage]. Do not
/// reword the legal content here — only formatting/line-wrapping changes
/// are safe without product/legal sign-off.
const String kPrivacyPolicyText = '''
Privacy Policy for WorkTracker

Last updated: July 19, 2026

WorkTracker is a personal productivity app for tracking attendance, task time, and leave reminders. This policy explains what data the app uses and how it's handled.

1. Data Storage
All data you enter into WorkTracker — attendance records, work schedules, task logs, and leave-reminder settings — is stored locally on your device using an on-device database. WorkTracker does not require an account, and none of this data is uploaded to any server or cloud service operated by us.

2. Location Data
If you enable Leave Reminders, you will set a Home and Work location using the in-app map picker. These coordinates, and the address text described below, are stored locally on your device and used to:
- Estimate your commute time via Google's Distance Matrix API (only latitude/longitude coordinates are sent, not your name or any other identifying information).
- Fetch local weather conditions for your work location via the Open-Meteo weather service (a free, keyless public API), used only to phrase the leave-reminder notification.
- Search for an address by name, if you use the picker's search field: the text you type is sent to Google's Places Autocomplete service to look up matching suggestions as you type.
- Look up a human-readable address for a picked location via Google's Geocoding API, which converts the coordinates you've chosen (whether by search, tapping the map, or your device's current position) into an address for display. The resulting address text is stored locally alongside your Home/Work coordinates so it can be shown again without repeating the lookup.
Location data and search text are only sent to these third-party services when performing the specific action described (searching, picking a point, or refreshing a commute/weather estimate), and only if you have enabled Leave Reminders.
If you enable the optional Location Activity Log, WorkTracker watches for you arriving at or leaving your work location (including while the app is in the background) so it can log those events. This watching happens entirely on your device — only the fact that you crossed into or out of the area is recorded locally; your continuous location is never transmitted anywhere.

3. Notifications
WorkTracker schedules local notifications on your device (e.g. heads-up and leave-now alerts) using your device's own notification system. These notifications are generated and delivered entirely on-device — no push notification server is involved, and no notification content is sent anywhere.

4. Crash Reporting and Diagnostics
WorkTracker uses Google Firebase Crashlytics to collect crash reports and error diagnostics (such as the type of error and a technical stack trace) so we can find and fix problems. This diagnostic data is processed by Google on our behalf. It does not include the attendance, task, schedule, or location data you enter into the app.

5. Zentao Integration (Optional)
If you choose to connect WorkTracker to your own Zentao instance, the account name and password you enter are stored encrypted on your device and are sent only to the Zentao server you specify — never to us or any other party. The tasks and bugs you import (including their text, comments, and attachment information) are stored locally on your device and are exchanged only with your Zentao server to keep them in sync.

6. AI Assistant (Optional)
If the AI bug-fix assistant is enabled in your build, and you choose to use it on a task linked to a Zentao bug, the text describing that bug (such as its title, description, steps to reproduce, and comment history) is sent over a secure connection to the AI provider configured for the app — by default Google's Gemini API. Only text is sent; image or file attachments are not transmitted. This happens only when you actively invoke the feature. If no AI provider is configured, the feature is disabled and no data is sent.

7. Third-Party Services
- Google Distance Matrix API — commute time estimates (coordinates only).
- Google Places API — address search suggestions while picking a Home/Work location (the text you type, plus coordinates).
- Google Geocoding API — converts a picked coordinate into a human-readable address (coordinates only).
- Google Maps — renders the map used to pick your Home/Work location.
- Open-Meteo — weather forecast for the leave-reminder notification (coordinates only).
- Google Firebase Crashlytics — crash reports and error diagnostics.
- Your Zentao server — only if you connect one; receives your login and the task/bug data you sync.
- AI provider (Google Gemini by default) — only if the AI assistant is enabled and used; receives the text of the bug you ask it about.
These services process only the data needed to answer a single request and are not used for advertising or tracking. WorkTracker contains no advertising and no analytics tracking.

8. Data You Control
Because all app data lives on your device, uninstalling the app or clearing its storage permanently deletes it. WorkTracker does not provide cloud backup; if you switch devices, your data will not carry over automatically. You can disconnect a Zentao instance at any time from the app's settings, which removes the stored credentials from your device.

9. Children's Privacy
WorkTracker is not directed at children and does not knowingly collect data from children.

10. Changes to This Policy
We may update this policy as the app evolves. Continued use of the app after an update constitutes acceptance of the revised policy.

11. Contact
Questions about this policy can be sent to trongvuong1902@gmail.com.
''';
