// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupData _$SignupDataFromJson(Map<String, dynamic> json) => SignupData(
      name: json['name'] as String,
      fonction: json['fonction'] as String,
      entreprise: json['entreprise'] as String,
      biographie: json['biographie'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      localisation: json['localisation'] as String,
      hasCard: json['hasCard'] as bool,
      cardNumber: json['cardNumber'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$SignupDataToJson(SignupData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'fonction': instance.fonction,
      'entreprise': instance.entreprise,
      'biographie': instance.biographie,
      'phone': instance.phone,
      'email': instance.email,
      'localisation': instance.localisation,
      'hasCard': instance.hasCard,
      'cardNumber': instance.cardNumber,
      'password': instance.password,
    };
