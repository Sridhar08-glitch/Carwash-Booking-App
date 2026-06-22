import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/services_dto.dart';
import '../../data/services_repository.dart';

part 'services_controller.freezed.dart';
part 'services_controller.g.dart';

@freezed
class ServicesState with _$ServicesState {
  const factory ServicesState({
    @Default([]) List<ServiceDto> services,
    @Default([]) List<ServiceCategoryDto> categories,
    ServiceCategoryDto? selectedCategory,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _ServicesState;
}

@riverpod
class ServicesController extends _$ServicesController {
  @override
  ServicesState build() {
    _load();
    return const ServicesState(isLoading: true);
  }

  Future<void> _load() async {
    try {
      final repo = ref.read(servicesRepositoryProvider);
      final results = await Future.wait([
        repo.getServices(),
        repo.getCategories(),
      ]);
      state = state.copyWith(
        isLoading: false,
        services: results[0] as List<ServiceDto>,
        categories: results[1] as List<ServiceCategoryDto>,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> selectCategory(ServiceCategoryDto? cat) async {
    state = state.copyWith(selectedCategory: cat, isLoading: true);
    try {
      final services = await ref
          .read(servicesRepositoryProvider)
          .getServices(categoryId: cat?.id);
      state = state.copyWith(isLoading: false, services: services);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> refresh() => _load();
}

// Single-service detail provider
@riverpod
Future<ServiceDto> serviceDetail(ServiceDetailRef ref, int id) =>
    ref.watch(servicesRepositoryProvider).getService(id);
