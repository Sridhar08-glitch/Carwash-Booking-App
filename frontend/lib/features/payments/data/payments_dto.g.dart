// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payments_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CheckoutRequestDtoImpl _$$CheckoutRequestDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$CheckoutRequestDtoImpl(
      deliveryMethod: json['delivery_method'] as String,
      shippingAddressId: (json['shipping_address_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$CheckoutRequestDtoImplToJson(
        _$CheckoutRequestDtoImpl instance) =>
    <String, dynamic>{
      'delivery_method': instance.deliveryMethod,
      'shipping_address_id': instance.shippingAddressId,
    };

_$PaymentSummaryDtoImpl _$$PaymentSummaryDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$PaymentSummaryDtoImpl(
      id: (json['id'] as num).toInt(),
      method: json['method'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$$PaymentSummaryDtoImplToJson(
        _$PaymentSummaryDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'method': instance.method,
      'status': instance.status,
    };

_$CheckoutResponseDtoImpl _$$CheckoutResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$CheckoutResponseDtoImpl(
      id: (json['id'] as num).toInt(),
      status: json['status'] as String,
      total: json['total'] as String,
      currency: json['currency'] as String? ?? 'SAR',
      payment:
          PaymentSummaryDto.fromJson(json['payment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CheckoutResponseDtoImplToJson(
        _$CheckoutResponseDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'total': instance.total,
      'currency': instance.currency,
      'payment': instance.payment,
    };

_$PaymentIntentDtoImpl _$$PaymentIntentDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$PaymentIntentDtoImpl(
      clientSecret: json['client_secret'] as String,
    );

Map<String, dynamic> _$$PaymentIntentDtoImplToJson(
        _$PaymentIntentDtoImpl instance) =>
    <String, dynamic>{
      'client_secret': instance.clientSecret,
    };

_$WalletTransactionDtoImpl _$$WalletTransactionDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$WalletTransactionDtoImpl(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String,
      amount: json['amount'] as String,
      description: json['description'] as String,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$$WalletTransactionDtoImplToJson(
        _$WalletTransactionDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'amount': instance.amount,
      'description': instance.description,
      'created_at': instance.createdAt,
    };

_$WalletDtoImpl _$$WalletDtoImplFromJson(Map<String, dynamic> json) =>
    _$WalletDtoImpl(
      balance: json['balance'] as String,
      currency: json['currency'] as String? ?? 'SAR',
      recentTransactions: (json['recent_transactions'] as List<dynamic>?)
              ?.map((e) =>
                  WalletTransactionDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$WalletDtoImplToJson(_$WalletDtoImpl instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'currency': instance.currency,
      'recent_transactions': instance.recentTransactions,
    };
