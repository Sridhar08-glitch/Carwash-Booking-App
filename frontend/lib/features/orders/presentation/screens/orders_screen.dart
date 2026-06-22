import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/price_text.dart';
import '../../../../core/widgets/states.dart';
import '../../data/orders_dto.dart';
import '../../data/orders_repository.dart';

part 'orders_screen.g.dart';

@riverpod
Future<List<OrderListItemDto>> ordersList(OrdersListRef ref) =>
    ref.watch(ordersRepositoryProvider).getOrders();

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(ordersListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My Orders')),
      body: async.when(
        loading: () => const LoadingState(),
        error: (e, _) => ErrorState(
          message: e.toString(),
          onRetry: () => ref.invalidate(ordersListProvider),
        ),
        data: (orders) => orders.isEmpty
            ? const EmptyState(
                icon: Icons.receipt_long_outlined,
                title: 'No orders yet',
                subtitle: 'Products you order will appear here.',
              )
            : RefreshIndicator(
                onRefresh: () async => ref.invalidate(ordersListProvider),
                child: ListView.separated(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  itemCount: orders.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (context, i) =>
                      _OrderCard(order: orders[i]),
                ),
              ),
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.order});
  final OrderListItemDto order;

  Color _statusColor(String status) => switch (status) {
        'completed' => Colors.green,
        'cancelled' => Colors.red,
        'processing' => Colors.orange,
        _ => Colors.blue,
      };

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    final date = DateTime.tryParse(order.createdAt);
    final dateStr =
        date != null ? DateFormat('d MMM yyyy').format(date) : order.createdAt;

    return GestureDetector(
      onTap: () => context.push('/orders/${order.id}'),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: cs.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order #${order.id}',
                      style: tt.titleSmall),
                  const SizedBox(height: 4),
                  Text('$dateStr · ${order.itemCount} item(s)',
                      style: tt.bodySmall),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                PriceText(amount: order.total, currency: order.currency),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color:
                        _statusColor(order.status).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    order.status.replaceAll('_', ' '),
                    style: tt.labelSmall?.copyWith(
                      color: _statusColor(order.status),
                    ),
                  ),
                ),
              ],
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
