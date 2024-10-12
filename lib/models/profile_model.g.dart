// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileData _$ProfileDataFromJson(Map<String, dynamic> json) => ProfileData(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      fonction: json['fonction'] as String?,
      entreprise: json['entreprise'] as String?,
      biographie: json['biographie'] as String?,
      address: json['address'] as String?,
      site_url: json['site_url'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      localisation: json['localisation'] as String?,
      profile_image: json['profile_image'] as String?,
      banier: json['banier'] as String?,
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
      'address': instance.address,
      'site_url': instance.site_url,
      'localisation': instance.localisation,
      'profile_image': instance.profile_image,
      'banier': instance.banier,
    };
