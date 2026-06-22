// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payments_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$paymentsRepositoryHash() =>
    r'182b684225aaa234f0b5e2496cb7719f9e7ce430';

/// See also [paymentsRepository].
@ProviderFor(paymentsRepository)
final paymentsRepositoryProvider =
    AutoDisposeProvider<PaymentsRepository>.internal(
  paymentsRepository,
  name: r'paymentsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$paymentsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PaymentsRepositoryRef = AutoDisposeProviderRef<PaymentsRepository>;
String _$walletHash() => r'7285d264ad6634aea9e54722a0bc06fa45e985c5';

/// See also [wallet].
@ProviderFor(wallet)
final walletProvider = AutoDisposeFutureProvider<WalletDto>.internal(
  wallet,
  name: r'walletProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$walletHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WalletRef = AutoDisposeFutureProviderRef<WalletDto>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
