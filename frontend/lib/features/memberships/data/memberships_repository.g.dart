// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memberships_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$membershipsRepositoryHash() =>
    r'6f0a0cc4f2bc3664a9f694f5866620c2e36de328';

/// See also [membershipsRepository].
@ProviderFor(membershipsRepository)
final membershipsRepositoryProvider =
    AutoDisposeProvider<MembershipsRepository>.internal(
  membershipsRepository,
  name: r'membershipsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$membershipsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MembershipsRepositoryRef
    = AutoDisposeProviderRef<MembershipsRepository>;
String _$membershipPlansHash() => r'55f4222477b88c48c46bd59741de7de3682de0f6';

/// See also [membershipPlans].
@ProviderFor(membershipPlans)
final membershipPlansProvider =
    AutoDisposeFutureProvider<List<MembershipPlanDto>>.internal(
  membershipPlans,
  name: r'membershipPlansProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$membershipPlansHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MembershipPlansRef
    = AutoDisposeFutureProviderRef<List<MembershipPlanDto>>;
String _$myMembershipHash() => r'fbb40624ab05875dbe7833119e94eba88882144f';

/// See also [myMembership].
@ProviderFor(myMembership)
final myMembershipProvider =
    AutoDisposeFutureProvider<MyMembershipDto?>.internal(
  myMembership,
  name: r'myMembershipProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$myMembershipHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MyMembershipRef = AutoDisposeFutureProviderRef<MyMembershipDto?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
