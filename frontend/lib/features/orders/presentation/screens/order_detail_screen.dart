import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/network_image_box.dart';
import '../../../../core/widgets/price_text.dart';
import '../../../../core/widgets/states.dart';
import '../../data/orders_dto.dart';
import '../../data/orders_repository.dart';

part 'order_detail_screen.g.dart';

@riverpod
Future<OrderDto> orderDetail(OrderDetailRef ref, int id) =>
    ref.watch(ordersRepositoryProvider).getOrder(id);

class OrderDetailScreen extends ConsumerWidget {
  const OrderDetailScreen({super.key, required this.orderId});
  final int orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(orderDetailProvider(orderId));
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text('Order #$orderId')),
      body: async.when(
        loading: () => const LoadingState(),
        error: (e, _) => ErrorState(message: e.toString()),
        data: (order) {
          final date = DateTime.tryParse(order.createdAt);
          final dateStr = date != null
              ? DateFormat('d MMM yyyy, HH:mm').format(date)
              : order.createdAt;

          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(orderDetailProvider(orderId)),
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.md),
              children: [
                // Status banner
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: cs.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.receipt_long_outlined),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Status',
                                style: tt.labelSmall),
                            Text(
                              order.status.replaceAll('_', ' '),
                              style: tt.titleMedium,
                            ),
                          ],
                        ),
                      ),
                      Text(dateStr, style: tt.bodySmall),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text('Items', style: tt.titleMedium),
                const SizedBox(height: AppSpacing.sm),
                ...order.items.map((item) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: NetworkImageBox(
                            url: item.productImage, height: 56, width: 56),
                      ),
                      title: Text(item.productName),
                      subtitle: Text('Qty: ${item.quantity}'),
                      trailing: PriceText(
                          amount: item.lineTotal, currency: item.currency),
                    )),
                const Divider(height: AppSpacing.lg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total', style: tt.titleMedium),
                    PriceText(
                      amount: order.total,
                      currency: order.currency,
                      style: tt.titleMedium,
                    ),
                  ],
                ),
                if (order.deliveryMethod.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.sm),
                    child: Text(
                      'Delivery: ${order.deliveryMethod.replaceAll('_', ' ')}',
                      style: tt.bodySmall,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
