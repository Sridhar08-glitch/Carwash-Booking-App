import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connectivity_provider.g.dart';

@riverpod
Stream<bool> connectivity(ConnectivityRef ref) {
  return Connectivity().onConnectivityChanged.map(
    (result) => result != ConnectivityResult.none,
  );
}

/// Synchronous convenience — true if last known state is connected.
@riverpod
bool isOnline(IsOnlineRef ref) {
  final async = ref.watch(connectivityProvider);
  return async.valueOrNull ?? true; // assume online until proven otherwise
}
