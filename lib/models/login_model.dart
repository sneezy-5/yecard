import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModelData {
  final String email;
  final String password;


  LoginModelData({
    required this.email,
    required this.password,


  });

  factory LoginModelData.fromJson(Map<String, dynamic> json) => _$LoginModelDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelDataToJson(this);
}
