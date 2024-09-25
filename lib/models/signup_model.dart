import 'package:json_annotation/json_annotation.dart';

part 'signup_model.g.dart';

@JsonSerializable()
class SignupData {
  final String name;
  final String position;
  final String company;
  final String biography;
  final String phone;
  final String email;
  final String location;
  final bool hasCard;
  final String cardNumber;
  final String password;

  SignupData({
    required this.name,
    required this.position,
    required this.company,
    required this.biography,
    required this.phone,
    required this.email,
    required this.location,
    required this.hasCard,
    required this.cardNumber,
    required this.password,

  });

  factory SignupData.fromJson(Map<String, dynamic> json) => _$SignupDataFromJson(json);

  Map<String, dynamic> toJson() => _$SignupDataToJson(this);
}
