import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/providers/connectivity_provider.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/buttons.dart';
import '../../../../core/widgets/offline_banner.dart';
import '../../../../core/widgets/price_text.dart';
import '../../../cart/presentation/controllers/cart_controller.dart';
import '../../data/payments_repository.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  String _deliveryMethod = 'delivery';
  bool _isProcessing = false;

  Future<void> _pay() async {
    final isOnline = ref.read(isOnlineProvider);
    if (!isOnline) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No internet connection.')),
      );
      return;
    }

    setState(() => _isProcessing = true);
    try {
      final repo = ref.read(paymentsRepositoryProvider);

      // 1. Create order
      final order = await repo.checkout(deliveryMethod: _deliveryMethod);

      // 2. Get Stripe payment intent
      final intent = await repo.createPaymentIntent(order.payment.id);

      // 3. Init Stripe payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: intent.clientSecret,
          merchantDisplayName: 'Sridhar Car Wash',
          style: Theme.of(context).brightness == Brightness.dark
              ? ThemeMode.dark
              : ThemeMode.light,
        ),
      );

      // 4. Present sheet
      await Stripe.instance.presentPaymentSheet();

      // 5. Clear cart + navigate to order detail
      await ref.read(cartNotifierProvider.notifier).refresh();
      if (!mounted) return;
      context.go('/orders/${order.id}');
    } on StripeException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.error.localizedMessage ?? 'Payment failed.')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartNotifierProvider);
    final isOnline = ref.watch(isOnlineProvider);
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Column(
        children: [
          if (!isOnline) const OfflineBanner(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.md),
              children: [
                Text('Delivery method', style: tt.titleMedium),
                const SizedBox(height: AppSpacing.sm),
                _DeliveryOption(
                  label: 'Home Delivery',
                  icon: Icons.local_shipping_outlined,
                  value: 'delivery',
                  groupValue: _deliveryMethod,
                  onChanged: (v) => setState(() => _deliveryMethod = v!),
                ),
                _DeliveryOption(
                  label: 'Pickup from Branch',
                  icon: Icons.store_outlined,
                  value: 'pickup',
                  groupValue: _deliveryMethod,
                  onChanged: (v) => setState(() => _deliveryMethod = v!),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text('Order summary', style: tt.titleMedium),
                const SizedBox(height: AppSpacing.sm),
                ...cart.items.map(
                  (item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '${item.productName} × ${item.quantity}',
                            style: tt.bodyMedium,
                          ),
                        ),
                        PriceText(
                            amount: item.lineTotal,
                            currency: item.currency),
                      ],
                    ),
                  ),
                ),
                const Divider(height: AppSpacing.lg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total', style: tt.titleMedium),
                    PriceText(
                      amount: cart.total,
                      currency: cart.currency,
                      style: tt.titleMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: StickyBottomBar(
        child: PrimaryButton(
          label: _isProcessing ? 'Processing…' : 'Pay ${cart.total} SAR',
          onPressed: (_isProcessing || !isOnline) ? null : _pay,
        ),
      ),
    );
  }
}

class _DeliveryOption extends StatelessWidget {
  const _DeliveryOption({
    required this.label,
    required this.icon,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });
  final String label;
  final IconData icon;
  final String value;
  final String groupValue;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final selected = value == groupValue;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md, vertical: AppSpacing.sm),
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? cs.primary : cs.outline,
            width: selected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          color: selected ? cs.primaryContainer.withOpacity(0.15) : null,
        ),
        child: Row(
          children: [
            Icon(icon, color: selected ? cs.primary : cs.onSurface),
            const SizedBox(width: AppSpacing.sm),
            Text(label),
            const Spacer(),
            Radio<String>(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
