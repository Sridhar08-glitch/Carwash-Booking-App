import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/buttons.dart';
import '../../../../core/widgets/network_image_box.dart';
import '../../../../core/widgets/price_text.dart';
import '../../../../core/widgets/states.dart';
import '../../../cart/presentation/controllers/cart_controller.dart';
import '../controllers/shop_controller.dart';

class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen({super.key, required this.productId});
  final int productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(productDetailProvider(productId));
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: async.when(
        loading: () => const LoadingState(),
        error: (e, _) => ErrorState(message: e.toString()),
        data: (product) => CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 320,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: NetworkImageBox(
                  url: product.imageUrl,
                  height: 320,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(AppSpacing.md),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Brand
                  Text(
                    product.brand.toUpperCase(),
                    style: tt.labelMedium?.copyWith(
                      color: cs.primary,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  // Name
                  Text(product.name, style: tt.headlineSmall),
                  const SizedBox(height: AppSpacing.sm),
                  // Price
                  PriceText(
                    amount: product.price,
                    currency: product.currency,
                    originalAmount: product.compareAtPrice,
                    style: tt.titleLarge,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  // Rating row
                  if (product.reviewCount > 0)
                    Row(
                      children: [
                        Icon(Icons.star_rounded,
                            color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          '${product.rating.toStringAsFixed(1)} '
                          '(${product.reviewCount} reviews)',
                          style: tt.bodySmall,
                        ),
                      ],
                    ),
                  const SizedBox(height: AppSpacing.lg),
                  // Description
                  Text('Description', style: tt.titleMedium),
                  const SizedBox(height: AppSpacing.xs),
                  Text(product.description, style: tt.bodyMedium),
                  const SizedBox(height: 100), // space for sticky bar
                ]),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: async.whenData((product) {
        final inCart = ref.watch(
          cartProvider.select(
            (s) => s.items.any((i) => i.productId == product.id),
          ),
        );

        return StickyBottomBar(
          child: product.inStock
              ? PrimaryButton(
                  label: inCart ? 'View Cart' : 'Add to Cart',
                  onPressed: () {
                    if (inCart) {
                      context.push('/cart');
                    } else {
                      ref
                          .read(cartProvider.notifier)
                          .addItem(product.id, 1);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${product.name} added to cart'),
                          action: SnackBarAction(
                            label: 'View Cart',
                            onPressed: () => context.push('/cart'),
                          ),
                        ),
                      );
                    }
                  },
                )
              : PrimaryButton(
                  label: 'Out of Stock',
                  onPressed: null,
                ),
        );
      }).valueOrNull ??
          const SizedBox.shrink(),
    );
  }
}
