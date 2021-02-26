import 'package:json_annotation/json_annotation.dart';
import 'package:space_x_flutter_app/core/models/patch.dart';

part 'links.g.dart';

@JsonSerializable(
    checked: true, explicitToJson: true, fieldRename: FieldRename.snake)
class Links {
  @JsonKey(name:"webcast")
  String videoUrl;
  @JsonKey(name: "article")
  String articleUrl;
  @JsonKey(name:"wikipedia")
  String wikipediaUrl;
  Patch patch;

  Links();

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);

  Map<String, dynamic> toJson() => _$LinksToJson(this);
}
