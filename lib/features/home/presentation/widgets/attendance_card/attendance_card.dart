import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/home/presentation/widgets/attendance_card/attendance_working_view.dart';
import 'package:work_tracker/features/home/presentation/widgets/attendance_card/cubit/attendace_card_cubit.dart';
import 'package:work_tracker/features/home/presentation/widgets/attendance_card/today_schedule_view.dart';
import 'package:work_tracker/features/home/presentation/widgets/attendance_card/today_summary_view.dart';
import 'package:work_tracker/features/home/presentation/widgets/attendance_card/attendance_card_model.dart';

class AttendanceCardView extends StatelessWidget {
  const AttendanceCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => getIt<AttendaceCardCubit>()..init(),
      child: BlocBuilder<AttendaceCardCubit, AttendaceCardState>(
        builder: (context, state) {
          return state.model?.when(
                beforeCheckIn: (s, e, w, b) {
                  return TodayScheduleView(
                    plannedEndWorkTime: e,
                    startWorkTime: s,
                  );
                },
                working:
                    (
                      actualCheckInTime,
                      plannedCheckInTime,
                      estimateCheckOutTime,
                      plannedLeave,
                      extraTimeCheckIn,
                      checkInStatus,
                      extraTimeCheckOut,
                      checkOutStatus,
                    ) {
                      return AttendanceWorkingView(
                        estimateCheckOutTime: estimateCheckOutTime,
                        plannedLeave: plannedLeave,
                        extraTimeCheckIn: extraTimeCheckIn,
                        checkInStatus: checkInStatus,
                        extraTimeCheckOut: extraTimeCheckOut,
                        checkOutStatus: checkOutStatus,
                        actualCheckInTime: actualCheckInTime,
                        plannedCheckInTime: plannedCheckInTime,
                      );
                    },
                afterCheckOut:
                    (
                      workedTime,
                      plannedWorkedTime,
                      overtime,
                      actualCheckInTime,
                      plannedCheckInTime,
                      checkInStatus,
                      checkInExtra,
                      actualCheckOutTime,
                      plannedCheckOutTime,
                      checkOutStatus,
                      checkOutExtra,
                    ) {
                      return TodaySummaryView(
                        workedTime: workedTime,
                        plannedWorkedTime: plannedWorkedTime,
                        overtime: overtime,
                        actualCheckInTime: actualCheckInTime,
                        plannedCheckInTime: plannedCheckInTime,
                        checkInStatus: checkInStatus,
                        checkInExtra: checkInExtra,
                        actualCheckOutTime: actualCheckOutTime,
                        plannedCheckOutTime: plannedCheckOutTime,
                        checkOutStatus: checkOutStatus,
                        checkOutExtra: checkOutExtra,
                      );
                    },
              ) ??
              const SizedBox.shrink();
        },
      ),
    );
  }
}
