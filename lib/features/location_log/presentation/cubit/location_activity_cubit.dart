import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:work_tracker/features/attendance/domain/attendance_repository.dart';
import 'package:work_tracker/features/location_log/domain/location_log_repository.dart';
import 'package:work_tracker/features/location_log/domain/models/location_log.dart';
import 'package:work_tracker/features/location_log/presentation/location_log_badge_tiers.dart';
import 'package:work_tracker/features/location_log/presentation/widgets/location_log_badge.dart';

part 'location_activity_state.dart';
part 'location_activity_cubit.freezed.dart';

/// Backs Screen A (`/attendance`) — the full, day-grouped, paginated
/// location-activity history. "Load earlier" widens the loaded range and
/// refetches it whole (simpler than incremental accumulation, acceptable
/// for a personal-scale local dataset) rather than true infinite scroll.
@injectable
class LocationActivityCubit extends Cubit<LocationActivityState> {
  LocationActivityCubit(this._locationLogRepository, this._attendanceRepository)
    : super(const LocationActivityState.loading()) {
    init();
  }

  final LocationLogRepository _locationLogRepository;
  final AttendanceRepository _attendanceRepository;

  static const _pageDays = 30;
  static const _maxLookbackDays = 365;

  late DateTime _earliestLoadedDay;
  bool _canLoadMore = true;
  StreamSubscription<List<LocationLog>>? _logsSubscription;

  Future<void> init() async {
    final enabled = await _locationLogRepository.isEnabled();
    if (!enabled) {
      emit(const LocationActivityState.notEnabled());
      return;
    }

    final today = _dateOnly(DateTime.now());
    _earliestLoadedDay = today.subtract(const Duration(days: _pageDays - 1));
    _canLoadMore = true;

    _logsSubscription ??= _locationLogRepository.watchLogsChanges().listen(
      (_) => _reload(),
      onError: (Object e) =>
          debugPrint('Location activity logs stream error: $e'),
    );

    await _reload();
  }

  Future<void> loadEarlier() async {
    if (!_canLoadMore) return;

    final current = state;
    current.mapOrNull(
      populated: (populated) =>
          emit(populated.copyWith(isLoadingMore: true)),
    );

    var newEarliest = _earliestLoadedDay.subtract(
      const Duration(days: _pageDays),
    );
    final cutoff = _dateOnly(
      DateTime.now(),
    ).subtract(const Duration(days: _maxLookbackDays));
    if (!newEarliest.isAfter(cutoff)) {
      newEarliest = cutoff;
      _canLoadMore = false;
    }
    _earliestLoadedDay = newEarliest;

    await _reload();
  }

  Future<void> _reload() async {
    final today = DateTime.now();
    final events = await _locationLogRepository.getLogsForDayRange(
      start: _earliestLoadedDay,
      end: today,
    );

    if (events.isEmpty) {
      emit(const LocationActivityState.enabledNoEvents());
      return;
    }

    final byDayKey = <int, List<LocationLog>>{};
    for (final log in events) {
      byDayKey.putIfAbsent(log.dayKey, () => []).add(log);
    }

    final attendanceByDayKey = <int, dynamic>{};
    var monthCursor = DateTime(
      _earliestLoadedDay.year,
      _earliestLoadedDay.month,
    );
    final lastMonth = DateTime(today.year, today.month);
    while (!monthCursor.isAfter(lastMonth)) {
      final monthAttendance = await _attendanceRepository.getAttendanceForMonth(
        year: monthCursor.year,
        month: monthCursor.month,
      );
      attendanceByDayKey.addAll(monthAttendance);
      monthCursor = DateTime(monthCursor.year, monthCursor.month + 1);
    }

    final sortedDayKeys = byDayKey.keys.toList()
      ..sort((a, b) => b.compareTo(a));
    final sections = sortedDayKeys.map((dayKey) {
      final result = computeLocationLogBadgeTiers(
        events: byDayKey[dayKey]!,
        attendance: attendanceByDayKey[dayKey],
      );
      return LocationActivityDaySection(
        date: _dateFromDayKey(dayKey),
        events: result.sorted,
        badges: result.badges,
      );
    }).toList();

    emit(
      LocationActivityState.populated(
        sections: sections,
        canLoadMore: _canLoadMore,
        isLoadingMore: false,
      ),
    );
  }

  DateTime _dateOnly(DateTime date) => DateTime(date.year, date.month, date.day);

  DateTime _dateFromDayKey(int dayKey) =>
      DateTime(dayKey ~/ 10000, (dayKey ~/ 100) % 100, dayKey % 100);

  @override
  Future<void> close() {
    _logsSubscription?.cancel();
    return super.close();
  }
}
