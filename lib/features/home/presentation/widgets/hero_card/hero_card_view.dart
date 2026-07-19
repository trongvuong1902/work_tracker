import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/features/home/presentation/widgets/hero_card/checked_out_hero.dart';
import 'package:work_tracker/features/home/presentation/widgets/hero_card/cubit/hero_card_cubit.dart';
import 'package:work_tracker/features/home/presentation/widgets/hero_card/hero_card_model.dart';
import 'package:work_tracker/features/home/presentation/widgets/hero_card/leave_home_hero.dart';
import 'package:work_tracker/features/home/presentation/widgets/hero_card/leave_reminder_cta.dart';
import 'package:work_tracker/features/home/presentation/widgets/hero_card/working_status_strip.dart';
import 'package:work_tracker/features/home/presentation/widgets/hero_card/wrap_up_hero.dart';

/// The Home page's lifecycle-driven hero — its content is entirely a
/// function of [HeroCardModel]'s current case (the [HeroCardCubit] is
/// provided by the page, since [HomePage] also needs it to reorder its
/// sections around the same state).
class HeroCardView extends StatelessWidget {
  const HeroCardView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HeroCardCubit, HeroCardState>(
      builder: (context, state) {
        final model = state.heroCardModel;
        return model?.when(
              beforeCheckIn: (leaveHomeAt, arriveAtWorkAt, ctaKind) =>
                  leaveHomeAt != null
                  ? LeaveHomeHero(
                      leaveHomeAt: leaveHomeAt,
                      arriveAtWorkAt: arriveAtWorkAt,
                    )
                  : LeaveReminderCta(ctaKind: ctaKind),
              working: (checkIn, leaveAt, breakStart, breakEnd) {
                return WorkingStatusStrip(checkIn: checkIn, leaveAt: leaveAt);
              },
              approachingCheckOut: (checkIn, scheduledEnd) {
                return WrapUpHero(scheduledEnd: scheduledEnd);
              },
              afterCheckOut: (checkOutAt) {
                return CheckedOutHero(checkOutAt: checkOutAt);
              },
            ) ??
            const SizedBox.shrink();
      },
    );
  }
}
