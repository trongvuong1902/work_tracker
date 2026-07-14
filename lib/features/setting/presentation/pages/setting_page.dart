import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';
import 'package:work_tracker/components/components.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/typography/app_typography.dart';
import 'package:work_tracker/features/leave_reminder/presentation/widgets/leave_reminder_setup_sheet.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String? _databasePath;

  @override
  void initState() {
    super.initState();
    _loadDatabasePath();
  }

  Future<void> _loadDatabasePath() async {
    final directory = await defaultStoreDirectory();
    final path = '${directory.path}${Platform.pathSeparator}data.mdb';
    if (mounted) setState(() => _databasePath = path);
  }

  @override
  Widget build(BuildContext context) {
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
                onTap: () => showLeaveReminderSetupSheet(context),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.space16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Leave reminders',
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
