// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'links.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Links _$LinksFromJson(Map<String, dynamic> json) {
  return $checkedNew('Links', json, () {
    final val = Links();
    $checkedConvert(json, 'webcast', (v) => val.videoUrl = v as String);
    $checkedConvert(json, 'article', (v) => val.articleUrl = v as String);
    $checkedConvert(json, 'wikipedia', (v) => val.wikipediaUrl = v as String);
    $checkedConvert(
        json,
        'patch',
        (v) => val.patch =
            v == null ? null : Patch.fromJson(v as Map<String, dynamic>));
    return val;
  }, fieldKeyMap: const {
    'videoUrl': 'webcast',
    'articleUrl': 'article',
    'wikipediaUrl': 'wikipedia'
  });
}

Map<String, dynamic> _$LinksToJson(Links instance) => <String, dynamic>{
      'webcast': instance.videoUrl,
      'article': instance.articleUrl,
      'wikipedia': instance.wikipediaUrl,
      'patch': instance.patch?.toJson(),
    };
