import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:work_tracker/features/attendance/domain/attendance_repository.dart';
import 'package:work_tracker/features/location_log/domain/location_log_repository.dart';
import 'package:work_tracker/features/location_log/domain/models/location_log.dart';
import 'package:work_tracker/features/location_log/presentation/location_log_badge_tiers.dart';
import 'package:work_tracker/features/location_log/presentation/widgets/location_log_badge.dart';

part 'location_activity_day_state.dart';
part 'location_activity_day_cubit.freezed.dart';

/// Backs Screen B (`/attendance/:date`) — a single day's location activity,
/// read-only.
@injectable
class LocationActivityDayCubit extends Cubit<LocationActivityDayState> {
  LocationActivityDayCubit(
    this._locationLogRepository,
    this._attendanceRepository,
  ) : super(const LocationActivityDayState());

  final LocationLogRepository _locationLogRepository;
  final AttendanceRepository _attendanceRepository;

  Future<void> init(DateTime date) async {
    emit(const LocationActivityDayState());

    final events = await _locationLogRepository.getLogsForDay(date);
    final attendanceByDayKey = await _attendanceRepository.getAttendanceForMonth(
      year: date.year,
      month: date.month,
    );
    final dayKey = date.year * 10000 + date.month * 100 + date.day;

    final result = computeLocationLogBadgeTiers(
      events: events,
      attendance: attendanceByDayKey[dayKey],
    );

    emit(
      LocationActivityDayState(
        isLoading: false,
        events: result.sorted,
        badges: result.badges,
      ),
    );
  }
}
