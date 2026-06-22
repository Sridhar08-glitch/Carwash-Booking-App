import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/buttons.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _phoneController = TextEditingController();
  String? _localError;

  // E.164 validation: optional + sign, country code (1-3 digits), then
  // 4-14 digits.  This is a pragmatic check — it catches obvious mistakes
  // (letters, missing +, too short/long) before a network round-trip.
  static final _e164Regex = RegExp(r'^\+[1-9]\d{6,14}$');

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final phone = _phoneController.text.trim();

    // Local validation — instant feedback without a server round-trip
    if (phone.isEmpty) {
      setState(() => _localError = 'Please enter your phone number.');
      return;
    }
    if (!_e164Regex.hasMatch(phone)) {
      setState(() => _localError =
          'Use E.164 format: +[country code][number], e.g. +966512345678');
      return;
    }
    setState(() => _localError = null);

    final controller = ref.read(authControllerProvider.notifier);
    final success = await controller.requestOtp(phone);

    if (success && mounted) {
      context.push(
        '${AppRoutes.otp}?phone=${Uri.encodeComponent(phone)}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authControllerProvider);
    final theme = Theme.of(context);

    // Show snackbar for non-field errors
    ref.listen<AuthFormState>(authControllerProvider, (_, next) {
      if (next.failure != null && next.fieldError == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.failure!.when(
              network: (m) => m,
              timeout: (m) => m,
              unauthorized: (m) => m,
              forbidden: (m) => m,
              notFound: (m) => m,
              conflict: (m) => m,
              validation: (m, _) => m,
              rateLimited: (m, _) => m,
              server: (m) => m,
              slotUnavailable: (m) => m,
              insufficientWalletBalance: (m) => m,
              unknown: (m) => m,
              offline: (m) => m,
            )),
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
        leading: const BackButton(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.lg),

              Text('Your Phone Number', style: theme.textTheme.headlineSmall),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'We\'ll send you a one-time code to verify your identity.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              AppTextField(
                controller: _phoneController,
                label: 'Phone number',
                hint: '+966 5X XXX XXXX',
                keyboardType: TextInputType.phone,
                // Show local format error first; fall back to server field error
                errorText: _localError ?? state.fieldError,
                prefixIcon: const Icon(Icons.phone_outlined),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9+\s-]')),
                ],
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _submit(),
                onChanged: (_) {
                  // Clear local error as soon as the user edits
                  if (_localError != null) setState(() => _localError = null);
                },
              ),

              const SizedBox(height: AppSpacing.sm),
              Text(
                'Enter number in E.164 format, e.g. +966512345678',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),

              const Spacer(),

              PrimaryButton(
                label: 'Send Code',
                isLoading: state.isLoading,
                onPressed: state.isLoading ? null : _submit,
                icon: const Icon(Icons.arrow_forward_rounded, size: 20),
              ),
              const SizedBox(height: AppSpacing.md),

              Center(
                child: Text(
                  'By continuing you agree to our Terms & Privacy Policy.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
