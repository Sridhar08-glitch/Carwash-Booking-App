// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$serviceDetailHash() => r'f21aac0d497bcc11c0ca92998b9df01cc5dbb90a';

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

/// See also [serviceDetail].
@ProviderFor(serviceDetail)
const serviceDetailProvider = ServiceDetailFamily();

/// See also [serviceDetail].
class ServiceDetailFamily extends Family<AsyncValue<ServiceDto>> {
  /// See also [serviceDetail].
  const ServiceDetailFamily();

  /// See also [serviceDetail].
  ServiceDetailProvider call(
    int id,
  ) {
    return ServiceDetailProvider(
      id,
    );
  }

  @override
  ServiceDetailProvider getProviderOverride(
    covariant ServiceDetailProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'serviceDetailProvider';
}

/// See also [serviceDetail].
class ServiceDetailProvider extends AutoDisposeFutureProvider<ServiceDto> {
  /// See also [serviceDetail].
  ServiceDetailProvider(
    int id,
  ) : this._internal(
          (ref) => serviceDetail(
            ref as ServiceDetailRef,
            id,
          ),
          from: serviceDetailProvider,
          name: r'serviceDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$serviceDetailHash,
          dependencies: ServiceDetailFamily._dependencies,
          allTransitiveDependencies:
              ServiceDetailFamily._allTransitiveDependencies,
          id: id,
        );

  ServiceDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  Override overrideWith(
    FutureOr<ServiceDto> Function(ServiceDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ServiceDetailProvider._internal(
        (ref) => create(ref as ServiceDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ServiceDto> createElement() {
    return _ServiceDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ServiceDetailProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ServiceDetailRef on AutoDisposeFutureProviderRef<ServiceDto> {
  /// The parameter `id` of this provider.
  int get id;
}

class _ServiceDetailProviderElement
    extends AutoDisposeFutureProviderElement<ServiceDto> with ServiceDetailRef {
  _ServiceDetailProviderElement(super.provider);

  @override
  int get id => (origin as ServiceDetailProvider).id;
}

String _$servicesControllerHash() =>
    r'5a4b6a348764f5d04b05582956209debfc507f2d';

/// See also [ServicesController].
@ProviderFor(ServicesController)
final servicesControllerProvider =
    AutoDisposeNotifierProvider<ServicesController, ServicesState>.internal(
  ServicesController.new,
  name: r'servicesControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$servicesControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ServicesController = AutoDisposeNotifier<ServicesState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
