import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/buttons.dart';
import '../../../../core/widgets/network_image_box.dart';
import '../../../../core/widgets/price_text.dart';
import '../../../../core/widgets/states.dart';
import '../controllers/cart_controller.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  final _promoController = TextEditingController();
  bool _applyingPromo = false;

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  Future<void> _applyPromo() async {
    final code = _promoController.text.trim();
    if (code.isEmpty) return;
    setState(() => _applyingPromo = true);
    final ok =
        await ref.read(cartNotifierProvider.notifier).applyPromo(code);
    setState(() => _applyingPromo = false);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(ok ? 'Promo applied!' : 'Invalid promo code.'),
        backgroundColor: ok ? Colors.green : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartNotifierProvider);
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: cart.isLoading && cart.items.isEmpty
          ? const LoadingState()
          : cart.items.isEmpty
              ? const EmptyState(
                  icon: Icons.shopping_cart_outlined,
                  title: 'Your cart is empty',
                  subtitle: 'Add products from the shop to get started.',
                )
              : RefreshIndicator(
                  onRefresh: () =>
                      ref.read(cartNotifierProvider.notifier).refresh(),
                  child: ListView(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    children: [
                      // Items
                      ...cart.items.map((item) => _CartItemTile(
                            item: item,
                            onIncrease: () => ref
                                .read(cartNotifierProvider.notifier)
                                .updateItem(item.id, item.quantity + 1),
                            onDecrease: () => ref
                                .read(cartNotifierProvider.notifier)
                                .updateItem(item.id, item.quantity - 1),
                            onRemove: () => ref
                                .read(cartNotifierProvider.notifier)
                                .removeItem(item.id),
                          )),
                      const SizedBox(height: AppSpacing.md),
                      // Promo code
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _promoController,
                              decoration: const InputDecoration(
                                hintText: 'Promo code',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          _applyingPromo
                              ? const CircularProgressIndicator()
                              : OutlinedButton(
                                  onPressed: _applyPromo,
                                  child: const Text('Apply'),
                                ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      // Summary
                      _SummaryRow(
                          label: 'Subtotal', value: cart.subtotal, cs: cs),
                      if (double.tryParse(cart.discountAmount) != null &&
                          double.parse(cart.discountAmount) > 0)
                        _SummaryRow(
                          label: 'Discount',
                          value: '-${cart.discountAmount}',
                          cs: cs,
                          isDiscount: true,
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
      bottomNavigationBar: cart.items.isEmpty
          ? null
          : StickyBottomBar(
              child: PrimaryButton(
                label: 'Checkout',
                onPressed: cart.isLoading
                    ? null
                    : () => context.push('/checkout'),
              ),
            ),
    );
  }
}

class _CartItemTile extends StatelessWidget {
  const _CartItemTile({
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
  });
  final dynamic item;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: NetworkImageBox(
                  url: item.productImage, height: 64, width: 64),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.productName,
                      style: tt.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600)),
                  PriceText(
                      amount: item.unitPrice, currency: item.currency),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: onRemove,
                    color: cs.error),
                Row(
                  children: [
                    IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: onDecrease,
                        iconSize: 18),
                    Text('${item.quantity}', style: tt.bodyMedium),
                    IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: onIncrease,
                        iconSize: 18),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    required this.cs,
    this.isDiscount = false,
  });
  final String label;
  final String value;
  final ColorScheme cs;
  final bool isDiscount;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: tt.bodyMedium),
          Text(
            value,
            style: tt.bodyMedium?.copyWith(
              color: isDiscount ? Colors.green : null,
            ),
          ),
        ],
      ),
    );
  }
}
