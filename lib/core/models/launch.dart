import 'package:json_annotation/json_annotation.dart';

import 'links.dart';

part 'launch.g.dart';
@JsonSerializable(
    checked: true, explicitToJson: true, fieldRename: FieldRename.snake)
class Launch {
  String id;
  String name;
  bool success;
  @JsonKey(name: "date_unix")
  int date;
  @JsonKey(name: "details")
  String description;
  Links links;

  Launch();

  factory Launch.fromJson(Map<String, dynamic> json) => _$LaunchFromJson(json);

  Map<String, dynamic> toJson() => _$LaunchToJson(this);
}
