// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileData _$ProfileDataFromJson(Map<String, dynamic> json) => ProfileData(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      fonction: json['fonction'] as String,
      entreprise: json['entreprise'] as String,
      biographie: json['biographie'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      localisation: json['localisation'] as String,
    );

Map<String, dynamic> _$ProfileDataToJson(ProfileData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'fonction': instance.fonction,
      'entreprise': instance.entreprise,
      'biographie': instance.biographie,
      'phone': instance.phone,
      'email': instance.email,
      'localisation': instance.localisation,
    };
