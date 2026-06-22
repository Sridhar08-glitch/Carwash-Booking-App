import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../services/data/services_dto.dart';
import '../../data/home_dto.dart';
import '../../data/home_repository.dart';

part 'home_controller.freezed.dart';
part 'home_controller.g.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default([]) List<HomeSectionDto> layout,
    @Default([]) List<ServiceDto> services,
    @Default(true) bool isLoading,
    String? errorMessage,
  }) = _HomeState;
}

@riverpod
class HomeController extends _$HomeController {
  @override
  HomeState build() {
    _load();
    return const HomeState();
  }

  Future<void> _load() async {
    // NOTE: do NOT touch `state` here before the first await —
    // `_load` is called synchronously from `build()` before the
    // provider is initialised, so reading `.state` at this point
    // throws "Tried to read the state of an uninitialized provider".
    // The initial HomeState already defaults isLoading:true, so no
    // reset is needed for the first load.  refresh() handles its own reset.
    try {
      final repo = ref.read(homeRepositoryProvider);
      final results = await Future.wait([
        repo.getHomeLayout(),
        repo.getServiceRailData(),
      ]);
      state = state.copyWith(
        isLoading: false,
        layout: results[0] as List<HomeSectionDto>,
        services: results[1] as List<ServiceDto>,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> refresh() async {
    // Safe to reset state here — provider is already initialised by this point.
    state = state.copyWith(isLoading: true, errorMessage: null);
    await _load();
  }
}
