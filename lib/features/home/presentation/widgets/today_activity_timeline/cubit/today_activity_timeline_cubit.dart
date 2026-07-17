import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:work_tracker/features/attendance/domain/attendance_repository.dart';
import 'package:work_tracker/features/attendance/domain/models/attendance.dart';
import 'package:work_tracker/features/location_log/domain/location_log_repository.dart';
import 'package:work_tracker/features/location_log/domain/models/location_log.dart';
import 'package:work_tracker/features/location_log/domain/models/location_log_type.dart';
import 'package:work_tracker/features/location_log/presentation/widgets/location_log_badge.dart';

part 'today_activity_timeline_state.dart';
part 'today_activity_timeline_cubit.freezed.dart';

@injectable
class TodayActivityTimelineCubit extends Cubit<TodayActivityTimelineState> {
  TodayActivityTimelineCubit({
    required this._locationLogRepository,
    required this._attendanceRepository,
  }) : super(const TodayActivityTimelineState.notEnabled());

  final LocationLogRepository _locationLogRepository;
  final AttendanceRepository _attendanceRepository;

  StreamSubscription<List<LocationLog>>? _logsSubscription;
  StreamSubscription<Attendance?>? _attendanceSubscription;

  Future<void> init() async {
    final enabled = await _locationLogRepository.isEnabled();
    if (!enabled) {
      emit(const TodayActivityTimelineState.notEnabled());
      return;
    }

    _logsSubscription = _locationLogRepository.watchLogsChanges().listen(
      (_) => _refresh(),
      onError: (Object e) => debugPrint('Today activity logs stream error: $e'),
    );
    _attendanceSubscription = _attendanceRepository.watchAttendanceChanges().listen(
      (_) => _refresh(),
      onError: (Object e) =>
          debugPrint('Today activity attendance stream error: $e'),
    );

    await _refresh();
  }

  Future<void> _refresh() async {
    try {
      final events = await _locationLogRepository.getLogsForDay(
        DateTime.now(),
      );
      if (events.isEmpty) {
        emit(const TodayActivityTimelineState.noEventsToday());
        return;
      }

      final attendance = await _attendanceRepository.getTodayAttendance();
      final sorted = [...events]
        ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

      final badges = <LocationLog, LocationLogBadgeTier>{};
      var firstArrivalSeen = false;
      var firstDepartureSeen = false;
      for (final log in sorted) {
        if (log.type == LocationLogType.arrival) {
          if (firstArrivalSeen) {
            badges[log] = LocationLogBadgeTier.none;
            continue;
          }
          firstArrivalSeen = true;
          if (attendance?.checkIn == log.timestamp) {
            badges[log] = LocationLogBadgeTier.assigned;
          } else if (attendance?.checkIn != null) {
            badges[log] = LocationLogBadgeTier.notUsed;
          } else {
            badges[log] = LocationLogBadgeTier.none;
          }
        } else {
          if (firstDepartureSeen) {
            badges[log] = LocationLogBadgeTier.none;
            continue;
          }
          firstDepartureSeen = true;
          if (attendance?.checkOut == log.timestamp) {
            badges[log] = LocationLogBadgeTier.assigned;
          } else if (attendance?.checkOut != null) {
            badges[log] = LocationLogBadgeTier.notUsed;
          } else {
            badges[log] = LocationLogBadgeTier.none;
          }
        }
      }

      emit(TodayActivityTimelineState.populated(events: sorted, badges: badges));
    } catch (e) {
      debugPrint('Failed to refresh today activity timeline: $e');
    }
  }

  @override
  Future<void> close() {
    _logsSubscription?.cancel();
    _attendanceSubscription?.cancel();
    return super.close();
  }
}
