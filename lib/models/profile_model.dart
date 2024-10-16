import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileData {
  final int id;
  final String? name;
  final String? fonction;
  final String? entreprise;
  final String? biographie;
  final String? phone;
  final String? email;
  final String? address;
  final String? site_url;
  final String? localisation;
  final String? profile_image;
  final String? banier;

  ProfileData({
    required this.id,
    this.name,
    this.fonction,
    this.entreprise,
    this.biographie,
    this.address,
    this.site_url,
    this.phone,
    this.email,
    this.localisation,
    this.profile_image,
    this.banier,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) => _$ProfileDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDataToJson(this);
}
