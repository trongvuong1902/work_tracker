/// Verbatim privacy-policy copy shown on [PrivacyPolicyPage]. Do not
/// reword the legal content here — only formatting/line-wrapping changes
/// are safe without product/legal sign-off.
const String kPrivacyPolicyText = '''
Privacy Policy for WorkTracker

Last updated: July 15, 2026

WorkTracker is a personal productivity app for tracking attendance, task time, and leave reminders. This policy explains what data the app uses and how it's handled.

1. Data Storage
All data you enter into WorkTracker — attendance records, work schedules, task logs, and leave-reminder settings — is stored locally on your device using an on-device database. WorkTracker does not require an account, and none of this data is uploaded to any server or cloud service operated by us.

2. Location Data
If you enable Leave Reminders, you will set a Home and Work location. These coordinates are stored locally on your device and used to:
- Estimate your commute time via Google's Distance Matrix API (only latitude/longitude coordinates are sent, not your name or any other identifying information).
- Fetch local weather conditions for your work location via the Open-Meteo weather service (a free, keyless public API), used only to phrase the leave-reminder notification.
Location data is only sent to these two third-party services when computing a fresh commute/weather estimate, and only if you have enabled Leave Reminders.

3. Notifications
WorkTracker schedules local notifications on your device (e.g. heads-up and leave-now alerts) using your device's own notification system. These notifications are generated and delivered entirely on-device — no push notification server is involved, and no notification content is sent anywhere.

4. Third-Party Services
- Google Distance Matrix API — commute time estimates (coordinates only).
- Open-Meteo — weather forecast for the leave-reminder notification (coordinates only).
Each of these services processes only the coordinates needed to answer a single request and is not used for advertising or tracking.

5. Data You Control
Because all app data lives on your device, uninstalling the app or clearing its storage permanently deletes it. WorkTracker does not provide cloud backup; if you switch devices, your data will not carry over automatically.

6. Children's Privacy
WorkTracker is not directed at children and does not knowingly collect data from children.

7. Changes to This Policy
We may update this policy as the app evolves. Continued use of the app after an update constitutes acceptance of the revised policy.

8. Contact
Questions about this policy can be sent to [add your support email here].
''';
