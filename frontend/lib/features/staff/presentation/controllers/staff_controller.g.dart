// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$staffJobsControllerHash() =>
    r'47af77e3824731338b3e8489b3043e1fbfd18dbd';

/// See also [StaffJobsController].
@ProviderFor(StaffJobsController)
final staffJobsControllerProvider = AutoDisposeAsyncNotifierProvider<
    StaffJobsController, List<StaffJobListItemDto>>.internal(
  StaffJobsController.new,
  name: r'staffJobsControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$staffJobsControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$StaffJobsController
    = AutoDisposeAsyncNotifier<List<StaffJobListItemDto>>;
String _$staffJobControllerHash() =>
    r'23784f9ffc14a1e60344582c95f2e83423a305f4';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$StaffJobController
    extends BuildlessAutoDisposeAsyncNotifier<StaffJobState> {
  late final int bookingId;

  FutureOr<StaffJobState> build(
    int bookingId,
  );
}

/// See also [StaffJobController].
@ProviderFor(StaffJobController)
const staffJobControllerProvider = StaffJobControllerFamily();

/// See also [StaffJobController].
class StaffJobControllerFamily extends Family<AsyncValue<StaffJobState>> {
  /// See also [StaffJobController].
  const StaffJobControllerFamily();

  /// See also [StaffJobController].
  StaffJobControllerProvider call(
    int bookingId,
  ) {
    return StaffJobControllerProvider(
      bookingId,
    );
  }

  @override
  StaffJobControllerProvider getProviderOverride(
    covariant StaffJobControllerProvider provider,
  ) {
    return call(
      provider.bookingId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'staffJobControllerProvider';
}

/// See also [StaffJobController].
class StaffJobControllerProvider extends AutoDisposeAsyncNotifierProviderImpl<
    StaffJobController, StaffJobState> {
  /// See also [StaffJobController].
  StaffJobControllerProvider(
    int bookingId,
  ) : this._internal(
          () => StaffJobController()..bookingId = bookingId,
          from: staffJobControllerProvider,
          name: r'staffJobControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$staffJobControllerHash,
          dependencies: StaffJobControllerFamily._dependencies,
          allTransitiveDependencies:
              StaffJobControllerFamily._allTransitiveDependencies,
          bookingId: bookingId,
        );

  StaffJobControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.bookingId,
  }) : super.internal();

  final int bookingId;

  @override
  FutureOr<StaffJobState> runNotifierBuild(
    covariant StaffJobController notifier,
  ) {
    return notifier.build(
      bookingId,
    );
  }

  @override
  Override overrideWith(StaffJobController Function() create) {
    return ProviderOverride(
      origin: this,
      override: StaffJobControllerProvider._internal(
        () => create()..bookingId = bookingId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        bookingId: bookingId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<StaffJobController, StaffJobState>
      createElement() {
    return _StaffJobControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StaffJobControllerProvider && other.bookingId == bookingId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, bookingId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin StaffJobControllerRef
    on AutoDisposeAsyncNotifierProviderRef<StaffJobState> {
  /// The parameter `bookingId` of this provider.
  int get bookingId;
}

class _StaffJobControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<StaffJobController,
        StaffJobState> with StaffJobControllerRef {
  _StaffJobControllerProviderElement(super.provider);

  @override
  int get bookingId => (origin as StaffJobControllerProvider).bookingId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
