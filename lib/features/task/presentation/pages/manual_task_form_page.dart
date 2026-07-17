import 'package:flutter/material.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/components/components.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/typography/app_typography.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/task/domain/task_repository.dart';

/// Full-screen manual task creation form — title + description, "Save".
/// This is simple enough (a single one-shot repository call, no multi-step
/// state machine) that it calls `TaskRepository` directly from local
/// widget state rather than introducing a dedicated Cubit, mirroring how
/// e.g. `setting_page.dart` calls repositories directly for simple reads.
class ManualTaskFormPage extends StatefulWidget {
  const ManualTaskFormPage({super.key});

  @override
  State<ManualTaskFormPage> createState() => _ManualTaskFormPageState();
}

class _ManualTaskFormPageState extends State<ManualTaskFormPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isSaving = false;
  String? _errorMessage;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      setState(() => _errorMessage = 'Give the task a title first.');
      return;
    }

    setState(() {
      _isSaving = true;
      _errorMessage = null;
    });

    try {
      await getIt<TaskRepository>().createManual(
        title: title,
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
      );
      if (mounted) Navigator.pop(context);
    } catch (_) {
      if (mounted) {
        setState(() {
          _isSaving = false;
          _errorMessage = "Couldn't save the task — try again.";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New task')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.space16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Text('Title', style: AppTypography.label(context)),
                    const SizedBox(height: AppSpacing.space8),
                    _FormField(controller: _titleController, maxLines: 1),
                    const SizedBox(height: AppSpacing.space16),
                    Text('Description', style: AppTypography.label(context)),
                    const SizedBox(height: AppSpacing.space8),
                    _FormField(
                      controller: _descriptionController,
                      maxLines: 5,
                      hintText: 'Optional',
                    ),
                    if (_errorMessage != null) ...[
                      const SizedBox(height: AppSpacing.space16),
                      Text(
                        _errorMessage!,
                        style: AppTypography.body(
                          context,
                        )?.copyWith(color: context.colors.error),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.space16),
              PrimaryButton(
                label: 'Save',
                isLoading: _isSaving,
                onPressed: _save,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// `ShadowCard`-style free-text input surface — mirrors
/// `location_picker_page.dart`'s `_SearchBar`, kept feature-local for now
/// per that same file's note (not yet worth promoting to
/// `lib/components/` off a single additional use).
class _FormField extends StatelessWidget {
  const _FormField({
    required this.controller,
    required this.maxLines,
    this.hintText,
  });

  final TextEditingController controller;
  final int maxLines;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return ShadowCard(
      margin: EdgeInsets.zero,
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: AppTypography.body(context),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(AppSpacing.space16),
          hintText: hintText,
          hintStyle: AppTypography.body(
            context,
          )?.copyWith(color: context.colors.textSecondary),
        ),
      ),
    );
  }
}
