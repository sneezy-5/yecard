// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_reset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PasswordResetData _$PasswordResetDataFromJson(Map<String, dynamic> json) =>
    PasswordResetData(
      newpassword: json['newpassword'] as String,
      confirmPassword: json['confirmPassword'] as String,
    );

Map<String, dynamic> _$PasswordResetDataToJson(PasswordResetData instance) =>
    <String, dynamic>{
      'newpassword': instance.newpassword,
      'confirmPassword': instance.confirmPassword,
    };
