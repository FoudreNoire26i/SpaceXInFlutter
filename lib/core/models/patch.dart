import 'package:json_annotation/json_annotation.dart';

part 'patch.g.dart';

@JsonSerializable(
    checked: true, explicitToJson: true, fieldRename: FieldRename.snake)
class Patch {
  @JsonKey(name:"large")
  String imageFullUrl;
  @JsonKey(name: "small")
  String imageLargeUrl;

  Patch();

  factory Patch.fromJson(Map<String, dynamic> json) => _$PatchFromJson(json);

  Map<String, dynamic> toJson() => _$PatchToJson(this);
}
