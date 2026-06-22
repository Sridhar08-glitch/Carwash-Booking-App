import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/shop_dto.dart';
import '../../data/shop_repository.dart';

part 'shop_controller.freezed.dart';
part 'shop_controller.g.dart';

@freezed
class ShopState with _$ShopState {
  const factory ShopState({
    @Default([]) List<ProductDto> products,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    String? error,
    String? search,
    String? brand,
    String? carType,
    @Default(1) int currentPage,
    @Default(false) bool hasMore,
  }) = _ShopState;
}

@riverpod
class ShopController extends _$ShopController {
  @override
  ShopState build() {
    // Load initial products
    Future.microtask(loadProducts);
    return const ShopState(isLoading: true);
  }

  Future<void> loadProducts({bool refresh = false}) async {
    final repo = ref.read(shopRepositoryProvider);
    if (refresh) {
      state = state.copyWith(isLoading: true, error: null, currentPage: 1);
    }

    try {
      final response = await repo.getProducts(
        search: state.search,
        brand: state.brand,
        carType: state.carType,
        page: refresh ? 1 : state.currentPage,
      );
      state = state.copyWith(
        products: refresh
            ? response.results
            : [...state.products, ...response.results],
        isLoading: false,
        isLoadingMore: false,
        hasMore: response.next != null,
        currentPage: refresh ? 2 : state.currentPage + 1,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isLoadingMore: false,
        error: e.toString(),
      );
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;
    state = state.copyWith(isLoadingMore: true);
    await loadProducts();
  }

  void applyFilter({String? search, String? brand, String? carType}) {
    state = state.copyWith(
      search: search,
      brand: brand,
      carType: carType,
      products: [],
      currentPage: 1,
      isLoading: true,
    );
    loadProducts(refresh: true);
  }

  void clearFilters() {
    state = state.copyWith(
      search: null,
      brand: null,
      carType: null,
      products: [],
      currentPage: 1,
      isLoading: true,
    );
    loadProducts(refresh: true);
  }
}

@riverpod
Future<ProductDto> productDetail(ProductDetailRef ref, int id) =>
    ref.watch(shopRepositoryProvider).getProduct(id);
