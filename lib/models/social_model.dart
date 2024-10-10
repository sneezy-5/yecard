import 'package:json_annotation/json_annotation.dart';

part 'social_model.g.dart';

@JsonSerializable()
class SocialData {
  final int id;
  final String nom;
  final String lien;
  final String user;

  SocialData({
    required this.id,
    required this.nom,
    required this.lien,
    required this.user,
  });

  factory SocialData.fromJson(Map<String, dynamic> json) => _$SocialDataFromJson(json);

  Map<String, dynamic> toJson() => _$SocialDataToJson(this);
}