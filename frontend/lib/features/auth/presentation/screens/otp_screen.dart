import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/buttons.dart';
import '../controllers/auth_controller.dart';

class OtpScreen extends ConsumerStatefulWidget {
  const OtpScreen({super.key, required this.phone, this.isNew = false});

  final String phone;
  final bool isNew;

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final _controllers = List.generate(6, (_) => TextEditingController());
  final _focusNodes = List.generate(6, (_) => FocusNode());
  String get _code =>
      _controllers.map((c) => c.text).join();

  @override
  void dispose() {
    for (final c in _controllers) { c.dispose(); }
    for (final f in _focusNodes) { f.dispose(); }
    super.dispose();
  }

  void _onDigitChanged(int index, String value) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    // Auto-submit when all 6 filled
    if (_code.length == 6) _verify();
  }

  Future<void> _verify() async {
    if (_code.length < 6) return;
    final ctrl = ref.read(authControllerProvider.notifier);
    final result = await ctrl.verifyOtp(_code);

    if (result.success && mounted) {
      // Router's redirect guard handles navigation to the right shell
      context.go(AppRoutes.home);
    } else if (mounted) {
      // Clear the OTP fields on failure
      for (final c in _controllers) { c.clear(); }
      _focusNodes.first.requestFocus();
    }
  }

  Future<void> _resend() async {
    await ref.read(authControllerProvider.notifier).resendOtp();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authControllerProvider);
    final theme = Theme.of(context);

    // Error snackbar
    ref.listen<AuthFormState>(authControllerProvider, (_, next) {
      if (next.failure != null && next.fieldError == null && !next.isLoading) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_failureMessage(next))),
        );
      }
    });

    final canResend = state.resendSecondsLeft == 0;

    return Scaffold(
      appBar: AppBar(title: const Text('Verify')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.lg),

              Text('Enter the code', style: theme.textTheme.headlineSmall),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'A 6-digit code was sent to\n${widget.phone}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              // OTP digit boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (i) => _DigitBox(
                  controller: _controllers[i],
                  focusNode: _focusNodes[i],
                  autofocus: i == 0,
                  hasError: state.fieldError != null,
                  onChanged: (v) => _onDigitChanged(i, v),
                )),
              ),

              if (state.fieldError != null) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(
                  state.fieldError!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                ),
              ],

              // Attempts warning
              if (state.otpAttemptsLeft < 3 && state.otpAttemptsLeft > 0) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(
                  '${state.otpAttemptsLeft} attempt${state.otpAttemptsLeft == 1 ? '' : 's'} remaining',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],

              const SizedBox(height: AppSpacing.lg),

              // Resend
              Row(
                children: [
                  Text(
                    "Didn't get it? ",
                    style: theme.textTheme.bodyMedium,
                  ),
                  canResend
                      ? TextActionButton(
                          label: 'Resend',
                          onPressed: state.isLoading ? null : _resend,
                        )
                      : Text(
                          'Resend in ${state.resendSecondsLeft}s',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                ],
              ),

              const Spacer(),

              PrimaryButton(
                label: 'Verify',
                isLoading: state.isLoading,
                onPressed: (_code.length < 6 || state.isLoading)
                    ? null
                    : _verify,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _failureMessage(AuthFormState s) {
    return s.failure?.when(
          network: (m) => m,
          timeout: (m) => m,
          unauthorized: (m) => m,
          forbidden: (m) => m,
          notFound: (m) => m,
          conflict: (m) => m,
          validation: (m, _) => m,
          rateLimited: (m, w) =>
              w != null ? 'Too many requests. Wait ${w}s.' : m,
          server: (m) => m,
          slotUnavailable: (m) => m,
          insufficientWalletBalance: (m) => m,
          unknown: (m) => m,
          offline: (m) => m,
        ) ??
        'Verification failed. Please try again.';
  }
}

class _DigitBox extends StatelessWidget {
  const _DigitBox({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    this.autofocus = false,
    this.hasError = false,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final bool autofocus;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 48,
      height: 60,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        autofocus: autofocus,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: onChanged,
        style: theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.w700,
        ),
        decoration: InputDecoration(
          counterText: '',
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: hasError
                  ? theme.colorScheme.error
                  : theme.colorScheme.outline,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: hasError
                  ? theme.colorScheme.error
                  : theme.colorScheme.primary,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
