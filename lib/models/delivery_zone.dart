import 'package:json_annotation/json_annotation.dart';

part 'delivery_zone.g.dart';

@JsonSerializable()
class DeliveryZone {
  final String name;

  DeliveryZone({required this.name});

  // Méthode générée pour convertir JSON en DeliveryZone
  factory DeliveryZone.fromJson(Map<String, dynamic> json) => _$DeliveryZoneFromJson(json);

  // Méthode générée pour convertir DeliveryZone en JSON
  Map<String, dynamic> toJson() => _$DeliveryZoneToJson(this);
}
