import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/components/components.dart';
import 'package:work_tracker/core/core.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/task/domain/daily_report.dart';
import 'package:work_tracker/features/task/presentation/cubit/daily_report_cubit.dart';

/// Opens the daily report popup — a summary of the tasks worked on [day]
/// (default: today), grouped by task with each work session's start/end and
/// duration, plus a Copy button.
void showDailyReportSheet(BuildContext context, {DateTime? day}) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => BlocProvider(
      create: (_) => getIt<DailyReportCubit>()..load(day),
      child: const _DailyReportView(),
    ),
  );
}

class _DailyReportView extends StatelessWidget {
  const _DailyReportView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyReportCubit, DailyReportState>(
      builder: (context, state) {
        final report = state.report;
        return SafeArea(
          top: false,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.space16,
                0,
                AppSpacing.space16,
                AppSpacing.space16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    report == null
                        ? 'Daily report'
                        : dailyReportTitle(report.day),
                    style: AppTypography.title(context),
                  ),
                  const SizedBox(height: AppSpacing.space12),
                  if (state.isLoading)
                    const Padding(
                      padding: EdgeInsets.all(AppSpacing.space24),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else if (report == null || report.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.space16,
                      ),
                      child: Text(
                        'No time tracked today.',
                        style: AppTypography.body(context)?.copyWith(
                          color: context.colors.textSecondary,
                        ),
                      ),
                    )
                  else
                    Flexible(
                      child: ShadowCard(
                        margin: EdgeInsets.zero,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(AppSpacing.space16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (final entry in report.entries) ...[
                                _EntryBlock(entry: entry),
                                const SizedBox(height: AppSpacing.space12),
                              ],
                              const Divider(height: AppSpacing.space16),
                              Text(
                                'Total: '
                                '${TimeFormat.hMm(report.totalSeconds ~/ 60)}',
                                style: AppTypography.label(context)?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: AppSpacing.space16),
                  PrimaryButton(
                    label: 'Copy report',
                    icon: Icons.copy,
                    onPressed: (report == null || report.isEmpty)
                        ? null
                        : () => _copy(context, report),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _copy(BuildContext context, DailyReport report) {
    Clipboard.setData(ClipboardData(text: renderDailyReportText(report)));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Report copied')),
    );
  }
}

class _EntryBlock extends StatelessWidget {
  const _EntryBlock({required this.entry});

  final DailyReportEntry entry;

  @override
  Widget build(BuildContext context) {
    final idPart = entry.externalId != null ? '#${entry.externalId}  ' : '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                '$idPart${entry.title}',
                style: AppTypography.body(context),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: AppSpacing.space8),
            Text(
              TimeFormat.hMm(entry.totalSeconds ~/ 60),
              style: AppTypography.label(context)?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        for (final session in entry.sessions)
          Padding(
            padding: const EdgeInsets.only(
              top: AppSpacing.space4,
              left: AppSpacing.space12,
            ),
            child: Text(
              '${TimeFormat.hhMmFromDateTime(session.start)}'
              '–${TimeFormat.hhMmFromDateTime(session.end)}'
              ' · ${TimeFormat.hMm(session.durationSeconds ~/ 60)}',
              style: AppTypography.caption(context)?.copyWith(
                color: context.colors.textSecondary,
              ),
            ),
          ),
      ],
    );
  }
}
