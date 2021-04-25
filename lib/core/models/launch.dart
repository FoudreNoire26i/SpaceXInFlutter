import 'package:json_annotation/json_annotation.dart';

import 'links.dart';

part 'launch.g.dart';
@JsonSerializable(
    checked: true, explicitToJson: true, fieldRename: FieldRename.snake)
class Launch {
  String id;
  String name;
  bool success;
  int date_unix;
  String date_local;
  String date_utc;
  @JsonKey(name: "details")
  String description;
  Links links;

  Launch();

  factory Launch.fromJson(Map<String, dynamic> json) => _$LaunchFromJson(json);

  Map<String, dynamic> toJson() => _$LaunchToJson(this);
}
