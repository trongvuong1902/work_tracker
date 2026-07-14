import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:work_tracker/features/attendance/domain/attendance_repository.dart';
import 'package:work_tracker/features/attendance/domain/models/attendance.dart';
import 'package:work_tracker/features/home/presentation/widgets/hero_card/hero_card_model.dart';

part 'hero_card_state.dart';
part 'hero_card_cubit.freezed.dart';

@injectable
class HeroCardCubit extends Cubit<HeroCardState> {
  HeroCardCubit({required this._attendanceRepository}) : super(HeroCardState());

  final AttendanceRepository _attendanceRepository;
  late final StreamSubscription<Attendance?> _attendanceSubscription;
  void init() {
    _attendanceSubscription = _attendanceRepository
        .watchAttendanceChanges()
        .listen((attendance) async {
          if (attendance != null) {
            final heroCardModel = HeroCardModel.fromAttendance(attendance);
            emit(HeroCardState(heroCardModel: heroCardModel));
          } else {
            emit(
              HeroCardState(heroCardModel: const HeroCardModel.beforeCheckIn()),
            );
          }
        });
  }

  @override
  Future<void> close() {
    _attendanceSubscription.cancel();
    return super.close();
  }
}
