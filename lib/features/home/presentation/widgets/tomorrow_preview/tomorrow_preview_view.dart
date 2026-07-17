import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/components/card/shadow_card.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/typography/app_typography.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/leave_reminder/domain/weather_copy.dart';

import 'cubit/tomorrow_preview_cubit.dart';

class TomorrowPreviewView extends StatelessWidget {
  const TomorrowPreviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => getIt.call<TomorrowPreviewCubit>()..init(),
      child: BlocBuilder<TomorrowPreviewCubit, TomorrowPreviewState>(
        builder: (context, state) {
          final preview = state.preview;
          if (preview == null) return const SizedBox.shrink();

          return ShadowCard(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "TOMORROW'S COMMUTE",
                    style: AppTypography.caption(context)?.copyWith(
                      color: context.colors.textSecondary,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space16),
                  if (preview.weatherCode != null &&
                      preview.temperature != null)
                    Row(
                      children: [
                        Text(
                          weatherEmoji(preview.weatherCode!),
                          style: const TextStyle(fontSize: 28),
                        ),
                        const SizedBox(width: AppSpacing.space8),
                        Text(
                          '${preview.temperature!.round()}°C',
                          style: AppTypography.title(context)?.copyWith(
                            color: context.colors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  if (preview.weatherCode != null &&
                      preview.temperature != null)
                    const SizedBox(height: AppSpacing.space12),
                  Text(
                    preview.bodyText,
                    style: AppTypography.body(
                      context,
                    )?.copyWith(color: context.colors.textSecondary),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
