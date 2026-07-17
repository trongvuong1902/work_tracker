import 'package:flutter/material.dart';
import 'package:work_tracker/app/theme/app_colors.dart';
import 'package:work_tracker/components/components.dart';
import 'package:work_tracker/core/spacing/app_spacing.dart';
import 'package:work_tracker/core/typography/app_typography.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/zentao/domain/zentao_repository.dart';

/// Strips whitespace, a trailing `/api.php/v1` (or with trailing slash), and
/// a trailing slash — then, if what's left has no scheme, assumes `https://`.
/// Applied live as the user types/pastes so the field "just works" whether
/// they paste the bare server URL or the full endpoint they were given.
String _normalizeZentaoDomain(String input) {
  var value = input.trim();
  value = value.replaceFirst(
    RegExp(r'/api\.php/v1/?$', caseSensitive: false),
    '',
  );
  if (value.endsWith('/')) {
    value = value.substring(0, value.length - 1);
  }
  if (value.isNotEmpty && !value.contains('://')) {
    value = 'https://$value';
  }
  return value;
}

/// Null if [domain] (already normalized) looks like a usable base URL.
String? _validateDomain(String domain) {
  if (domain.isEmpty) return 'Enter a domain.';
  final uri = Uri.tryParse(domain);
  if (uri == null || uri.host.isEmpty) {
    return 'Enter a valid URL, e.g. https://your-server.com.';
  }
  return null;
}

class ZentaoConnectForm extends StatefulWidget {
  const ZentaoConnectForm({super.key, required this.onConnected});

  /// Called once `connect()` succeeds.
  final VoidCallback onConnected;

  @override
  State<ZentaoConnectForm> createState() => _ZentaoConnectFormState();
}

class _ZentaoConnectFormState extends State<ZentaoConnectForm> {
  final _domainController = TextEditingController();
  final _accountController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isConnecting = false;
  String? _errorMessage;
  String? _domainError;

  @override
  void initState() {
    super.initState();
    _domainController.addListener(_onDomainChanged);
  }

  void _onDomainChanged() {
    final normalized = _normalizeZentaoDomain(_domainController.text);
    if (normalized != _domainController.text) {
      _domainController.value = TextEditingValue(
        text: normalized,
        selection: TextSelection.collapsed(offset: normalized.length),
      );
      return; // setting .value re-triggers this listener with the final text
    }
    final error = normalized.isEmpty ? null : _validateDomain(normalized);
    if (error != _domainError) setState(() => _domainError = error);
  }

  @override
  void dispose() {
    _domainController.removeListener(_onDomainChanged);
    _domainController.dispose();
    _accountController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _connect() async {
    final domain = _domainController.text.trim();
    final account = _accountController.text.trim();
    final password = _passwordController.text;

    final domainError = _validateDomain(domain);
    if (domainError != null || account.isEmpty || password.isEmpty) {
      setState(() {
        _domainError = domainError;
        _errorMessage = domainError == null
            ? 'Fill in domain, account, and password.'
            : null;
      });
      return;
    }

    setState(() {
      _isConnecting = true;
      _errorMessage = null;
    });

    final success = await getIt<ZentaoRepository>().connect(
      domain: domain,
      account: account,
      password: password,
    );

    if (!mounted) return;
    if (success) {
      widget.onConnected();
    } else {
      setState(() {
        _isConnecting = false;
        _errorMessage =
            "Couldn't connect — check the domain, account, and password.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Domain', style: AppTypography.label(context)),
        const SizedBox(height: AppSpacing.space8),
        _ConnectField(
          controller: _domainController,
          hintText: 'https://your-server.com',
          keyboardType: TextInputType.url,
        ),
        const SizedBox(height: AppSpacing.space4),
        Text(
          _domainError ??
              'Include a subpath if Zentao is installed under one, e.g. /zentao',
          style: AppTypography.caption(context)?.copyWith(
            color: _domainError != null
                ? context.colors.error
                : context.colors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.space16),
        Text('Account', style: AppTypography.label(context)),
        const SizedBox(height: AppSpacing.space8),
        _ConnectField(controller: _accountController),
        const SizedBox(height: AppSpacing.space16),
        Text('Password', style: AppTypography.label(context)),
        const SizedBox(height: AppSpacing.space8),
        _ConnectField(controller: _passwordController, obscureText: true),
        if (_errorMessage != null) ...[
          const SizedBox(height: AppSpacing.space16),
          Text(
            _errorMessage!,
            style: AppTypography.body(
              context,
            )?.copyWith(color: context.colors.error),
          ),
        ],
        const SizedBox(height: AppSpacing.space16),
        PrimaryButton(
          label: 'Connect',
          isLoading: _isConnecting,
          onPressed: _connect,
        ),
      ],
    );
  }
}

class _ConnectField extends StatelessWidget {
  const _ConnectField({
    required this.controller,
    this.hintText,
    this.obscureText = false,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String? hintText;
  final bool obscureText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return ShadowCard(
      margin: EdgeInsets.zero,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: AppTypography.body(context),
        decoration: InputDecoration(
          border: InputBorder.none,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.space16,
            vertical: AppSpacing.space16,
          ),
          hintText: hintText,
          hintStyle: AppTypography.body(
            context,
          )?.copyWith(color: context.colors.textSecondary),
        ),
      ),
    );
  }
}
