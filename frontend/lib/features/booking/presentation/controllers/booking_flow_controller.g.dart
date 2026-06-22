// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_flow_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bookingDetailHash() => r'638ef31f6699a45374ee8112439df54478552080';

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

/// See also [bookingDetail].
@ProviderFor(bookingDetail)
const bookingDetailProvider = BookingDetailFamily();

/// See also [bookingDetail].
class BookingDetailFamily extends Family<AsyncValue<BookingDto>> {
  /// See also [bookingDetail].
  const BookingDetailFamily();

  /// See also [bookingDetail].
  BookingDetailProvider call(
    int id,
  ) {
    return BookingDetailProvider(
      id,
    );
  }

  @override
  BookingDetailProvider getProviderOverride(
    covariant BookingDetailProvider provider,
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
  String? get name => r'bookingDetailProvider';
}

/// See also [bookingDetail].
class BookingDetailProvider extends AutoDisposeFutureProvider<BookingDto> {
  /// See also [bookingDetail].
  BookingDetailProvider(
    int id,
  ) : this._internal(
          (ref) => bookingDetail(
            ref as BookingDetailRef,
            id,
          ),
          from: bookingDetailProvider,
          name: r'bookingDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$bookingDetailHash,
          dependencies: BookingDetailFamily._dependencies,
          allTransitiveDependencies:
              BookingDetailFamily._allTransitiveDependencies,
          id: id,
        );

  BookingDetailProvider._internal(
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
    FutureOr<BookingDto> Function(BookingDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: BookingDetailProvider._internal(
        (ref) => create(ref as BookingDetailRef),
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
  AutoDisposeFutureProviderElement<BookingDto> createElement() {
    return _BookingDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BookingDetailProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin BookingDetailRef on AutoDisposeFutureProviderRef<BookingDto> {
  /// The parameter `id` of this provider.
  int get id;
}

class _BookingDetailProviderElement
    extends AutoDisposeFutureProviderElement<BookingDto> with BookingDetailRef {
  _BookingDetailProviderElement(super.provider);

  @override
  int get id => (origin as BookingDetailProvider).id;
}

String _$bookingFlowControllerHash() =>
    r'9e293635b2bc8c7bf55b73143a4099564c168fb9';

/// See also [BookingFlowController].
@ProviderFor(BookingFlowController)
final bookingFlowControllerProvider = AutoDisposeNotifierProvider<
    BookingFlowController, BookingFlowState>.internal(
  BookingFlowController.new,
  name: r'bookingFlowControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$bookingFlowControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$BookingFlowController = AutoDisposeNotifier<BookingFlowState>;
String _$bookingHistoryControllerHash() =>
    r'9e1e2fad532941ca3862803696bcf2be6c445b4f';

/// See also [BookingHistoryController].
@ProviderFor(BookingHistoryController)
final bookingHistoryControllerProvider = AutoDisposeAsyncNotifierProvider<
    BookingHistoryController, List<BookingListItemDto>>.internal(
  BookingHistoryController.new,
  name: r'bookingHistoryControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$bookingHistoryControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$BookingHistoryController
    = AutoDisposeAsyncNotifier<List<BookingListItemDto>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
