import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileData {
  final int id;
  final String name;
  final String fonction;
  final String entreprise;
  final String biographie;
  final String phone;
  final String email;
  final String localisation;

  ProfileData({
    required this.id,
    required this.name,
    required this.fonction,
    required this.entreprise,
    required this.biographie,
    required this.phone,
    required this.email,
    required this.localisation,


  });

  factory ProfileData.fromJson(Map<String, dynamic> json) => _$ProfileDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDataToJson(this);
}
