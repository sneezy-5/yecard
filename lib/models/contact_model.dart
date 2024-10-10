import 'package:json_annotation/json_annotation.dart';

part 'contact_model.g.dart';

@JsonSerializable()
class ContactData {
  final String from_user;
  final String to_user;

  ContactData({
    required this.from_user,
    required this.to_user,
  });

  factory ContactData.fromJson(Map<String, dynamic> json) => _$ContactDataFromJson(json);

  Map<String, dynamic> toJson() => _$ContactDataToJson(this);
}