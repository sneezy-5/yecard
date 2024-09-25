// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupData _$SignupDataFromJson(Map<String, dynamic> json) => SignupData(
      name: json['name'] as String,
      position: json['position'] as String,
      company: json['company'] as String,
      biography: json['biography'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      location: json['location'] as String,
      hasCard: json['hasCard'] as bool,
      cardNumber: json['cardNumber'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$SignupDataToJson(SignupData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'position': instance.position,
      'company': instance.company,
      'biography': instance.biography,
      'phone': instance.phone,
      'email': instance.email,
      'location': instance.location,
      'hasCard': instance.hasCard,
      'cardNumber': instance.cardNumber,
      'password': instance.password,
    };
