// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PortfolioData _$PortfolioDataFromJson(Map<String, dynamic> json) =>
    PortfolioData(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      file_1: json['file_1'] as String,
      file_2: json['file_2'] as String,
      file_3: json['file_3'] as String,
      mot_de_fin: json['mot_de_fin'] as String,
    );

Map<String, dynamic> _$PortfolioDataToJson(PortfolioData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'file_1': instance.file_1,
      'file_2': instance.file_2,
      'file_3': instance.file_3,
      'mot_de_fin': instance.mot_de_fin,
    };
