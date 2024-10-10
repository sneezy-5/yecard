// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocialData _$SocialDataFromJson(Map<String, dynamic> json) => SocialData(
      id: (json['id'] as num).toInt(),
      nom: json['nom'] as String,
      lien: json['lien'] as String,
      user: json['user'] as String,
    );

Map<String, dynamic> _$SocialDataToJson(SocialData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nom': instance.nom,
      'lien': instance.lien,
      'user': instance.user,
    };
