import 'package:json_annotation/json_annotation.dart';

part 'signup_model.g.dart';

@JsonSerializable()
class SignupData {
  final String name;
  final String fonction;
  final String entreprise;
  final String biographie;
  final String phone;
  final String email;
  final String localisation;
  final bool hasCard;
  final String cardNumber;
  final String password;

  SignupData({
    required this.name,
    required this.fonction,
    required this.entreprise,
    required this.biographie,
    required this.phone,
    required this.email,
    required this.localisation,
    required this.hasCard,
    required this.cardNumber,
    required this.password,

  });

  factory SignupData.fromJson(Map<String, dynamic> json) => _$SignupDataFromJson(json);

  Map<String, dynamic> toJson() => _$SignupDataToJson(this);
}
