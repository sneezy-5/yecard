import 'package:json_annotation/json_annotation.dart';

part 'portfolio.g.dart';

@JsonSerializable()
class PortfolioData {
  final int id;
  final String title;
  final String description;
  final String file_1;
  final String file_2;
  final String file_3;
  final String mot_de_fin;

  PortfolioData({
    required this.id,
    required this.title,
    required this.description,
    required this.file_1,
    required this.file_2,
    required this.file_3,
    required this.mot_de_fin,


  });

  factory PortfolioData.fromJson(Map<String, dynamic> json) => _$PortfolioDataFromJson(json);

  Map<String, dynamic> toJson() => _$PortfolioDataToJson(this);
}
