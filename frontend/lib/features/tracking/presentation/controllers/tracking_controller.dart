import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../../core/auth/token_store.dart';
import '../../../../core/config/app_config.dart';
import '../../../../core/config/providers.dart';
import '../../data/tracking_dto.dart';

// Manual freezed-like state since we need it without the annotation in this file
class _TrackingState {
  const _TrackingState({
    this.lat,
    this.lng,
    this.etaMinutes,
    this.bookingStatus,
    this.isConnected = false,
    this.error,
  });
  final double? lat;
  final double? lng;
  final int? etaMinutes;
  final String? bookingStatus;
  final bool isConnected;
  final String? error;

  _TrackingState copyWith({
    double? lat,
    double? lng,
    int? etaMinutes,
    String? bookingStatus,
    bool? isConnected,
    String? error,
  }) =>
      _TrackingState(
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
        etaMinutes: etaMinutes ?? this.etaMinutes,
        bookingStatus: bookingStatus ?? this.bookingStatus,
        isConnected: isConnected ?? this.isConnected,
        error: error ?? this.error,
      );
}

// Simple provider that creates and manages a WebSocket connection
final trackingControllerProvider =
    StateNotifierProvider.autoDispose.family<TrackingController, _TrackingState, int>(
  (ref, bookingId) => TrackingController(ref, bookingId),
);

class TrackingController extends StateNotifier<_TrackingState> {
  TrackingController(this._ref, this._bookingId) : super(const _TrackingState()) {
    _connect();
  }

  final Ref _ref;
  final int _bookingId;
  WebSocketChannel? _channel;
  StreamSubscription? _sub;

  Future<void> _connect() async {
    final config = _ref.read(appConfigProvider);
    final tokenStore = _ref.read(tokenStoreProvider);
    final token = await tokenStore.readAccess();

    if (token == null) {
      state = state.copyWith(error: 'Not authenticated');
      return;
    }

    final uri = Uri.parse(
      '${config.wsBaseUrl}/track/$_bookingId/?token=$token',
    );

    try {
      _channel = WebSocketChannel.connect(uri);
      state = state.copyWith(isConnected: true);

      _sub = _channel!.stream.listen(
        (raw) {
          final Map<String, dynamic> msg =
              jsonDecode(raw as String) as Map<String, dynamic>;
          final type = msg['type'] as String?;

          if (type == 'ping') {
            state = state.copyWith(
              lat: (msg['lat'] as num).toDouble(),
              lng: (msg['lng'] as num).toDouble(),
              etaMinutes: msg['eta_minutes'] as int?,
            );
          } else if (type == 'status') {
            state = state.copyWith(
              bookingStatus: msg['booking_status'] as String?,
            );
          }
        },
        onError: (_) => state = state.copyWith(
          isConnected: false,
          error: 'Connection lost',
        ),
        onDone: () => state = state.copyWith(isConnected: false),
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    _channel?.sink.close();
    super.dispose();
  }
}
