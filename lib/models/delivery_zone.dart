import 'package:json_annotation/json_annotation.dart';

part 'delivery_zone.g.dart';

@JsonSerializable()
class DeliveryZone {
  final int f_user;
  final String lieu;
  final String reference;
  final String nbr_cart;
  final String phone;


  DeliveryZone({required this.f_user, required  this.reference, required this.nbr_cart, required this.phone, required this.lieu});

  factory DeliveryZone.fromJson(Map<String, dynamic> json) => _$DeliveryZoneFromJson(json);

  // Méthode générée pour convertir DeliveryZone en JSON
  Map<String, dynamic> toJson() => _$DeliveryZoneToJson(this);
}
