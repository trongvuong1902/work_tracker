import 'package:flutter_test/flutter_test.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;
import 'package:work_tracker/core/notifications/notification_service_impl.dart';

void main() {
  setUpAll(tz_data.initializeTimeZones);

  group('resolveLocation', () {
    test('maps legacy alias Asia/Saigon to Asia/Ho_Chi_Minh (+7h)', () {
      final location = resolveLocation('Asia/Saigon');

      expect(location.name, 'Asia/Ho_Chi_Minh');
      // Ho Chi Minh City has had a fixed +7h offset since 1975, no DST.
      final now = tz.TZDateTime.now(location);
      expect(now.timeZoneOffset, const Duration(hours: 7));
    });

    test('passes through a canonical name unchanged', () {
      final location = resolveLocation('Asia/Tokyo');

      expect(location.name, 'Asia/Tokyo');
      expect(tz.TZDateTime.now(location).timeZoneOffset, const Duration(hours: 9));
    });

    test('maps other legacy aliases (Asia/Calcutta -> Asia/Kolkata)', () {
      expect(resolveLocation('Asia/Calcutta').name, 'Asia/Kolkata');
    });

    test('falls back to UTC for an unknown zone without throwing', () {
      final location = resolveLocation('Not/ARealZone');

      expect(location, tz.UTC);
    });
  });
}
