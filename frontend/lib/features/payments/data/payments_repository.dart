import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../core/error/error_mapper.dart';
import '../../../core/network/dio_client.dart';
import 'payments_dto.dart';

part 'payments_repository.g.dart';

const _uuid = Uuid();

@riverpod
PaymentsRepository paymentsRepository(PaymentsRepositoryRef ref) =>
    PaymentsRepository(ref.watch(dioProvider));

@riverpod
Future<WalletDto> wallet(WalletRef ref) =>
    ref.watch(paymentsRepositoryProvider).getWallet();

class PaymentsRepository {
  PaymentsRepository(this._dio);
  final Dio _dio;

  Future<CheckoutResponseDto> checkout({
    required String deliveryMethod,
    int? shippingAddressId,
  }) async {
    try {
      final key = _uuid.v4();
      final dto = CheckoutRequestDto(
        deliveryMethod: deliveryMethod,
        shippingAddressId: shippingAddressId,
      );
      final r = await _dio.post<Map<String, dynamic>>(
        '/orders/checkout',
        data: dto.toJson(),
        options: Options(extra: {'idempotencyKey': key, 'idempotent': true}),
      );
      return CheckoutResponseDto.fromJson(r.data!);
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }

  Future<PaymentIntentDto> createPaymentIntent(int paymentId) async {
    try {
      final key = _uuid.v4();
      final r = await _dio.post<Map<String, dynamic>>(
        '/payments/intent',
        data: {'payment_id': paymentId},
        options: Options(extra: {'idempotencyKey': key, 'idempotent': true}),
      );
      return PaymentIntentDto.fromJson(r.data!);
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }

  Future<void> confirmWalletPayment(int paymentId) async {
    try {
      await _dio.post<void>(
        '/payments/confirm',
        data: {'payment_id': paymentId},
      );
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }

  Future<WalletDto> getWallet() async {
    try {
      final r = await _dio.get<Map<String, dynamic>>('/payments/wallet');
      return WalletDto.fromJson(r.data!);
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }
}
