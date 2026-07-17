import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/app/router/app_navigator.dart';
import 'package:work_tracker/components/components.dart';
import 'package:work_tracker/core/core.dart';
import 'package:work_tracker/features/calendar/domain/models/calendar_day.dart';
import 'package:work_tracker/features/calendar/domain/models/day_summary_display.dart';
import 'package:work_tracker/features/calendar/presentation/cubit/calendar_cubit.dart';
import 'package:work_tracker/features/schedule/domain/models/work_schedule.dart';

class DaySummaryView extends StatelessWidget {
  final CalendarDayModel day;
  final WorkSchedule? schedule;
  final bool isWorkingDay;
  final DaySummaryDisplayState displayState;
  final String? errorMessage;

  const DaySummaryView({
    super.key,
    required this.day,
    required this.schedule,
    required this.isWorkingDay,
    required this.displayState,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final attendance = day.attendance;

    return ShadowCard(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        '${weekdayInitials[day.date.weekday - 1]}, '
                        '${day.date.day} ${monthNames[day.date.month - 1]} '
                        '${day.date.year}',
                        style: AppTypography.subtitle(
                          context,
                        )?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      if (day.isToday)
                        Text(
                          ' · Today',
                          style: AppTypography.caption(
                            context,
                          )?.copyWith(color: colors.textSecondary),
                        ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () =>
                      AppNavigator.pushAttendanceDetail(context, day.date),
                  child: Text(
                    'Location activity',
                    style: AppTypography.caption(
                      context,
                    )?.copyWith(color: colors.primary),
                  ),
                ),
              ],
            ),
            if (attendance?.isEdited == true) ...[
              const SizedBox(height: AppSpacing.space4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.edit, size: 12, color: colors.textSecondary),
                  const SizedBox(width: AppSpacing.space4),
                  Text(
                    'Edited',
                    style: AppTypography.caption(
                      context,
                    )?.copyWith(color: colors.textSecondary),
                  ),
                ],
              ),
            ],
            const SizedBox(height: AppSpacing.space12),
            _buildBody(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    switch (displayState) {
      case DaySummaryDisplayState.populated:
        return _PopulatedBody(day: day, errorMessage: errorMessage);
      case DaySummaryDisplayState.scheduleFallbackPast:
        return _ScheduleFallbackBody(
          day: day,
          schedule: schedule!,
          isPast: true,
          errorMessage: errorMessage,
        );
      case DaySummaryDisplayState.scheduleFallbackFuture:
        return _ScheduleFallbackBody(
          day: day,
          schedule: schedule!,
          isPast: false,
          errorMessage: null,
        );
      case DaySummaryDisplayState.nonWorkingDay:
        return Text(
          'Not a scheduled work day.',
          style: AppTypography.body(
            context,
          )?.copyWith(color: context.colors.textSecondary),
        );
      case DaySummaryDisplayState.noScheduleSetUp:
        return const _NoScheduleBody();
    }
  }
}

/// Opens [showAppTimePicker] and, on confirm, applies the picked time
/// (anchored to [day]'s date, never `DateTime.now()`) as a check-in or
/// check-out via [CalendarCubit].
Future<void> _editDayTime({
  required BuildContext context,
  required CalendarDayModel day,
  required TimeOfDay initial,
  required bool isCheckIn,
}) async {
  final cubit = context.read<CalendarCubit>();
  final result = await showAppTimePicker(
    context: context,
    initialTime: initial,
  );
  if (result == null || !context.mounted) return;

  final time = DateTime(
    day.date.year,
    day.date.month,
    day.date.day,
    result.hour,
    result.minute,
  );
  if (isCheckIn) {
    await cubit.editCheckIn(time);
  } else {
    await cubit.editCheckOut(time);
  }
}

/// State A — attendance exists: editable Check-in/Check-out, derived Worked.
class _PopulatedBody extends StatelessWidget {
  const _PopulatedBody({required this.day, required this.errorMessage});

  final CalendarDayModel day;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final attendance = day.attendance!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _DetailItem(
                label: 'Check-in',
                value: attendance.checkIn != null
                    ? TimeFormat.hhMmFromDateTime(attendance.checkIn!)
                    : '-',
                editable: true,
                onTap: () => _editDayTime(
                  context: context,
                  day: day,
                  initial: attendance.checkIn != null
                      ? TimeOfDay.fromDateTime(attendance.checkIn!)
                      : TimeOfDay.now(),
                  isCheckIn: true,
                ),
              ),
            ),
            Expanded(
              child: _DetailItem(
                label: 'Check-out',
                value: attendance.checkOut != null
                    ? TimeFormat.hhMmFromDateTime(attendance.checkOut!)
                    : '-',
                editable: true,
                onTap: () => _editDayTime(
                  context: context,
                  day: day,
                  initial: attendance.checkOut != null
                      ? TimeOfDay.fromDateTime(attendance.checkOut!)
                      : TimeOfDay.now(),
                  isCheckIn: false,
                ),
              ),
            ),
            Expanded(
              child: _DetailItem(
                label: 'Worked',
                value: attendance.checkOut != null
                    ? TimeFormat.hMm(attendance.workedMinutes)
                    : '-',
              ),
            ),
          ],
        ),
        if (errorMessage != null) ...[
          const SizedBox(height: AppSpacing.space8),
          Text(
            errorMessage!,
            style: AppTypography.body(
              context,
            )?.copyWith(color: context.colors.error),
          ),
        ],
      ],
    );
  }
}

/// States B & C — no attendance, schedule applies to this weekday: Start/End
/// (tappable when [isPast]) plus a read-only Lunch tile.
class _ScheduleFallbackBody extends StatelessWidget {
  const _ScheduleFallbackBody({
    required this.day,
    required this.schedule,
    required this.isPast,
    required this.errorMessage,
  });

  final CalendarDayModel day;
  final WorkSchedule schedule;
  final bool isPast;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isPast ? 'Scheduled (no attendance recorded)' : 'Scheduled',
          style: AppTypography.caption(
            context,
          )?.copyWith(color: context.colors.textSecondary),
        ),
        const SizedBox(height: AppSpacing.space8),
        Row(
          children: [
            Expanded(
              child: _DetailItem(
                label: 'Start',
                value: TimeFormat.hhMm(schedule.startMinuteOfDay),
                editable: isPast,
                onTap: isPast
                    ? () => _editDayTime(
                        context: context,
                        day: day,
                        initial: _timeOfDayFromMinute(
                          schedule.startMinuteOfDay,
                        ),
                        isCheckIn: true,
                      )
                    : null,
              ),
            ),
            Expanded(
              child: _DetailItem(
                label: 'End',
                value: TimeFormat.hhMm(schedule.endMinuteOfDay),
                editable: isPast,
                onTap: isPast
                    ? () => _editDayTime(
                        context: context,
                        day: day,
                        initial: _timeOfDayFromMinute(schedule.endMinuteOfDay),
                        isCheckIn: false,
                      )
                    : null,
              ),
            ),
            Expanded(
              child: _DetailItem(
                label: 'Lunch',
                value: TimeFormat.hMm(schedule.lunchMinutes),
              ),
            ),
          ],
        ),
        if (isPast && errorMessage != null) ...[
          const SizedBox(height: AppSpacing.space8),
          Text(
            errorMessage!,
            style: AppTypography.body(
              context,
            )?.copyWith(color: context.colors.error),
          ),
        ],
      ],
    );
  }

  TimeOfDay _timeOfDayFromMinute(int minuteOfDay) =>
      TimeOfDay(hour: (minuteOfDay ~/ 60) % 24, minute: minuteOfDay % 60);
}

/// State E — no schedule set up at all.
class _NoScheduleBody extends StatelessWidget {
  const _NoScheduleBody();

  @override
  Widget build(BuildContext context) {
    return ShadowCard(
      color: context.colors.primaryLight,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'No schedule set up',
              style: AppTypography.subtitle(
                context,
              )?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: AppSpacing.space4),
            Text(
              'Set your work hours to see your schedule and track attendance.',
              style: AppTypography.body(
                context,
              )?.copyWith(color: context.colors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.space16),
            PrimaryButton(
              label: 'Set schedule',
              onPressed: () => _openScheduleSettings(context),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openScheduleSettings(BuildContext context) async {
    final cubit = context.read<CalendarCubit>();
    await AppNavigator.pushWorkScheduleSettings(context);
    if (!context.mounted) return;
    await cubit.refreshAfterScheduleChange();
  }
}

class _DetailItem extends StatelessWidget {
  final String label;
  final String value;
  final bool editable;
  final VoidCallback? onTap;

  const _DetailItem({
    required this.label,
    required this.value,
    this.editable = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: AppTypography.title(
            context,
          )?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: AppSpacing.space4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: AppTypography.caption(
                context,
              )?.copyWith(color: context.colors.textSecondary),
            ),
            if (editable) ...[
              const SizedBox(width: AppSpacing.space4),
              Icon(Icons.edit, size: 12, color: context.colors.textSecondary),
            ],
          ],
        ),
      ],
    );

    return editable ? InkWell(onTap: onTap, child: content) : content;
  }
}
