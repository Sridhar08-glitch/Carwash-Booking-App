import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/price_text.dart';
import '../../../../core/widgets/states.dart';
import '../../data/payments_dto.dart';
import '../../data/payments_repository.dart';

class WalletScreen extends ConsumerWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(walletProvider);
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Wallet')),
      body: async.when(
        loading: () => const LoadingState(),
        error: (e, _) => ErrorState(
          message: e.toString(),
          onRetry: () => ref.invalidate(walletProvider),
        ),
        data: (wallet) => RefreshIndicator(
          onRefresh: () async => ref.invalidate(walletProvider),
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              // Balance card
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: AppColors.brandGradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Available Balance',
                      style: tt.bodyMedium?.copyWith(color: Colors.white70),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    PriceText(
                      amount: wallet.balance,
                      currency: wallet.currency,
                      style: tt.displaySmall
                          ?.copyWith(color: Colors.white, height: 1),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text('Recent Transactions', style: tt.titleMedium),
              const SizedBox(height: AppSpacing.sm),
              if (wallet.recentTransactions.isEmpty)
                const EmptyState(
                  icon: Icons.receipt_long_outlined,
                  title: 'No transactions yet',
                  subtitle: 'Your wallet history will appear here.',
                )
              else
                ...wallet.recentTransactions
                    .map((tx) => _TransactionTile(tx: tx)),
            ],
          ),
        ),
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  const _TransactionTile({required this.tx});
  final WalletTransactionDto tx;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final isCredit = tx.type == 'credit';
    final date = DateTime.tryParse(tx.createdAt);
    final dateStr =
        date != null ? DateFormat('d MMM yyyy').format(date) : tx.createdAt;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: isCredit
            ? Colors.green.withOpacity(0.15)
            : Colors.red.withOpacity(0.15),
        child: Icon(
          isCredit ? Icons.add : Icons.remove,
          color: isCredit ? Colors.green : Colors.red,
        ),
      ),
      title: Text(tx.description, style: tt.bodyMedium),
      subtitle: Text(dateStr, style: tt.bodySmall),
      trailing: Text(
        '${isCredit ? '+' : '-'}${tx.amount} SAR',
        style: tt.bodyMedium?.copyWith(
          color: isCredit ? Colors.green : Colors.red,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
