import 'package:freezed_annotation/freezed_annotation.dart';

part 'payments_dto.freezed.dart';
part 'payments_dto.g.dart';

// ── Checkout ─────────────────────────────────────────────────────────────────

@freezed
class CheckoutRequestDto with _$CheckoutRequestDto {
  const factory CheckoutRequestDto({
    @JsonKey(name: 'delivery_method') required String deliveryMethod,
    @JsonKey(name: 'shipping_address_id') int? shippingAddressId,
  }) = _CheckoutRequestDto;

  factory CheckoutRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CheckoutRequestDtoFromJson(json);
}

@freezed
class PaymentSummaryDto with _$PaymentSummaryDto {
  const factory PaymentSummaryDto({
    required int id,
    required String method,
    required String status,
  }) = _PaymentSummaryDto;

  factory PaymentSummaryDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentSummaryDtoFromJson(json);
}

@freezed
class CheckoutResponseDto with _$CheckoutResponseDto {
  const factory CheckoutResponseDto({
    required int id,
    required String status,
    required String total,
    @Default('SAR') String currency,
    required PaymentSummaryDto payment,
  }) = _CheckoutResponseDto;

  factory CheckoutResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CheckoutResponseDtoFromJson(json);
}

// ── Payment Intent ────────────────────────────────────────────────────────────

@freezed
class PaymentIntentDto with _$PaymentIntentDto {
  const factory PaymentIntentDto({
    @JsonKey(name: 'client_secret') required String clientSecret,
  }) = _PaymentIntentDto;

  factory PaymentIntentDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentIntentDtoFromJson(json);
}

// ── Wallet ────────────────────────────────────────────────────────────────────

@freezed
class WalletTransactionDto with _$WalletTransactionDto {
  const factory WalletTransactionDto({
    required int id,
    required String type,
    required String amount,
    required String description,
    @JsonKey(name: 'created_at') required String createdAt,
  }) = _WalletTransactionDto;

  factory WalletTransactionDto.fromJson(Map<String, dynamic> json) =>
      _$WalletTransactionDtoFromJson(json);
}

@freezed
class WalletDto with _$WalletDto {
  const factory WalletDto({
    required String balance,
    @Default('SAR') String currency,
    @JsonKey(name: 'recent_transactions')
    @Default([])
    List<WalletTransactionDto> recentTransactions,
  }) = _WalletDto;

  factory WalletDto.fromJson(Map<String, dynamic> json) =>
      _$WalletDtoFromJson(json);
}
