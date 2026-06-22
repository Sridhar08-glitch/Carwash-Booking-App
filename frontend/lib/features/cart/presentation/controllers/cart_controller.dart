import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/cart_dto.dart';
import '../../data/cart_repository.dart';

part 'cart_controller.freezed.dart';
part 'cart_controller.g.dart';

@freezed
class CartState with _$CartState {
  const factory CartState({
    @Default([]) List<CartItemDto> items,
    @Default('0.00') String subtotal,
    @Default('0.00') String discountAmount,
    @Default('0.00') String total,
    @Default('SAR') String currency,
    String? promoCode,
    @Default(false) bool isLoading,
    String? error,
  }) = _CartState;

  const CartState._();

  int get itemCount => items.fold(0, (sum, i) => sum + i.quantity);
}

@Riverpod(keepAlive: true)
class CartNotifier extends _$CartNotifier {
  @override
  CartState build() {
    // Load cart from server on init
    Future.microtask(_loadCart);
    return const CartState(isLoading: true);
  }

  Future<void> _loadCart() async {
    try {
      final cart = await ref.read(cartRepositoryProvider).getCart();
      _applyDto(cart);
    } catch (_) {
      state = state.copyWith(isLoading: false);
    }
  }

  void _applyDto(CartDto dto) {
    state = state.copyWith(
      items: dto.items,
      subtotal: dto.subtotal,
      discountAmount: dto.discountAmount,
      total: dto.total,
      currency: dto.currency,
      promoCode: dto.promoCode,
      isLoading: false,
      error: null,
    );
  }

  Future<void> addItem(int productId, int quantity) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final cart =
          await ref.read(cartRepositoryProvider).addItem(productId, quantity);
      _applyDto(cart);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> updateItem(int itemId, int quantity) async {
    if (quantity <= 0) {
      await removeItem(itemId);
      return;
    }
    state = state.copyWith(isLoading: true, error: null);
    try {
      final cart =
          await ref.read(cartRepositoryProvider).updateItem(itemId, quantity);
      _applyDto(cart);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> removeItem(int itemId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final cart = await ref.read(cartRepositoryProvider).removeItem(itemId);
      _applyDto(cart);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<bool> applyPromo(String code) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final cart = await ref.read(cartRepositoryProvider).applyPromo(code);
      _applyDto(cart);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<void> refresh() => _loadCart();
}

// Convenience alias used by other features (e.g. product_detail_screen)
final cartProvider = cartNotifierProvider;
