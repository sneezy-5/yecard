// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactData _$ContactDataFromJson(Map<String, dynamic> json) => ContactData(
      from_user: (json['from_user'] as num?)?.toInt(),
      to_user: (json['to_user'] as num).toInt(),
    );

Map<String, dynamic> _$ContactDataToJson(ContactData instance) =>
    <String, dynamic>{
      'from_user': instance.from_user,
      'to_user': instance.to_user,
    };
