import 'package:json_annotation/json_annotation.dart';

part 'password_reset.g.dart';

@JsonSerializable()
class PasswordResetData {
  final String newpassword;
  final String confirmPassword;

  PasswordResetData({
    required this.newpassword,
    required this.confirmPassword


  });

  factory PasswordResetData.fromJson(Map<String, dynamic> json) => _$PasswordResetDataFromJson(json);

  Map<String, dynamic> toJson() => _$PasswordResetDataToJson(this);
}
