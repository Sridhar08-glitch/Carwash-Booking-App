// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loyalty_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$loyaltyRepositoryHash() => r'67fdd1db8ccfffee22a02b0a79ff7746eaee33f0';

/// See also [loyaltyRepository].
@ProviderFor(loyaltyRepository)
final loyaltyRepositoryProvider =
    AutoDisposeProvider<LoyaltyRepository>.internal(
  loyaltyRepository,
  name: r'loyaltyRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$loyaltyRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LoyaltyRepositoryRef = AutoDisposeProviderRef<LoyaltyRepository>;
String _$loyaltyStatusHash() => r'046dc059f69efb29c9b2ea9d68dd67f6cd2934de';

/// See also [loyaltyStatus].
@ProviderFor(loyaltyStatus)
final loyaltyStatusProvider =
    AutoDisposeFutureProvider<LoyaltyStatusDto>.internal(
  loyaltyStatus,
  name: r'loyaltyStatusProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$loyaltyStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LoyaltyStatusRef = AutoDisposeFutureProviderRef<LoyaltyStatusDto>;
String _$referralsHash() => r'1c754027b4aa920031b89b0b7954ca762fa3912b';

/// See also [referrals].
@ProviderFor(referrals)
final referralsProvider = AutoDisposeFutureProvider<ReferralDto>.internal(
  referrals,
  name: r'referralsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$referralsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ReferralsRef = AutoDisposeFutureProviderRef<ReferralDto>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
