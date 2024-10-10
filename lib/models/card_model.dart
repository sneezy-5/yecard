import 'package:json_annotation/json_annotation.dart';

part 'card_model.g.dart';

@JsonSerializable()
class CardData {
  final String number;

  CardData({
    required this.number,
  });

  factory CardData.fromJson(Map<String, dynamic> json) => _$CardDataFromJson(json);

  Map<String, dynamic> toJson() => _$CardDataToJson(this);
}