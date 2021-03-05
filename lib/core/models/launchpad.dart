import 'package:json_annotation/json_annotation.dart';


part 'launchpad.g.dart';

@JsonSerializable(
    checked: true, explicitToJson: true, fieldRename: FieldRename.snake)
class LaunchPad {
  String id;
  String name;
  @JsonKey(name: "full_name")
  String fullName;

  double longitude;
  double latitude;

  @JsonKey(name: "launch_attempts")
  int launchAttempts;

  @JsonKey(name: "launch_successes")
  int launchSuccesses;

  @JsonKey(name: "rockets")
  List<String> rocketIds;

  String details;
  String status;

  LaunchPad();

  factory LaunchPad.fromJson(Map<String, dynamic> json) => _$LaunchPadFromJson(json);

  Map<String, dynamic> toJson() => _$LaunchPadToJson(this);
}
