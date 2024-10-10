// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_zone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryZone _$DeliveryZoneFromJson(Map<String, dynamic> json) => DeliveryZone(
      f_user: (json['f_user'] as num).toInt(),
      reference: json['reference'] as String,
      nbr_cart: json['nbr_cart'] as String,
      phone: json['phone'] as String,
      lieu: json['lieu'] as String,
    );

Map<String, dynamic> _$DeliveryZoneToJson(DeliveryZone instance) =>
    <String, dynamic>{
      'f_user': instance.f_user,
      'lieu': instance.lieu,
      'reference': instance.reference,
      'nbr_cart': instance.nbr_cart,
      'phone': instance.phone,
    };
