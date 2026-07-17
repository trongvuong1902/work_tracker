import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/home/presentation/widgets/hero_card/check_in_view.dart';
import 'package:work_tracker/features/home/presentation/widgets/hero_card/cubit/hero_card_cubit.dart';
import 'package:work_tracker/features/home/presentation/widgets/hero_card/hero_card_model.dart';

import 'working_progress_view.dart';

class HeroCardView extends StatelessWidget {
  const HeroCardView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => getIt.call<HeroCardCubit>()..init(),
      child: BlocBuilder<HeroCardCubit, HeroCardState>(
        builder: (context, state) {
          final model = state.heroCardModel;
          return model?.when(
                beforeCheckIn: (leaveHomeAt, arriveAtWorkAt) => CheckInView(
                  leaveHomeAt: leaveHomeAt,
                  arriveAtWorkAt: arriveAtWorkAt,
                ),
                working: (checkIn, leaveAt, breakStart, breakEnd) {
                  return WorkingProgressView(
                    checkIn: checkIn,
                    leaveAt: leaveAt,
                    breakStart: breakStart,
                    breakEnd: breakEnd,
                  );
                },
                afterCheckOut: () {
                  // Handle after check-out state
                  return const SizedBox.shrink();
                },
              ) ??
              const SizedBox.shrink();
        },
      ),
    );
  }
}
