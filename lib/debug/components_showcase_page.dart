import 'package:flutter/material.dart';

import '../components/components.dart';
import '../core/core.dart';

class ComponentsShowcasePage extends StatelessWidget {
  const ComponentsShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Components (debug)')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.space16),
        children: [
          _SectionTitle('Colors'),
          const SizedBox(height: AppSpacing.space8),
          _ColorSwatches(),
          const SizedBox(height: AppSpacing.space24),
          _SectionTitle('Radius'),
          const SizedBox(height: AppSpacing.space8),
          _RadiusSamples(),
          const SizedBox(height: AppSpacing.space24),
          _SectionTitle('Spacing'),
          const SizedBox(height: AppSpacing.space8),
          _SpacingSamples(),
          const SizedBox(height: AppSpacing.space24),
          _SectionTitle('Buttons'),
          const SizedBox(height: AppSpacing.space12),
          const _ButtonSamples(),
          const SizedBox(height: AppSpacing.space24),
          _SectionTitle('Shadow'),
          const SizedBox(height: AppSpacing.space12),
          const _ShadowSamples(),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: AppTypography.title(context));
  }
}

class _ColorSwatches extends StatelessWidget {
  const _ColorSwatches();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final swatches = <String, Color>{
      'primary': colors.primary,
      'primaryLight': colors.primaryLight,
      'success': colors.success,
      'warning': colors.warning,
      'error': colors.error,
      'background': colors.background,
      'surface': colors.surface,
      'surfaceSecondary': colors.surfaceSecondary,
      'textPrimary': colors.textPrimary,
      'textSecondary': colors.textSecondary,
      'divider': colors.divider,
      'outline': colors.outline,
    };

    return Wrap(
      spacing: AppSpacing.space12,
      runSpacing: AppSpacing.space12,
      children: swatches.entries.map((entry) {
        return SizedBox(
          width: 96,
          child: Column(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: entry.value,
                  borderRadius: BorderRadius.circular(AppRadius.radius8),
                  border: Border.all(color: colors.divider),
                ),
              ),
              const SizedBox(height: AppSpacing.space4),
              Text(
                entry.key,
                textAlign: TextAlign.center,
                style: AppTypography.caption(context),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _RadiusSamples extends StatelessWidget {
  const _RadiusSamples();

  static const _radii = <String, double>{
    'radius4': AppRadius.radius4,
    'radius8': AppRadius.radius8,
    'radius12': AppRadius.radius12,
    'radius16': AppRadius.radius16,
    'radius24': AppRadius.radius24,
    'radius32': AppRadius.radius32,
  };

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.space12,
      runSpacing: AppSpacing.space12,
      children: _radii.entries.map((entry) {
        return SizedBox(
          width: 96,
          child: Column(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: context.colors.primaryLight,
                  borderRadius: BorderRadius.circular(entry.value),
                  border: Border.all(color: context.colors.primary),
                ),
              ),
              const SizedBox(height: AppSpacing.space4),
              Text(
                entry.key,
                textAlign: TextAlign.center,
                style: AppTypography.caption(context),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _SpacingSamples extends StatelessWidget {
  const _SpacingSamples();

  static const _spacings = <String, double>{
    'space4': AppSpacing.space4,
    'space8': AppSpacing.space8,
    'space12': AppSpacing.space12,
    'space16': AppSpacing.space16,
    'space24': AppSpacing.space24,
    'space32': AppSpacing.space32,
    'space48': AppSpacing.space48,
    'space64': AppSpacing.space64,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _spacings.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.space8),
          child: Row(
            children: [
              SizedBox(
                width: 80,
                child: Text(entry.key, style: AppTypography.caption(context)),
              ),
              Container(
                width: entry.value,
                height: 16,
                color: context.colors.primary,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _ButtonSamples extends StatelessWidget {
  const _ButtonSamples();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PrimaryButton(label: 'Primary Button', onPressed: _noop),
        const SizedBox(height: AppSpacing.space12),
        const PrimaryButton(label: 'Primary Disabled', onPressed: null),
        const SizedBox(height: AppSpacing.space12),
        const PrimaryButton(
          label: 'Primary Loading',
          onPressed: _noop,
          isLoading: true,
        ),
        const SizedBox(height: AppSpacing.space12),
        const PrimaryButton(
          label: 'Primary With Icon',
          onPressed: _noop,
          icon: Icons.check,
        ),
        const SizedBox(height: AppSpacing.space24),
        const SecondaryButton(label: 'Secondary Button', onPressed: _noop),
        const SizedBox(height: AppSpacing.space12),
        const SecondaryButton(label: 'Secondary Disabled', onPressed: null),
        const SizedBox(height: AppSpacing.space12),
        const SecondaryButton(
          label: 'Secondary Loading',
          onPressed: _noop,
          isLoading: true,
        ),
        const SizedBox(height: AppSpacing.space12),
        const SecondaryButton(
          label: 'Secondary With Icon',
          onPressed: _noop,
          icon: Icons.close,
        ),
      ],
    );
  }

  static void _noop() {}
}

class _ShadowSamples extends StatelessWidget {
  const _ShadowSamples();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.space12,
      runSpacing: AppSpacing.space12,
      children: [
        Column(
          children: [
            ShadowCard(
              margin: EdgeInsets.zero,
              child: SizedBox(
                width: 88,
                height: 64,
                child: Center(
                  child: Text('small', style: AppTypography.caption(context)),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.space4),
            Text('AppShadow.small', style: AppTypography.caption(context)),
          ],
        ),
        Column(
          children: [
            Container(
              width: 88,
              height: 64,
              decoration: BoxDecoration(
                color: context.colors.surface,
                borderRadius: BorderRadius.circular(AppRadius.radius8),
                boxShadow: AppShadow.medium,
              ),
              child: Center(
                child: Text('medium', style: AppTypography.caption(context)),
              ),
            ),
            const SizedBox(height: AppSpacing.space4),
            Text('AppShadow.medium', style: AppTypography.caption(context)),
          ],
        ),
      ],
    );
  }
}
