import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_tracker/app/cubit/app_cubit.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/components/components.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/typography/app_typography.dart';

class _OnboardScreenData {
  const _OnboardScreenData({
    required this.icon,
    required this.headline,
    required this.body,
  });

  final IconData icon;
  final String headline;
  final String body;
}

const _screens = [
  _OnboardScreenData(
    icon: Icons.check_circle_outline,
    headline: 'Track your attendance',
    body:
        'Check in and out with one tap, and see your work hours at a glance.',
  ),
  _OnboardScreenData(
    icon: Icons.timer_outlined,
    headline: 'Time your tasks',
    body: 'Start a timer for any task and know exactly where your hours go.',
  ),
  _OnboardScreenData(
    icon: Icons.notifications_active_outlined,
    headline: 'Never miss a leave time',
    body: 'Get a nudge when it\'s time to head out, based on your schedule.',
  ),
];

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({super.key});

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  final _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_currentPage == _screens.length - 1) {
      context.read<AppCubit>().completeOnboarding();
      return;
    }
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = _currentPage == _screens.length - 1;

    return Scaffold(
      backgroundColor: context.colors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _screens.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (context, index) {
                  return _OnboardScreen(data: _screens[index]);
                },
              ),
            ),
            DotsPageIndicator(
              pageCount: _screens.length,
              currentPage: _currentPage,
            ),
            const SizedBox(height: AppSpacing.space24),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space24,
              ),
              child: PrimaryButton(
                label: isLastPage ? 'Get Started' : 'Next',
                onPressed: _onNext,
              ),
            ),
            const SizedBox(height: AppSpacing.space24),
          ],
        ),
      ),
    );
  }
}

class _OnboardScreen extends StatelessWidget {
  const _OnboardScreen({required this.data});

  final _OnboardScreenData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space24),
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.space48),
          SizedBox(
            width: 96,
            height: 96,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colors.primaryLight,
              ),
              child: Icon(
                data.icon,
                size: 48,
                color: context.colors.primary,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.space32),
          Text(
            data.headline,
            textAlign: TextAlign.center,
            style: AppTypography.headline(context)?.copyWith(
              color: context.colors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.space12),
          Text(
            data.body,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: AppTypography.body(context)?.copyWith(
              color: context.colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
