// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patch _$PatchFromJson(Map<String, dynamic> json) {
  return $checkedNew('Patch', json, () {
    final val = Patch();
    $checkedConvert(json, 'large', (v) => val.imageLargeUrl = v as String);
    $checkedConvert(json, 'small', (v) => val.imageSmallUrl = v as String);
    return val;
  }, fieldKeyMap: const {'imageLargeUrl': 'large', 'imageSmallUrl': 'small'});
}

Map<String, dynamic> _$PatchToJson(Patch instance) => <String, dynamic>{
      'large': instance.imageLargeUrl,
      'small': instance.imageSmallUrl,
    };
