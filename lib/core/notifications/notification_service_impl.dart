import 'dart:io';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:injectable/injectable.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import 'notification_service.dart';

const _androidChannelId = 'leave_reminder_channel';
const _androidChannelName = 'Leave reminders';
const _androidChannelDescription =
    'Heads-up and "time to leave" reminders based on your commute.';

/// Separate channel for notifications that must bypass silent mode — channel
/// audio settings are immutable after first creation, so this can't share
/// [_androidChannelId] with the default (ringer-respecting) notifications.
const _alarmChannelId = 'alarm_bypass_channel';
const _alarmChannelName = 'Alarm-style alerts';
const _alarmChannelDescription =
    'Notifications that play through the alarm stream and bypass silent mode.';

/// Channel for instant (non-scheduled) geofence arrival/departure event
/// notifications — kept separate since channel audio settings are immutable
/// after first creation.
const _geofenceChannelId = 'geofence_events_channel';
const _geofenceChannelName = 'Location activity';
const _geofenceChannelDescription =
    'Instant alerts when you arrive at or leave your work location.';

/// Some Android/iOS devices report deprecated IANA aliases (e.g. "Asia/Saigon")
/// that are missing from the timezone package's bundled database, which only
/// carries the canonical zone name. Translate the known legacy aliases to their
/// canonical equivalents before lookup so `tz.getLocation` receives a name that
/// exists (and so notifications schedule at the correct wall-clock time rather
/// than falling back to UTC).
const _timezoneAliases = {
  'Asia/Saigon': 'Asia/Ho_Chi_Minh',
  'Asia/Calcutta': 'Asia/Kolkata',
  'Asia/Rangoon': 'Asia/Yangon',
  'Asia/Katmandu': 'Asia/Kathmandu',
  'Asia/Ulan_Bator': 'Asia/Ulaanbaatar',
  'America/Buenos_Aires': 'America/Argentina/Buenos_Aires',
  'Europe/Kiev': 'Europe/Kyiv',
};

@visibleForTesting
tz.Location resolveLocation(String timezoneName) {
  final resolvedName = _timezoneAliases[timezoneName] ?? timezoneName;
  try {
    return tz.getLocation(resolvedName);
  } catch (error, stack) {
    // Unknown zone: fall back to UTC so startup never crashes, but surface it
    // (a wrong-but-silent UTC offset would otherwise mis-time every reminder).
    debugPrint(
      'NotificationService: unknown timezone "$timezoneName" '
      '(resolved "$resolvedName"); falling back to UTC.',
    );
    try {
      FirebaseCrashlytics.instance.recordError(
        error,
        stack,
        reason: 'Unresolved timezone "$timezoneName" -> UTC fallback',
        fatal: false,
      );
    } catch (_) {
      // Best-effort only; Firebase may not be initialized.
    }
    return tz.UTC;
  }
}

@LazySingleton(as: NotificationService)
class NotificationServiceImpl implements NotificationService {
  final FlutterLocalNotificationsPlugin _plugin;

  NotificationServiceImpl(this._plugin);

  @override
  Future<void> initialize() async {
    tz_data.initializeTimeZones();
    final timezoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(resolveLocation(timezoneName));

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const darwinSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestSoundPermission: false,
      requestBadgePermission: false,
    );

    await _plugin.initialize(
      const InitializationSettings(
        android: androidSettings,
        iOS: darwinSettings,
      ),
    );
  }

  @override
  Future<bool> requestPermission() async {
    if (Platform.isAndroid) {
      final granted = await _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
      return granted ?? false;
    }

    if (Platform.isIOS) {
      final granted = await _plugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
      return granted ?? false;
    }

    return true;
  }

  @override
  Future<bool> ensureExactAlarmPermission() async {
    if (!Platform.isAndroid) return true;

    final granted = await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestExactAlarmsPermission();
    return granted ?? false;
  }

  @override
  Future<void> scheduleAt({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    bool exact = true,
    bool bypassSilentMode = false,
  }) async {
    final canScheduleExact = exact && await _canScheduleExact();
    final scheduleMode = canScheduleExact
        ? AndroidScheduleMode.exactAllowWhileIdle
        : AndroidScheduleMode.inexactAllowWhileIdle;

    final androidDetails = bypassSilentMode
        ? const AndroidNotificationDetails(
            _alarmChannelId,
            _alarmChannelName,
            channelDescription: _alarmChannelDescription,
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            audioAttributesUsage: AudioAttributesUsage.alarm,
          )
        : const AndroidNotificationDetails(
            _androidChannelId,
            _androidChannelName,
            channelDescription: _androidChannelDescription,
            importance: Importance.high,
            priority: Priority.high,
          );

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      NotificationDetails(
        android: androidDetails,
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentSound: true,
          presentList: true,
          presentBanner: true,
        ),
      ),
      androidScheduleMode: scheduleMode,
    );
  }

  @override
  Future<void> show({
    required int id,
    required String title,
    required String body,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      _geofenceChannelId,
      _geofenceChannelName,
      channelDescription: _geofenceChannelDescription,
      importance: Importance.high,
      priority: Priority.high,
    );

    await _plugin.show(
      id,
      title,
      body,
      const NotificationDetails(
        android: androidDetails,
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentSound: true,
          presentList: true,
          presentBanner: true,
        ),
      ),
    );
  }

  @override
  Future<void> cancel(int id) => _plugin.cancel(id);

  @override
  Future<List<ScheduledNotificationInfo>> pendingNotifications() async {
    final pending = await _plugin.pendingNotificationRequests();
    return pending
        .map(
          (request) => ScheduledNotificationInfo(
            id: request.id,
            title: request.title,
            body: request.body,
          ),
        )
        .toList();
  }

  /// Checks (without prompting) whether exact alarms can currently be
  /// scheduled on Android. Always true on platforms without that
  /// restriction.
  Future<bool> _canScheduleExact() async {
    if (!Platform.isAndroid) return true;

    final canSchedule = await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.canScheduleExactNotifications();
    return canSchedule ?? false;
  }
}
