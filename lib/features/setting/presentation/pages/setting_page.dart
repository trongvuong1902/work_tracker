import 'dart:io';

import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:work_tracker/app/cubit/app_cubit.dart';
import 'package:work_tracker/app/router/app_navigator.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/components/components.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/typography/app_typography.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/checkout_reminder/presentation/widgets/checkout_reminder_setup_sheet.dart';
import 'package:work_tracker/features/leave_reminder/domain/leave_reminder_repository.dart';
import 'package:work_tracker/features/leave_reminder/domain/models/leave_reminder_settings.dart';
import 'package:work_tracker/features/leave_reminder/presentation/widgets/leave_reminder_setup_sheet.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String? _databasePath;
  PackageInfo? _packageInfo;
  LeaveReminderSettings? _leaveReminderSettings;

  @override
  void initState() {
    super.initState();
    _loadDatabasePath();
    _loadPackageInfo();
    _loadLeaveReminderStatus();
  }

  Future<void> _loadDatabasePath() async {
    final directory = await defaultStoreDirectory();
    final path = '${directory.path}${Platform.pathSeparator}data.mdb';
    if (mounted) setState(() => _databasePath = path);
  }

  Future<void> _loadPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    if (mounted) setState(() => _packageInfo = info);
  }

  Future<void> _loadLeaveReminderStatus() async {
    final settings = await getIt<LeaveReminderRepository>().getSettings();
    if (mounted) setState(() => _leaveReminderSettings = settings);
  }

  @override
  Widget build(BuildContext context) {
    final settings = _leaveReminderSettings;
    final setCount =
        (settings?.home != null ? 1 : 0) + (settings?.work != null ? 1 : 0);
    String? statusText;
    var isActive = false;
    if (settings != null) {
      if (!settings.enabled) {
        statusText = 'Off';
      } else if (setCount < 2) {
        statusText = '$setCount of 2 locations set';
      } else {
        statusText = 'Active';
        isActive = true;
      }
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Setting Page',
              style: AppTypography.title(
                context,
              )?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: AppSpacing.space16),
            ShadowCard(
              margin: EdgeInsets.zero,
              child: InkWell(
                onTap: () async {
                  await showLeaveReminderSetupSheet(context);
                  _loadLeaveReminderStatus();
                },
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.space16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Leave reminders',
                        style: AppTypography.label(context),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (statusText != null) ...[
                            Text(
                              statusText,
                              style: AppTypography.body(context)?.copyWith(
                                color: isActive
                                    ? context.colors.primary
                                    : context.colors.textSecondary,
                                fontWeight: isActive
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.space8),
                          ],
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.space16),
            ShadowCard(
              margin: EdgeInsets.zero,
              child: InkWell(
                onTap: () => AppNavigator.pushWorkScheduleSettings(context),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.space16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Work schedule',
                        style: AppTypography.label(context),
                      ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.space16),
            ShadowCard(
              margin: EdgeInsets.zero,
              child: InkWell(
                onTap: () => showCheckoutReminderSetupSheet(context),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.space16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Checkout reminder',
                        style: AppTypography.label(context),
                      ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.space16),
            ShadowCard(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.space16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Appearance', style: AppTypography.label(context)),
                    const SizedBox(height: AppSpacing.space8),
                    BlocBuilder<AppCubit, AppState>(
                      builder: (context, state) => Row(
                        children: [
                          Expanded(
                            child: SegmentedButton<ThemeMode>(
                              segments: const [
                                ButtonSegment(
                                  value: ThemeMode.system,
                                  label: Text('System'),
                                  icon: Icon(Icons.brightness_auto),
                                ),
                                ButtonSegment(
                                  value: ThemeMode.light,
                                  label: Text('Light'),
                                  icon: Icon(Icons.light_mode),
                                ),
                                ButtonSegment(
                                  value: ThemeMode.dark,
                                  label: Text('Dark'),
                                  icon: Icon(Icons.dark_mode),
                                ),
                              ],
                              selected: {state.themeMode},
                              onSelectionChanged: (selection) => context
                                  .read<AppCubit>()
                                  .setThemeMode(selection.first),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.space16),
            ShadowCard(
              margin: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.space16,
                      AppSpacing.space16,
                      AppSpacing.space16,
                      AppSpacing.space8,
                    ),
                    child: Text('About', style: AppTypography.label(context)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.space16,
                    ),
                    child: Text(
                      _packageInfo == null
                          ? 'Loading…'
                          : '${_packageInfo!.appName} '
                                '${_packageInfo!.version} '
                                '(${_packageInfo!.buildNumber})',
                      style: AppTypography.caption(context),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space8),
                  InkWell(
                    onTap: () => AppNavigator.pushPrivacyPolicy(context),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.space16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Privacy Policy',
                            style: AppTypography.label(context),
                          ),
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (kDebugMode) ...[
              const SizedBox(height: AppSpacing.space16),
              ShadowCard(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.space16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ObjectBox database file',
                        style: AppTypography.label(context),
                      ),
                      const SizedBox(height: AppSpacing.space4),
                      Text(
                        'Point ObjectBox Admin at this path to inspect the '
                        'database.',
                        style: AppTypography.caption(context),
                      ),
                      const SizedBox(height: AppSpacing.space8),
                      Row(
                        children: [
                          Expanded(
                            child: SelectableText(
                              _databasePath ?? 'Loading…',
                              style: AppTypography.body(context),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.copy, size: 20),
                            tooltip: 'Copy path',
                            onPressed: _databasePath == null
                                ? null
                                : () => _copyPath(context, _databasePath!),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _copyPath(BuildContext context, String path) {
    Clipboard.setData(ClipboardData(text: path));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Path copied to clipboard')));
  }
}
